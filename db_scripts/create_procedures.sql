USE lead_management;

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS sp_AltaLead(
	IN json_input JSON,
	IN clave_encriptacion VARCHAR(255)
)

BEGIN
	DECLARE campana INT;
   DECLARE carga VARCHAR(255);
   
   SET campana = JSON_UNQUOTE(JSON_EXTRACT(json_input,'$.campana'));
   
   SELECT spcarga_ws_salesland_leads INTO carga
   FROM aux_campanas
   WHERE ident = campana;
   
   SET @query = CONCAT('CALL ', carga, '(', json_input, ');');
   PREPARE stmt FROM @query;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
   
   CALL sp_disociar(clave_encriptacion);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_Disociar(
    IN clave_encriptacion VARCHAR(255)
)
BEGIN
    DECLARE dato_original VARCHAR(255);
    DECLARE dato_encriptado VARCHAR(255);
    DECLARE done INT DEFAULT 0;
    
    DECLARE cur CURSOR FOR SELECT campo FROM AUX_DISOCIAR;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO dato_original;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET dato_encriptado = AES_ENCRYPT(dato_original, clave_encriptacion);

        INSERT INTO WS_LEADS_DISOCIADOS (dato_encriptado)
        VALUES (dato_encriptado);
    END LOOP;
    CLOSE cur;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_vDisociados(
    IN clave_encriptacion VARCHAR(255)
)
BEGIN
    SELECT campo1, campo2, AES_DECRYPT(dato_encriptado, clave_encriptacion) AS dato_original
    FROM vWS_LEADS_DISOCIADOS;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_Recargar()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE v_estado_destino INT;

    DECLARE cur CURSOR FOR
        SELECT id FROM WS_LEADS WHERE cargado = 0 AND id_unico IS NOT NULL;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET v_estado_destino = 1;

        IF v_estado_destino = 1 THEN
            CALL sp_AltaLead(v_id);
        END IF;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE update_id_unico()
BEGIN
    UPDATE ws_leads
    SET id_unico = CONCAT(cod_proveedor, 'CAP', LPAD(ident, 9, '0'))
    WHERE id_unico IS NULL OR id_unico = '';
END //

DELIMITER ;

USE lead_management;

DELIMITER //

CREATE EVENT IF NOT EXISTS update_id_unico_event
ON SCHEDULE EVERY 1 MINUTE
DO
   CALL update_id_unico();

DELIMITER ;


DELIMITER //

CREATE EVENT IF NOT EXISTS ejecutar_sp_recargar
ON SCHEDULE EVERY 10 MINUTE
DO
BEGIN
    CALL sp_Recargar();
END //

DELIMITER ;
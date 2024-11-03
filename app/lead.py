from datetime import datetime

class Lead:
    def __init__(self,id,campana,cod_proveedor,fecha_captacion,nombre,ape1,ape2,nif,telefono,email,direccion,codigo_postal,poblacion,provincia,acepta1,acepta2,acepta3,num1,num2,num3,dual1,dual2,dual3,variable1,variable2,variable3,memo,fecha,hora,foto1,foto2,comercial,centro):
        self.id = id
        self.campana = campana
        self.cod_proveedor = cod_proveedor
        self.fecha_captacion = fecha_captacion
        self.nombre = nombre
        self.ape1 = ape1
        self.ape2 = ape2
        self.nif = nif
        self.telefono = telefono
        self.email = email
        self.direccion = direccion
        self.codigo_postal = codigo_postal
        self.poblacion = poblacion
        self.provincia = provincia
        self.acepta1 = acepta1
        self.acepta2 = acepta2
        self.acepta3 = acepta3
        self.num1 = num1
        self.num2 = num2
        self.num3 = num3
        self.dual1 = dual1
        self.dual2 = dual2
        self.dual3 = dual3
        self.variable1 = variable1
        self.variable2 = variable2
        self.variable3 = variable3
        self.memo = memo
        self.fecha = fecha
        self.hora = hora
        self.foto1 = foto1
        self.foto2 = foto2
        self.comercial = comercial
        self.centro = centro

    def to_dict(self):
        params = vars(self)
        
        if 'fecha_captacion' in params:
                self.__format_date(params)
        
        return params
    
    def __format_date(self, params):
        if isinstance(params['fecha_captacion'], str):
            try:
                fecha_captacion = datetime.strptime(params['fecha_captacion'], '%Y-%m-%d %H:%M:%S')
            except ValueError:
                try:
                    fecha_captacion = datetime.strptime(params['fecha_captacion'], '%Y%m%d %H:%M')
                except ValueError as error:
                    print(f"Error al convertir la fecha_captacion: {params['fecha_captacion']}: {error}")
                    return None    
            
            params['fecha_captacion'] = fecha_captacion.strftime('%Y-%m-%d %H:%M:%S')
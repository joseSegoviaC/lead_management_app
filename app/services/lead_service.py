from ..database import Database
from ..api.salesland_api_client import SaleslandAPI
from ..lead import Lead
import json

class LeadService:
    def __init__(self, db: Database, api_client: SaleslandAPI):
        self.db = db
        self.api_client = api_client

    def insert_lead(self, lead: Lead):
        query = """
            INSERT INTO ws_leads (id, campana, cod_proveedor, fecha_captacion, nombre, ape1, ape2, nif, telefono, email,
                                direccion, codigo_postal, poblacion, provincia, acepta1, acepta2, acepta3, num1, num2,
                                num3, dual1, dual2, dual3, variable1, variable2, variable3, memo, fecha, hora, foto1,
                                foto2, comercial, centro)                
            VALUES (%(id)s, %(campana)s, %(cod_proveedor)s, %(fecha_captacion)s, %(nombre)s, %(ape1)s, %(ape2)s,
                    %(nif)s, %(telefono)s, %(email)s, %(direccion)s, %(codigo_postal)s, %(poblacion)s, %(provincia)s,
                    %(acepta1)s, %(acepta2)s, %(acepta3)s, %(num1)s, %(num2)s, %(num3)s, %(dual1)s, %(dual2)s,
                    %(dual3)s, %(variable1)s, %(variable2)s, %(variable3)s, %(memo)s, %(fecha)s, %(hora)s, %(foto1)s,
                    %(foto2)s, %(comercial)s, %(centro)s);
        """
        
        self.db.execute_query(query, lead.to_dict())

    def retrieve_pending_leads(self):
        query = "SELECT * FROM ws_leads WHERE cargado = 0 AND id_unico IS NOT NULL;"
        cursor = self.db.execute_query(query)
        leads = cursor.fetchall() if cursor else []
        cursor.close()
        return leads
    
    def process_leads(self):
        leads = self.retrieve_pending_leads()
        keys_needed = [
            'id',
            'campana',
            'cod_proveedor',
            'fecha_captacion',
            'nombre',
            'ape1',
            'ape2',
            'nif',
            'telefono',
            'email',
            'direccion',
            'codigo_postal',
            'poblacion',
            'provincia',
            'acepta1',
            'acepta2',
            'acepta3',
            'num1',
            'num2',
            'num3',
            'dual1',
            'dual2',
            'dual3',
            'variable1',
            'variable2',
            'variable3',
            'memo',
            'fecha',
            'hora',
            'foto1',
            'foto2',
            'comercial',
            'centro',
        ]
        
        for lead_data in leads:
            filtered_lead_data = {k: lead_data[k] for k in keys_needed if k in lead_data}
            filtered_lead_data['fecha_captacion'] = filtered_lead_data['fecha_captacion'].strftime('%Y%m%d %H:%M')
            filtered_lead_data['fecha'] = filtered_lead_data['fecha'].strftime('%Y%m%d')
            total_seconds = int(filtered_lead_data['hora'].total_seconds())                
            hours, remainder = divmod(total_seconds, 3600)
            filtered_lead_data['hora'] = f'{hours}'
            
            lead = Lead(**filtered_lead_data)
            to_api = lead.to_dict()
            
            response = self.api_client.send_lead(to_api)
            if self.api_client.process_response(response):
                self.update_lead_status(lead.id)
            else:
                self.report_lead(response, to_api)
    
    def update_lead_status(self, lead_id):
        query = "UPDATE ws_leads SET cargado = 1 WHERE id = %s"
        cursor = self.db.execute_query(query, (lead_id,))
        cursor.close()
        
    def report_lead(self, response, to_api):
        error = response.json().get("RESULTADO")
        
        query = """
            INSERT INTO log_ws (cuerpo, error_, fecha)
            VALUES (%(cuerpo)s, %(error)s, now());
        """
        
        cursor = self.db.execute_query(query, params={
            "cuerpo" : json.dumps(to_api),
            "error" : error,
        })
        
        cursor.close()
        
        print("Error Log guardado")
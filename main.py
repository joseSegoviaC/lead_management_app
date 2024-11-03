from app.database import Database
from app.api.salesland_api_client import SaleslandAPI
from app.services.lead_service import LeadService
from app.lead import Lead

def main():
    db = Database()
    api_client = SaleslandAPI("https://webapp.salesland.net:8095/WS_SALESLAND_LEADS/SALESLAND_LEADSCmb.svc/AltaLead")
    lead_service = LeadService(db, api_client)
    
    lead = Lead(
        id = "2",
        campana = "1",
        cod_proveedor = "INC",
        fecha_captacion = "20210325 10:20",
        nombre = "Alba",
        ape1 = "Calao",
        ape2 = "Gomez",
        nif = "12345678Z",
        telefono = "600000003",
        email = "email@micorreo.es",
        direccion = "calle de la prueba, 1",
        codigo_postal = "28037",
        poblacion = "MADRID",
        provincia = "MADRID",
        acepta1 = "SI",
        acepta2 = "NO",
        acepta3 = "NO",
        num1 = "1",
        num2 = "2",
        num3 = "3",
        dual1 = "SI",
        dual2 = "NO",
        dual3 = "SI",
        variable1 = "v1",
        variable2 = "v2",
        variable3 = "v3",
        memo = "",
        fecha = "20210324",
        hora = "",
        foto1 = "ruta foto1",
        foto2 = "ruta foto2",
        comercial = "44",
        centro = "8"
    )
    
    lead_service.insert_lead(lead)
    lead_service.process_leads()
    
    db.close()
    
if __name__ == "__main__":
    main()
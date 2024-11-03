import requests

class SaleslandAPI:
    def __init__(self, api_url):
        self.api_url = api_url

    def send_lead(self, lead_data):
        try:
            response = requests.post(self.api_url, json=lead_data)
            response.raise_for_status()
        except requests.exceptions.HTTPError as error:
            print(f"HTTP error: {error}")
        except Exception as e:
            print(f"Error enviando lead: {e}")
        
        return response
    
    def process_response(self, response):
        response = response.json()
        campana = response.get("CAMPANA")
        resultado = response.get("RESULTADO")
        telefono = response.get("TELEFONO")
            
        print(f"Campaña: {campana}, Resultado: {resultado}, Teléfono: {telefono}")
        return resultado == 'OK'
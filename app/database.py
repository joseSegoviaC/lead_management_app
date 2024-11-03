import mysql.connector
from mysql.connector import Error
from configparser import ConfigParser

class Database:
    def __init__(self):
        self.connection = None
        self._load_config()

    def _load_config(self):
        config = ConfigParser()
        config.read('config/database.ini')
        db_params = config["mysql"]
        self.__make_conection(db_params)
    
    def __make_conection(self, db_params):
        try:
            self.connection = mysql.connector.connect(
                host = db_params['host'],
                database = db_params['database'],
                user = db_params['user'],
                password = db_params['password'],
            )

            if self.connection.is_connected():
                print("Conexión exitosa a la base de datos")
        except Error as e:
            print(f"Error al conectar con la base de datos: {e}")
        
    def execute_query(self, query, params=None):
        cursor = self.connection.cursor(dictionary=True, buffered=True)
        try:
            if params:
                cursor.execute(query, params)
            else:
                cursor.execute(query)

            self.connection.commit()
            return cursor
        except Error as e:
            print(f"Error ejecutando la consulta: {e}")
            return None

    def close(self):
        if self.connection.is_connected():
            self.connection.close()
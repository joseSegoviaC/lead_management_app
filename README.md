# Lead Management App

Este proyecto gestiona leads para campañas de ventas, conectándose a una base de datos y procesando información mediante una API externa.
Se usa una data de ejemplo en el archivo main.py para la simulacion del flujo.

## Requisitos

- **Python 3.11+**
- **Poetry** para la gestión de dependencias y entornos virtuales.
- **MySQL** como base de datos, o una compatible con el conector configurado.

## Configuración del Entorno

### 1. Clonar el repositorio

```bash
git clone https://github.com/joseSegoviaC/lead_management_app.git
cd lead_management_app
```
### 2. Creacion de la Base de Datos

Crear la base de datos y ejecutar los scripts de la carpeta db_scripts en su servicio mysql para la creacion de tablas, procedures y eventos.

### 3. Configuración de la Base de Datos

Modificar los valores de la base de datos en el archivo config/database.ini con las credenciales y parámetros de conexión correctos.

Ejemplo de config/database.ini:

```ini
[database]
host = localhost
user = tu_usuario
password = tu_contraseña
database = tu_base_de_datos
port = 3306
```

### 3. Instalacion de dependencias

#### Opción A: Usar Poetry

Si prefieres gestionar el entorno virtual y las dependencias con Poetry, usa los siguientes comandos:

```bash
poetry install
```

#### Opción B: Usar requirements.txt

Si prefieres gestionar el entorno virtual y las dependencias con Poetry, usa los siguientes comandos:

```bash
python -m venv venv
source venv/bin/activate

pip install -r requirements.txt
```

## Ejecución del Proyecto

Una vez configurado el entorno y la base de datos, puedes ejecutar el programa principal de las siguientes maneras:

```bash
# Si estás utilizando Poetry
poetry run python main.py

# Si usaste requirements.txt y activaste el entorno virtual manualmente
python main.py
```

## Estructura del Proyecto
- `main.py`: Punto de entrada de la aplicación.
- `config/database.ini`: Archivo de configuración para la conexión a la base de datos.
- `app/`: Contiene los módulos de la aplicación:
  - `database.py`: Maneja la conexión y operaciones con la base de datos.
  - `api/salesland_api_client.py`: Cliente para conectarse a la API de Salesland.
  - `services/lead_service.py`: Servicio de gestión de leads, incluyendo la inserción y procesamiento.
  - `lead.py`: Clase que representa un lead con sus propiedades.
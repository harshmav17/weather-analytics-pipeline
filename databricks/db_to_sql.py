import pyodbc
import json

# Define connection to Azure SQL DB
server = '<your_server>.database.windows.net'
database = '<your_database>'
username = '<your_username>'
password = dbutils.secrets.get(scope='key-vault-scope', key='sql-password')  # Secure password
driver = '{ODBC Driver 17 for SQL Server}'

conn_str = f'DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password}'

# Get the JSON weather data (from your existing method)
weather_data = fetch_weather_data()  # already flattened
weather_json = json.dumps(weather_data)

# Send to Azure SQL stored procedure
with pyodbc.connect(conn_str) as conn:
    cursor = conn.cursor()
    cursor.execute("EXEC usp_InsertWeatherData ?", weather_json)
    conn.commit()

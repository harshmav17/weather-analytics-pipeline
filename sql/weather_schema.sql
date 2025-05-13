-- WeatherMetadata
CREATE TABLE WeatherMetadata (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    region NVARCHAR(100),
    country NVARCHAR(100),
    lat FLOAT,
    lon FLOAT,
    localtime DATETIME,
    ingestion_time DATETIME DEFAULT GETDATE()
);

-- CurrentConditions
CREATE TABLE CurrentConditions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    weather_id INT FOREIGN KEY REFERENCES WeatherMetadata(id),
    temp_c FLOAT,
    is_day INT,
    condition_text NVARCHAR(100),
    wind_kph FLOAT,
    wind_degree INT,
    wind_dir NVARCHAR(20),
    pressure_in FLOAT,
    precip_in FLOAT,
    humidity INT,
    cloud INT,
    feelslike_c FLOAT,
    uv FLOAT
);

-- AirQuality
CREATE TABLE AirQuality (
    id INT IDENTITY(1,1) PRIMARY KEY,
    weather_id INT FOREIGN KEY REFERENCES WeatherMetadata(id),
    co FLOAT,
    no2 FLOAT,
    o3 FLOAT,
    so2 FLOAT,
    pm2_5 FLOAT,
    pm10 FLOAT,
    us_epa_index INT,
    gb_defra_index INT
);

-- Forecast
CREATE TABLE Forecast (
    id INT IDENTITY(1,1) PRIMARY KEY,
    weather_id INT FOREIGN KEY REFERENCES WeatherMetadata(id),
    forecast_date DATE,
    maxtemp_c FLOAT,
    mintemp_c FLOAT,
    condition NVARCHAR(100)
);

-- Alerts
CREATE TABLE Alerts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    weather_id INT FOREIGN KEY REFERENCES WeatherMetadata(id),
    headline NVARCHAR(255),
    severity NVARCHAR(50),
    description NVARCHAR(MAX),
    instruction NVARCHAR(MAX)
);

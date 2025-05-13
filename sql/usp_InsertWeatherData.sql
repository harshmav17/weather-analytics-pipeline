
CREATE PROCEDURE usp_InsertWeatherData
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Parse top-level weather metadata
    DECLARE @weather_id INT;

    INSERT INTO WeatherMetadata (name, region, country, lat, lon, localtime)
    SELECT
        JSON_VALUE(@json, '$.name'),
        JSON_VALUE(@json, '$.region'),
        JSON_VALUE(@json, '$.country'),
        JSON_VALUE(@json, '$.lat'),
        JSON_VALUE(@json, '$.lon'),
        JSON_VALUE(@json, '$.localtime');

    SET @weather_id = SCOPE_IDENTITY();

    -- Insert current conditions
    INSERT INTO CurrentConditions (
        weather_id, temp_c, is_day, condition_text, wind_kph, wind_degree, wind_dir,
        pressure_in, precip_in, humidity, cloud, feelslike_c, uv
    )
    SELECT
        @weather_id,
        JSON_VALUE(@json, '$.temp_c'),
        JSON_VALUE(@json, '$.is_day'),
        JSON_VALUE(@json, '$.condition_text'),
        JSON_VALUE(@json, '$.wind_kph'),
        JSON_VALUE(@json, '$.wind_degree'),
        JSON_VALUE(@json, '$.wind_dir'),
        JSON_VALUE(@json, '$.pressure_in'),
        JSON_VALUE(@json, '$.precip_in'),
        JSON_VALUE(@json, '$.humidity'),
        JSON_VALUE(@json, '$.cloud'),
        JSON_VALUE(@json, '$.feelslike_c'),
        JSON_VALUE(@json, '$.uv');

    -- Insert air quality
    INSERT INTO AirQuality (
        weather_id, co, no2, o3, so2, pm2_5, pm10, us_epa_index, gb_defra_index
    )
    SELECT
        @weather_id,
        JSON_VALUE(@json, '$.air_quality.co'),
        JSON_VALUE(@json, '$.air_quality.no2'),
        JSON_VALUE(@json, '$.air_quality.o3'),
        JSON_VALUE(@json, '$.air_quality.so2'),
        JSON_VALUE(@json, '$.air_quality.pm2_5'),
        JSON_VALUE(@json, '$.air_quality.pm10'),
        JSON_VALUE(@json, '$.air_quality.us-epa-index'),
        JSON_VALUE(@json, '$.air_quality.gb-defra-index');

    -- Insert forecast records (multi-row)
    INSERT INTO Forecast (weather_id, forecast_date, maxtemp_c, mintemp_c, condition)
    SELECT
        @weather_id,
        JSON_VALUE(f.value, '$.date'),
        JSON_VALUE(f.value, '$.maxtemp_c'),
        JSON_VALUE(f.value, '$.mintemp_c'),
        JSON_VALUE(f.value, '$.condition')
    FROM OPENJSON(@json, '$.forecast') AS f;

    -- Insert alerts (if any)
    INSERT INTO Alerts (weather_id, headline, severity, description, instruction)
    SELECT
        @weather_id,
        JSON_VALUE(a.value, '$.headline'),
        JSON_VALUE(a.value, '$.severity'),
        JSON_VALUE(a.value, '$.description'),
        JSON_VALUE(a.value, '$.instruction')
    FROM OPENJSON(@json, '$.alerts') AS a;
END;

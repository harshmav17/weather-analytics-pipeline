# 🌦️ Azure Real-Time Weather Analytics Pipeline

This project builds a real-time weather analytics solution using **Azure Databricks**, **Azure Event Hubs**, **Azure Stream Analytics**, and **Azure SQL Database**, with reporting in **Power BI**. It fetches live weather, air quality, and alert data via API, processes and streams it through a scalable cloud architecture.

---

## 🚀 Tech Stack
- Azure Databricks (Python, Spark)
- Azure Event Hubs
- Azure Stream Analytics (ASA)
- Azure SQL Database
- Power BI
- Azure Key Vault
- WeatherAPI.com

---

## 📁 Project Structure

| Folder         | Description |
|----------------|-------------|
| `databricks/`  | Databricks notebooks to fetch, flatten, and push weather data to Event Hubs |
| `asa/`         | ASA query to stream data from Event Hub to Azure SQL Database |
| `sql/`         | SQL scripts to create and manage weather-related tables |
| `delta/`       | Optional script to write to Delta Lake (for scalable data lake storage) |
| `powerbi/`     | DAX measures, report design notes, and `.pbix` file for dashboard |

---

## 🔗 API Used
[WeatherAPI](https://www.weatherapi.com/) – Real-time data on current weather, air quality, forecast, and alerts.

---

## 🔄 Data Flow Overview
Weather API (REST)
⬇
Azure Databricks (fetch + flatten)
⬇
Azure Event Hub (streaming ingestion)
⬇
Azure Stream Analytics (transform + load)
⬇
Azure SQL Database (structured storage)
⬇
Power BI (dashboard)


---

## 📊 Power BI Dashboard Highlights
- Real-time weather & AQI monitoring
- 3-day temperature trends
- Dynamic filtering by city, region, and date
- Visual weather alert summaries

---

## 🛡️ Secrets & Security
- API keys and connection strings are managed in **Azure Key Vault**
- Accessed securely in Databricks using `dbutils.secrets.get(...)`

---

## 🙌 Author
**Harsh Sharma**





# 🌦️ Azure Databricks Weather Analytics Project

This project fetches real-time weather, air quality, and alert data using a public API, processes and flattens it using **Azure Databricks**, stores the data in both **Azure SQL Database** and **Delta Lake**, and visualizes it using **Power BI**.

---

## 🚀 Tech Stack
- Azure Databricks (Python, Spark)
- Azure Event Hubs
- Azure SQL Database
- Delta Lake
- Power BI
- WeatherAPI.com

---

## 📁 Project Structure

| Folder       | Description |
|--------------|-------------|
| `databricks/` | Contains the main Databricks script to fetch and stream weather data |
| `sql/`        | DDL scripts to create normalized tables in Azure SQL DB |
| `delta/`      | Script to save weather data to Delta Lake |
| `powerbi/`    | Power BI design ideas and DAX measures |

---

## 🔗 API Used
[WeatherAPI](https://www.weatherapi.com/) – Fetches real-time weather, forecast, and alerts.

---

## 📊 Power BI Dashboard
- Forecast Trends
- Humidity & Air Quality Indicators
- Alerts by Severity
- Interactive Slicers by Region and Date

---

## 🛡️ Secrets & Security
Store credentials in **Azure Key Vault**, and fetch them securely in Databricks using `dbutils.secrets.get`.

---

## 🙌 Author
Harsh Sharma


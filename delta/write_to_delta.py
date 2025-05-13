from datetime import datetime
import pandas as pd

def write_to_delta(weather_data):
    df = pd.json_normalize(weather_data, sep='_')
    df['ingestion_time'] = datetime.now()
    spark_df = spark.createDataFrame(df)
    spark_df.write.format("delta").mode("append").save("/mnt/datalake/weatherdata")

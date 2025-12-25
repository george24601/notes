You might have workloads that run outside of Databricks (for example, first mile ETL or last mile BI). Unity Catalog lets you add external lineage metadata to augment the Databricks data lineage it captures automatically, giving you an end-to-end lineage view in Unity Catalog. This is useful when you want to capture where data came from (for example, Salesforce or MySQL) before it was ingested into Unity Catalog or where data is being consumed outside of Unity Catalog (for example, Tableau or PowerBI).

#### Read Delta tables with Iceberg clients

Iceberg metadata generation runs asynchronously on the compute used to write data to Delta tables, which might increase the driver resource usage.

Databricks triggers metadata generation asynchronously after a Delta Lake write transaction completes. 

You can manually trigger Iceberg metadata generation for the latest version of the Delta table. This operation runs synchronously, meaning that when it completes, the table contents available in Iceberg reflect the latest version of the Delta table available when the conversion process started.
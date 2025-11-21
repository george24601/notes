The Databricks-to-Databricks sharing protocol: This approach uses the Delta Sharing server that is built into Databricks. It supports some Delta Sharing features that are not supported in the other protocols, including notebook sharing, Unity Catalog volume sharing, Unity Catalog AI model sharing, Unity Catalog data governance, auditing, and usage tracking for both providers and recipients.

Databricks-to-Databricks sharing between Unity Catalog metastores in the same account is always enabled. 

###
If your recipient has access to a Databricks workspace that is enabled for Unity Catalog, you can use Databricks-to-Databricks sharing, and no token-based credentials are required. You request a sharing identifier from the recipient and use it to establish the secure connection.

Use yourself as a test recipient to try out the setup process. This step can also be performed by a non-admin user with the USE SHARE, USE RECIPIENT and SET SHARE PERMISSION privileges.








The Databricks-to-Databricks sharing protocol: This approach uses the Delta Sharing server that is built into Databricks. It supports some Delta Sharing features that are not supported in the other protocols, including notebook sharing, Unity Catalog volume sharing, Unity Catalog AI model sharing, Unity Catalog data governance, auditing, and usage tracking for both providers and recipients.

Databricks-to-Databricks sharing between Unity Catalog metastores in the same account is always enabled. 

###
If your recipient has access to a Databricks workspace that is enabled for Unity Catalog, you can use Databricks-to-Databricks sharing, and no token-based credentials are required. You request a sharing identifier from the recipient and use it to establish the secure connection.

Use yourself as a test recipient to try out the setup process. This step can also be performed by a non-admin user with the USE SHARE, USE RECIPIENT and SET SHARE PERMISSION privileges.

To access the tables, views, volumes, and notebooks in a share, a metastore admin or privileged user must create a catalog from the share. Then that user or another user who is granted the appropriate privilege can give other users access to the catalog and objects in the catalog. Granting permissions on shared catalogs and data assets works just like it does with any other assets registered in Unity Catalog, with the important distinction being that users can be granted only read access on objects in catalogs that are created from Delta Sharing shares.

A user on your team finds the share—the container for the tables, views, volumes, and notebooks that have been shared with you—and uses that share to create a catalog—the top-level container for all data in Databricks Unity Catalog.

To create a catalog from a provider share, you must be a metastore admin, a user who has both the CREATE CATALOG and USE PROVIDER privileges for your Unity Catalog metastore, or a user who has both the CREATE CATALOG privilege and ownership of the provider object.

The catalog created from a share has a catalog type of Delta Sharing. You can view the type on the catalog details page in Catalog Explorer or by running the DESCRIBE CATALOG SQL command in a notebook or Databricks SQL query. All shared catalogs are listed under Catalog > Shared in the Catalog Explorer left pane.








Account admins on the recipient side must set the Attribute Based Access Control for Delta Sharing toggle to On from Account console Previews to read shared tables secured by ABAC policies. This ensures that the query results are correct. Otherwise, there is a risk that data is not correctly governed.

Create ABAC policies for shared tables and schemas, and catalogs created from a share. Materialized views are supported with limitations. You can't create ABAC policies for shared streaming tables. To configure ABAC policies, see Create and manage attribute-based access control (ABAC) policies.

System governed tags are predefined by Databricks and cannot be edited or deleted. Like user-governed tags, each system tag has a tag policy that enforces its rules.
* Only users or groups with the appropriate ASSIGN permission can apply or remove system tags.
* Only predefined values can be used for each system tag key.
* Users cannot modify the definitions or create new system governed tags.

The table lists the System governed tags supported by Data Classification
* class.email_address
* class.ip_address
* class.name



Tags applied to a schema are likewise inherited by all objects in that schema. 

When you drop a column that has one or more governed tags assigned, the drop operation fails. To drop a tagged column, you must first remove all governed tags from it. 




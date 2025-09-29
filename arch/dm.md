### Saxo case study

The constituents of DC are technical metadata, ownership information, data lineage, and Business Glossary. Technical metadata describes how the data is organized and the structure of the data objects such as tables, events, objects, attributes with their types and lengths, indexes, and connections. Ownership Information captures the relationship and origin of data. Data lineage (DL) facilitates distributed discovery- one can get the right information at the right time and draw connections between data assets with lineage. Business Glossary (BG) establishes common understanding of business terms in the organization hence prevents misunderstanding by misinterpretation.

Most likely need a separate discovery interface on top of data catalog

For implementation of Data Catalog and Data Quality solution the key principle of push based metadata acquisition was followed, in-line with the datamesh principles. i.e. The domain teams are responsible for publishing the metadata (armed with necessary self-serve capabilities) and they know their data better. The open source tools were extended for containerization and the same was installed & configured in the Azure AKS environment. Metadata onboarding efforts were minimized because, otherwise, bringing the datasets into the Kafka platform requires an on-boarding process. The solution extended the onboarding process to collect additional information (such as dataset ownership etc), reducing the efforts to onboard metadata to minimum. 

Implementation of the data catalog included bringing the technical metadata, ownership, lineage and business glossary, pushing the metadata repository through defined API/interfaces, and making the same available through discovery interface.  For Technical Metadata, the dataset information was extracted from the dataset (topic) definition files and the structure/definition of the data elements from the associated schemas and pushed to the metadata repository via product API/interface. Then the templates were enriched with ownership information and the same were extracted and associated with the dataset in the metadata
model.

For Data Quality implementation, the DSL was defined to facilitate the data producers to create the quality rules and pushed these to the respective domain repository. Pipelines were built to provision the automated jobs based on the onboarded rule definitions to perform the data quality checks and emit the quality results to designated Kafka Topic.

It was important that the team provided standard guidelines for attribute-level access control. This was achieved via Protobuf schemas using annotations to define attributes that are considered sensitive data. Applications then use these schemas to determine if their data needs to be encrypted.  Each entity is able to use their own encryption key and maintains autonomy and data segregation to meet regulatory and privacy requirements. Azure AD was used to assign each entity the appropriate roles and permissions for decrypting data. This flexible approach enabled Saxo Bank to roll out the service rapidly to nearly forty internal entities.

Centralized: schema, quality rules (including validation service), standard, self service, encrption

Business Glossary was an important item on our roadmap, to allow us to link our attributes to industry standard business terms. One of the major problems in data flows is the inconsistent naming and meaning of data elements. This results in complex mapping exercises, confusion and ultimately data inconsistencies which can have a financial and reputation impact to any organization.

Business terms from industry specific standards like FIBO (Financial Industry Business Ontology) for finance, can complement the data elements, improving semantic understanding and aiding discovery.

A standard language to emerge and ensure that information can be efficiently used across the business; this standard or “ubiquitous” language is central to the idea of domain-driven design (DDD) as a means for removing barriers between developers and domain experts
The common domain plays a key role in this as we look to standardise the fundamental concepts in use across the Bank

Domain schema repo in PB -> publish code bindings -> generate canonical version -> buf style check

metadata and metrics are published to the Data Workbench—our implementation of LinkedIn’s open source project DataHub—giving data specialists across the bank visibility into the data assets published to Apache Kafka and their relationships.

### JPMorgan case study

When a consumer application needs data from a product lake, the team that owns the consumer application locates the data they need in our enterprise-wide data catalog. The entries in the catalog are maintained by the processes that move data to the lakes, so the catalog always reflects what data is currently in the lakes.

And, because the data doesn’t physically leave the lake, it’s easier to enforce the decisions that the data product owners make about their data. For example, if the data product owners decide to tokenize certain types of data in their lake, data consumers can only access the tokenized values. There are no copies of the untokenized data outside of the lake to create a control gap.

When data is consumed in-place, we will need to restrict visibility at a very granular level - to specific columns, records, and even to individual values. For example, when a system from one of our lines of business queries a pool of firmwide reference data shared through a lake, that system may only be granted permission to access the reference data that pertains to that line of business.

Our data mesh architecture addresses the visibility challenge by using a cloud-based Mesh Catalog to facilitate data visibility between the lakes and the data consumers. One could use AWS Glue Catalog or a similar a cloud based data cataloging service to enable this.

This catalog does not hold any data, but it does have visibility of what lakes are sharing data with which data consumers. This offers a single point of visibility into the data flows across the enterprise, and gives the data product owners confidence that they know where their data is being used.

Through the Data Mesh architecture, the data product owners for those data domains will make their data available in lakes. The enterprise data catalog will allow reporting teams to find and request the lake-based data to be made available in their reporting application. The mesh catalog will allow auditing the data flows from the lakes to the reporting application, so it’s clear where the data in the reports originates.

### Immuta notes

While seemingly straightforward, this question posed a greater issue than the team anticipated. Relying on traditional, manual access management processes, the team soon fell victim to what Taylor refers to as the “get a manager’s approval flow.” This is a system that requires requests and approvals for every data access scenario, leading to approval bottlenecks, deferred responsibilities, and overall lengthy time-to-data. This kind of manual system and slow time-to-data  limited Instacart’s ability to provide a timely and tailored experience for their millions of active users. Without eliminating these obstacles, the team could not make effective and efficient use of their abundant data resources.

the team focused on authoring and applying two types of policies:

Subscription Policies: These policies are written and applied at the data level, and are focused on whether or not a given user should have access to a specific data set, rather than the specific types of information within that data set.
Data Policies: These are slightly more technical controls, determining which actual types of data a user should be able to see once they’ve been granted access to a table or data set. This granular policy helps ensure that users see just what they need, and nothing more.

For example, an online marketplace service might have a data set containing users’ demographic data, such as names, addresses, and payment information. Users across departments might need access to this table in order to fulfill their customers’ needs, from paying for products/services to shipping and tracking. Access to the data set would be determined by a subscription policy, but visibility to specific rows would be contingent on intended usage. While a user from the finance team would need to see the payment information within this data set in order to bill the users, someone in the shipping department would have no right to see that information. This is where a data policy would restrict the shipping users from seeing the information they do not need.

### JPMorgan 

All of these data lakes are cataloged by AWS Glue, Amazon’s serverless data integration tool. In addition, there are consuming applications used by employees that are physically separated from each other as well as from the data lakes. These separate, but interconnected, domains create JPMorgan’s data mesh. 

Amazon AWS cloud services interconnect the distributed domains. AWS Glue Data Catalog enables applications and users to find and query the data they need. This enterprise-wide data catalog is automatically updated as new data is ingested into the data lakes, checked for data quality, and curated by data engineers with domain expertise. 

AWS Lake Formation enables data to be securely shared to approved applications and users. Neither applications nor users are ever allowed to copy or store data.

Across the top we can see the lake layers: Raw, Trusted (after validation) and Refined (after transformation and adjustments). The data lake is built and managed by AWS Lake Formation, including access management (authorisation and entitlement). They use Glue Crawler to collect metadata from the lake (including data lineage) and Glue Data Catalog to store it. 

### Fannie Mae

All data is registered in a centralised AWS Glue Catalog, which all users can browse to find the data they need. Each line of business (LOB) creates and maintains their own data sets, registers them as data products in the centralised Glue Data Catalog and shares them. Business applications can consume data from other LOBs by creating a data contract, which is reviewed and approved by the data producer

In the above diagram, the Contract Registry is hosted on Amazon Dynamo DB. The Access Management layer is built using AWS IAM (Identity & Access management). It provides Just In Time access through IAM session policies using a persona-driven approach. It also provides logging and monitoring.

Data from operational systems are stored in the lakehouse (not the Databricks definition, but Redshift + S3) and the metadata is stored in the centralised data catalogue. Fannie Mae built a web frontend to facilitate data discovery and data subscription to the Redshift warehouse and S3 lake. The workflow for access request, approval and access provision is fully automated using APIs and AWS CLI, and takes only a few minutes. The business applications can then access the required data in the corresponding lakehouse using Redshift cross-account data sharing 

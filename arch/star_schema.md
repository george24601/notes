Starflake schemas aim to leverage the benefits of both star schemas and snowflake schemas. The hierarchies of star schemas are denormalized, while the hierarchies of snowflake schemas are normalized.

Starflake schemas are normalized to remove any redundancies in the dimensions. To normalize the schema, the shared dimensional hierarchies are placed in outriggers.

Other dimensions might be members of this fact table (such as location/region) but these add nothing to the uniqueness of the fact records. These “affiliate dimensions” allow for additional slices of the independent facts but generally provide insights at a higher level of aggregation (a region contains many stores).

When rolling up dimensions, you are provided with an excellent opportunity to perform aggregate functions on the dimension itself and store the results as new attributes. For example, you may want to know how many customers are living in each state. This could be used as the denominator in some population calculation you plan to use against the aggregate fact. 

Attributes that are part of a hierarchy and are queried independently.  Examples include the year, quarter, and month attributes of a date hierarchy; and the country and state attributes of a geographic hierarchy.

Sparsely populated attributes, where most dimension member records have a NULL value for the attribute, are moved to a sub-dimension.
Low cardinality attributes that are queried independently.  For example, a product dimension may contain thousands of products, but only a handful of product types.  Moving the product type attribute to its own dimension table can improve performance when the product types are queried independently.

Snowflaking for the sole purpose of minimizing disk space is not recommended, however, because it can adversely impact query performance.

If a dimension is very sparse (i.e. most of the possible values for the dimension have no data) and/or a dimension has a very long list of attributes which may be used in a query, the dimension table may occupy a significant proportion of the database and snowflaking may be appropriate.


aggregate fact table: unit sold for the month. Unit sold
factless fact table
star flake tables to support agg tables at all levels?

Aggregates are precalculated summaries derived from the most granular fact table. These summaries form a set of separate aggregate fact tables. You may create each aggregate fact table as a specific summarization across any number of dimensions.

The snowflake schema is similar to the star schema. However, in the snowflake schema, dimensions are normalized into multiple related tables, whereas the star schema’s dimensions are normalized with each dimension represented by a single table.


The star schema separates business process data into facts, which hold the measurable, quantitative data about a business, and dimensions which are descriptive attributes related to fact data. Examples of fact data include sales price, sale quantity, and time, distance, speed and weight measurements. Related dimension attribute examples include product models, product colors, product sizes, geographic locations, and salesperson names

Fact tables record measurements or metrics for a specific event. Fact tables generally consist of numeric values, and foreign keys to dimensional data where descriptive information is kept.[4] Fact tables are designed to a low level of uniform detail (referred to as "granularity" or "grain"), meaning facts can record events at a very atomic level. This can result in the accumulation of a large number of records in a fact table over time. Fact tables are defined as one of three types:

Transaction fact tables record facts about a specific event (e.g., sales events)
Snapshot fact tables record facts at a given point in time (e.g., account details at month end)
Accumulating snapshot tables record aggregate facts at a given point in time (e.g., total month-to-date sales for a product)
Fact tables are generally assigned a surrogate key to ensure each row can be uniquely identified. This key is a simple primary key

Dimension tables usually have a relatively small number of records compared to fact tables, but each record may have a very large number of attributes to describe the fact data. Dimensions can define a wide variety of characteristics, but some of the most common attributes defined by dimension tables include:

Time dimension tables describe time at the lowest level of time granularity for which events are recorded in the star schema
Geography dimension tables describe location data, such as country, state, or city
Product dimension tables describe products
Employee dimension tables describe employees, such as sales people
Range dimension tables describe ranges of time, dollar values or other measurable quantities to simplify reporting
Dimension tables are generally assigned a surrogate primary key, usually a single-column integer data type, mapped to the combination of dimension attributes that form the natural key.

Every dimension in a star schema is represented with the only one-dimension table.

The dimension table are not joined to each other

Fact table would contain key and measure
The dimension tables are not normalized. For instance, in the above figure, Country_ID does not have Country lookup table as an OLTP design would have.

A Snowflake Schema is an extension of a Star Schema, and it adds additional dimensions. The dimension tables are normalized which splits data into additional tables

A Galaxy Schema contains two fact table that share dimension tables between them. It is also called Fact Constellation Schema. The schema is viewed as a collection of stars hence the name Galaxy Schema.

A star schema is a database organizational structure optimized for use in a data warehouse or business intelligence that uses a single large fact table to store transactional or measured data, and one or more smaller dimensional tables that store attributes about the data. It is called a star schema because the fact table sits at the center of the logical diagram, and the small dimensional tables branch off to form the points of the star.

A fact table sits at the center of a star schema database, and each star schema database only has a single fact table. The fact table contains the specific measurable (or quantifiable) primary data to be analyzed, such as sales records, logged performance data or financial data. It may be transactional -- in that rows are added as events happen -- or it may be a snapshot of historical data up to a point in time.

The fact table stores two types of information: numeric values and dimension attribute values. Using a sales database as an example:

Numeric value cells are unique to each row or data point and do not correlate or relate to data stored in other rows. These might be facts about a transaction, such as an order ID, total amount, net profit, order quantity or exact time.
The dimension attribute values do not directly store data, but they store the foreign key value for a row in a related dimensional table. Many rows in the fact table will reference this type of information. So, for example, it might store the sales employee ID, a date value, a product ID or a branch office ID.

Star schema's dimension tables do not contain any foreign keys. That is, the dimension tables do not reference any other tables, nor do they have any "sub-dimension tables." They are generally denormalized because some information may be duplicated in the dimension tables.

A snowflake schema database is similar to a star schema in that it has a single fact table and many dimension tables. However, for a snowflake schema, each dimension table might have foreign keys that relate to other dimension tables.

So, in a star schema there is no further branching from each dimension table. But in a snowflake schema each branch might have further branches -- like a snowflake with each branch having successively smaller branches coming out of a central core in a fractal pattern. A snowflake schema is also more normalized than a star schema, though not necessarily fully normalized.

As a simple example, the sales record in the fact table contains an employee ID. This employee ID relates to an employee dimension table that contains information such as the first name, last name, gender and branch office.

In a star schema, the record would contain information such as "male" and "Texas Office." This would be duplicated data also in other rows for employees with the same gender or branch office.
In a snowflake schema, the gender or branch office would contain a foreign key value to a gender dimension table and a branch office dimension table. These could contain information such as gender, name, salutation (Mr. or Ms.), branch office name, branch office address or branch manager.

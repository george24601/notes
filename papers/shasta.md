### Summary

At the front-end, Shasta enables developers to define views and express queries in RVL, a new Relational View Language. Shasta translates RVL queries into SQL queries before passing them onto F1. Shasta does not rely on pre-computation, instead a number of optimisations in the underlying data infrastructure enable it to achieve the desired latency targets.

Using Shasta, an ‘important advertiser-facing application’ was reduced from 130K lines of C++ view definitions to about 30K lines of RVL and 23K lines of C++ UDF code.

Cope with diverse underlying data stores (which is achieved by using F1s ability to scan external tables)

* View gateway
  * RVL compiler
  * sends SQL to F1 Coordinateor
* F1 Coordinator
  * F1 Slave
* F1 Slave 
  * UDF Server
  * TableCache

TableCache acts as an extra layer of caching between the F1 query engine and F1 storage backed by Spanner. It can be compared to the usage of buffer pools in traditional database architectures since the goal is to exploit database access patterns to accelerate I/O. However, TableCache is read-only, which allows the design to be optimized for the read path without sacrificing write performance. In particular, TableCache uses fine-grained sharding to perform many small reads in parallel, and trans actional writes become more expensive with higher degrees of parallelism. Also, TableCache provides a higher-level abstraction than traditional block-based caches, where data from a table is accessed based on root ID and timestamp.

Table cache is one of the most important optimization

The syntax of RVL is similar to SQL, but with semantic differences oriented towards OLAP applications. The most important of these is support for automatic aggregation of data when columns are projected, based on information contained in the schema itself. The query language is embedded in higher-level constructs called view templates . These support abstraction through parameterisation, and composition of templates and queries to allow a view’s implementation to be factored into manageable and reusable pieces.

If the metadata for a column specifies an optional implicit aggregation function then it is treated as as aggregatable column. Otherwise it is a grouping column.

The optimizer is rule-based rather than cost-based, as the only intention is to simplify the generated SQL. F1’s SQL optimizer can then take care of the rest. The obvious question at this point is why the F1 SQL optimizer can’t take care of everything? What does the RVL optimizer do that the SQL optimizer can’t??

### Notes

Shasta targets applications with strong data freshness requirements, making it challenging to precompute query results using common techniques such as ETL pipelines or materialized views. Instead, online queries must go all the way from primary storage to user- facing views, resulting in complex queries joining 50 or more ta- bles.

we leveraged and extended F1’s distributed query engine with facilities such as safe execution of C++ and Java UDFs

* F1 Storage
  * Campaign: dimension table
    * EditCampaign() by AdWord web UI
* Mesa
  * CampaignStats: fact table
    * Photon aggregates the ad server logs
* Shasta
  * On top of F1 and Mesa
  * powers GetCampaign() in the AdWord web UI 
    * uses CampaignReport() Shasta view

Consider a scenario where a table in the UI shows that an ad campaign’s budget is exhausted. In response, the advertiser may decide to increase the budget, which is easily done in the same UI table row. Any future rendering of the table must then consistently reflect the budget change. Due to the complexity of view defini- tions, a user changing a single cell in a sorted UI table can induce subtle changes to other columns in the same row and the applica- tion may choose to recompute the entire table immediately after the write. In AdWords, advertiser changes to campaign data result in writes to F1, bypassing Shasta.

RVL supports user-defined functions (UDFs), allowing Shasta view definitions to invoke procedural ap- plication code.

We improved support for UDFs in F1. Specifically, we added a component called UDF server to F1, which supports safe eval- uation of compiled C++ and Java UDFs with high throughput.

The F1 query engine executes the generated SQL, using UDF servers to evaluate any UDFs in the query. TableCache accelerates access to F1 storage during query execution, while the query engine reads directly from data sources other than F1 such as Mesa and Bigtable. F1 supports access to such “external” data sources using a plugin API [13], al- lowing for tight integration with the query engine. 

The application is mi- grating from an older to a newer, higher quality representation of budget suggestions. The application may want to use the new sug- gestions for only a small whitelist of advertisers initially, and ramp up slowly to all customers. We therefore maintain both versions during the transition period. Since different teams maintain the re- spective backend pipelines, separate tables help clarify ownership.

### Example View Template

```
view CampaignDimensions<params> {
  campaign = SELECT *,
    CampaignInfo.name AS Name,
    CampaignInfo.budget_id AS BudgetId
    FROM Campaign;
  budgets = SELECT *,
    BudgetInfo.amount AS BudgetAmount
    FROM Budget;
  budget_suggestion_table =
    if ($params.use_budget_suggestion_v2) {
      BudgetSuggestionV2;
    } else {
      BudgetSuggestionV1;
    }
  budgets_with_suggestion = SELECT *
    FROM budgets LEFT JOIN budget_suggestion_table
    USING CustomerId, BudgetId;
  return SELECT *,
    ComputeCampaignStatus(CampaignInfo, BudgetInfo,
                          BudgetSuggestionInfo) AS Status
    FROM campaign LEFT JOIN budgets_with_suggestion
    USING CustomerId, BudgetId;
}
```

The CampaignDimensions view template performs a join of F1 tables. The input parameter use_budget_suggestion_v2 in- dicates which version of budget suggestion to use. The Status column is computed with a user-defined function (UDF).

```
view CampaignFacts<params> {
  return SELECT *,
    MakePair(Impressions, Clicks)
      AS ClickThroughRate [aggregation = "RateAgg"]
    FROM CampaignStats FULL JOIN CampaignConversionStats;
}
```

The CampaignFacts view template performs a join of Mesa ta- bles. ClickThroughRate is made explicitly aggregatable by a user-defined aggregation function (UDAF) RateAgg. No ex- plicit GROUP BY is specified, as the RVL compiler generates the correct GROUP BY clauses based on the request context.


The CampaignDimensions view template performs a join of F1 tables. The input parameter use_budget_suggestion_v2 in- dicates which version of budget suggestion to use. The Status column is computed with a user-defined function (UDF).



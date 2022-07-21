## Meta Insights API

Params
* action_attribution_windows
* action_breakdowns
* breakdowns: For more than one breakdown, only certain combinations are available
* date_preset: This field is ignored if time_range or time_ranges is specified.
* default_summary: Determine whether to return a summary. If summary is set, this param is be ignored; otherwise, a summary section with the same fields as specified by fields will be included in the summary section.
* fields: Fields to be retrieved. Default behavior is to return impressions and spend.
* sort
* summary: If this param is used, a summary section will be included, with the fields listed in this param.
* time_range: A date in the format of "YYYY-MM-DD", which means from the beginning midnight of that day.
* time_ranges: Array of time range objects. Time ranges can overlap, for example to return cumulative insights. Each time range will have one result set. 

Due to storage constraints, only some permutations of breakdowns are available.

Limit your query by limiting the date range or number of ad ids. You can also limit your query to metrics that are necessary, or break it down into multiple queries with each requesting a subset of metrics.
Avoid account-level queries that include high cardinality breakdowns such as action_target_id or product_id, and wider date ranges like lifetime.
Use /insights edge directly with lower level ad objects to retrieve granular data for that level. For example, first use the account-level query to fetch the list of lower-level object ids with level and filtering parameters. In this example, we fetch all campaigns that recorded some impressions:



## G Ads API
POST https://googleads.googleapis.com/v11/customers/{customer_id}/googleAds:searchStream

To provide similar functionality in Google Ads API, each criteria report is represented by a separate resource. For example, data similar to the Keywords Performance Report is available in the keyword_view resource. Unless absolutely necessary, view resources will only contain a resource_name field.

Google Ads API clients will need to specify corresponding ad_group_criterion or campaign_criterion fields if any criteria specific data needs to be fetched. This will allow Google Ads API clients to request ad_group_criterion or campaign_criterion fields and the view resource in the same request to the GoogleAdsService.SearchStream method.


You can select fields from parent resources all the way up to customer from a criteria view. For example, when selecting FROM the keyword_view, you can request fields from all of the following resources:
* ad_group_criterion
* ad_group
* campaign
* customer

You can check what resources can be requested in the above-mentioned way for a given resource by checking the Attribute Resources row of its reference page

While Search can send multiple paginated requests to download the entire report, SearchStream sends a single request and initiates a persistent connection with the Google Ads API regardless of report size.

For SearchStream, data packets start to download immediately with the entire result cached in a data buffer. Your code can start reading the buffered data without having to wait for the entire stream to finish.

Google Ads API internally caches the entire data set, so subsequent requests are faster than the first request. Uses next_page_token to paginate


## GA RT reporting API
* URIs are relative to https://www.googleapis.com/analytics/v3


### GET https://www.googleapis.com/analytics/v3/data/realtime


#### Request
* ids: Unique table ID for retrieving Analytics data. Table ID is of the form ga:XXXX, where XXXX is the Analytics view (profile) ID.
* metrics: A comma-separated list of Analytics metrics. E.g., 'rt:activeUsers'. At least one metric must be specified.

Below are optional

* dimensions: A comma-separated list of real-time dimensions. E.g., 'rt:medium,rt:city'.
* filters: A comma-separated list of dimension or metric filters to be applied to real-time data.
* max-results: The maximum number of entries to include in this feed. Doesn't seem to support paginiation
* sort: A comma-separated list of dimensions or metrics that determine the sort order for real-time data.

#### Filters
* ga:name operator expression
* The OR operator is defined using a comma (,). It takes precedence over the AND operator and may NOT be used to combine dimensions and metrics in the same expression.
* The AND operator is defined using a semi-colon (;). It is preceded by the OR operator and CAN be used to combine dimensions and metrics in the same expression
* If the rt:activeUsers metric is included in a query with the following dimension filters, then only the AND operator and equality match type (==) are supported.
* There is no support for metric filters.

#### Response

```json
{
  "kind": "analytics#realtimeData",
  "id": string,
  "query": {
    "ids": string,
    "dimensions": string,
    "metrics": [
      string
    ],
    "sort": [
      string
    ],
    "filters": string,
    "max-results": integer
  },
  "totalResults": integer,
  "selfLink": string,
  "profileInfo": {
    "profileId": string,
    "accountId": string,
    "webPropertyId": string,
    "internalWebPropertyId": string,
    "profileName": string,
    "tableId": string
  },
  "columnHeaders": [
    {
      "name": string,
      "columnType": string,
      "dataType": string
    }
  ],
  "totalsForAllResults": {
    (key): string
  },
  "rows": [
    [
      string,
      string
    ]
  ]
}
```

## DD API

### Get active metrics list

GET https://api.datadoghq.com/api/v1/metrics
Query Strings
* from [required]: Seconds since the Unix epoch.
* host: Hostname for filtering the list of metrics returned. If set, metrics retrieved are those with the corresponding hostname tag. 
* tag_filter: Filter metrics that have been submitted with the given tags. Supports boolean and wildcard expressions. Cannot be combined with other filters.

### Search metrics

GET https://api.datadoghq.com/api/v1/search
* q [required]: Query string to search metrics upon. Can optionally be prefixed with metrics:.

### Query timeseries points

GET https://api.datadoghq.com/api/v1/query
* from [required]. Start of the queried time period, seconds since the Unix epoch.
* to [required]. End of the queried time period, seconds since the Unix epoch.
* query [required]

### Query the event stream

GET https://api.datadoghq.com/api/v1/events
* Start
* End
* priority: Priority of your events, either low or normal. Allowed enum values: normal, low
* sources: A comma separated string of sources. 
* tags: A comma separated list indicating what tags


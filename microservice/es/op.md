PUT /$INDEX/$TYPE/$ID
See the _index, _type, _id in the retrived doc

GET /megacorp/employee/_search?q=last_name:Smith
This is query string search, or

GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "last_name" : "Smith"
        }
    }

,
    "highlight": {
        "fields" : {
            "about" : {}
        }
    }
}
Notice match returns all RELEVANT results, not necessarily exactly matches. use match_phrase for exact match. However, it could still just be a substring. 
Highlight is optional, just to help show the returned results


GET /megacorp/employee/_search
{
    "query" : {
        "filtered" : {
            "filter" : {
                "range" : {
                    "age" : { "gt" : 30 } 
                }
            },
            "query" : {
                "match" : {
                    "last_name" : "smith" 
                }
            }
        }
    }
}

filter first and then aggregate!
GET /megacorp/employee/_search
{
  "query": {
    "match": {
      "last_name": "smith"
    }
  },
  "aggs": {
    "all_interests": {
      "terms": {
        "field": "interests"
      }
    }
  }
}

avg of employees sharing a particular interest
{
    "aggs" : {
        "all_interests" : {
            "terms" : { "field" : "interests" },
            "aggs" : {
                "avg_age" : {
                    "avg" : { "field" : "age" }
                }
            }
        }
    }
}


/_search 
Search all types in all indices

/gb/_search
Search all types in the gb index

/gb,us/_search
Search all types in the gb and us indices

/gb,us/user,tweet/_search
Search types user and tweet in the gb and us indices

+name:(mary john) +date:>2014-09-10 +(aggregations geo)
in URL, this translates to 
?q=%2Bname%3A(mary+john)+%2Bdate%3A%3E2014-09-10+%2B(aggregations+geo)

inverted index for fast full-txt searches 

GET /gb/_mapping/tweet

{
    "bool": {
        "must": { "match":   { "email": "business opportunity" }},
        "should": [
            { "match":       { "starred": true }},
            { "bool": {
                "must":      { "match": { "folder": "inbox" }},
                "must_not":  { "match": { "spam": true }}
            }}
        ],
        "minimum_should_match": 1
    }
}




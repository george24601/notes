free text search is on all fields including your own - by default not case sensitve, unless uses double quotes for exact matches

field search - field:value, but depends on the field type - analyzed or non-analyzed field

settings tab to see what fields are analyzed in Kibana

If you look at non-analyzed field with upper case - there will be no match!

Try avoid leading wildcard

fuzzy search?

A query may consist of one or more words or a phrase. A phrase is a group of words surrounded by double quotation marks, such as "test search".

If you want to store your field list (and the queries, that we will write in a moment), you can press the Save Search icon beside the search box at the top. You have to specify a name.

You can press the Load Saved Search icon at any time and you will get a list of all saved searches. If you have a lot of saved searches the filter box might be useful, which lets you search in all names.

To start over a complete new view, press the New Search button.

If you are gathering log messages but not filtering the data into distinct fields, querying against them will be more difficult as you will be unable to query specific fields.

An analyzer has several tokenizers and/or filters attached to it. The tokenizer will get the value of the field that should be indexed (e.g. "The Hitchhiker's Guide to the Galaxy") and can split the value up into multiple chunks for which the user should be able to search for (more in a moment). The filters of an analyzer can transform or filter out tokens, that the tokenizer produces.

All the resulting tokens will be stored in a so called inverted index. That index will contain all the tokens produced by the analyzer and a link to which of the documents contained them. So if the user presents Elasticsearch with a search word it just needs to look it up in the inverted index and it will instantly see which documents it needs to return.

Whether your values are analyzed or not (i.e. what terms are in the inverted index) have a huge impact on what and how you can search for,

Analyzed strings will now be of type text and not analyzed strings are from type keyword in version 5 onwards.



There is no space allowed after the colon. Searching for author: douglas is not the same as searching for author:douglas and most likely won't bring you any meaningful results.

If you want to search for more then just one word, you have to put the words in quotes. Let's now search for the whole name, using author:"douglas adams"

If you search for author:"douglas adams" on the unanalyzed data you will get — dramatic pause — no results (as you might have expected). Why? It will look in the inverted index for an entry for "douglas adams", but there is only one for "Douglas Adams" — the search is case sensitive. You already might have guessed it, but searching for author:"Douglas Adams" will return both documents in the unanalyzed data, since that is exactly the "key" that is stored in the inverted index.

If you search for author:"douglas adams" on the analyzed data it will return both documents. Why? Again Elasticsearch recognizes, that the author field is analyzed and try to apply the same analyzer to your query, i.e. splitting up by words in that case and transforming them to lower case. After that it finds that there are two documents for the "douglas" and the "adams" terms so it will return both. Searching for author:"Douglas Adams" would return the same, since Elasticsearch applies the lowercase filter to your query before actually searching (as mentioned above).

you cannot use wildcards inside of phrases. If you search for author:"Do?glas Adams" the questionmark won't be used as a wildcard, but must be part of the indexed value

Even more attention: since Elasticsearch applies the analyzers on your query, it might look like wildcards are working inside phrases if you place them at the beginning/end of words — e.g. author:"Douglas Adams(star here)" will still return both documents on analyzed data, but not because the wildcard worked as expected, just because the analyzer stripped that asterisk when analyzing the query. That query wouldn't find the value "Douglas Adamsxxx".

Now we come to a probably confusing part of the query language. If we use the same search term on unanalyzed data we will get no result. So far it shouldn't be a surprise, since there is only an entry for "Douglas Adams" (uppercase letters) in the inverted index, meaning a search for "doug*" won't give any results. So let's be clever and search for author:Doug*. From all we know until now, that should now find the "Douglas Adams" entry in the inverted index. But if you search it, it won't return any results.

What is happening there? As soon as you use wildcards in your query, Elasticsearch will automatically lowercase your query. No matter if the field you are searching on is analyzed or not. Meaning searching for author:Doug* will be converted to author:doug* and therefore won't find "Douglas Adams" in the unanalyzed inverted index.

If you search in a more modern Elasticsearch version for a string without a field (e.g. Douglas in the example above) the search won't be done against the specific _all inverted index, but against all inverted indexes. That way the value will be searched in each (searchable) field, but the actual analyzer of that field will be used.

You MUST write those operators in uppercase. If you write them in lowercase they won't be detected. (In fact your might find the results strange, because it just throws in another _all:and respectively _all:or to the query, if you write them lowercase.)

By default if you don't specify it (or are searching from Kibana), this will be OR. Meaning author:douglas author:terry is equivalent to author:douglas OR author:terry

I said that author:"Douglas Adams" searches for something completely different than author:Douglas Adams. We know now everything to understand what the later query searches for. Assuming you haven't changed the default_operator and default_field this query will be equivalent to author:Douglas OR _all:Adams which will result in different documents than author:"Douglas Adams" most likely.

Besides using the keywords AND and OR you can also use && or || respectively.

Elasticsearch has a setting ignore_above that you can set in the mapping for every field. This is a numeric value, that will cause Elasticsearch to NOT index values longer than the specified ignore_above value when a document gets inserted. The value will still be stored so when looking at the document you will see the value, but you cannot search for it.

ignore_above?

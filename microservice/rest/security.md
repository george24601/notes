HTTP Digest -> prob overkill with less sensitive applications

HTTP basic auth over HTTPS
-------
common for web services

GET /spec.html HTTP/1.1
Host: www.example.org
Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==


HMAC
--------
in header

Authentication: hmac username:nonce:{salted hash of secret}
Date: {current time}

Server side can reconstruct the salted hash, and replay attack wont work, because the salted hash will become invalid once it is outside the range of the date field, although this also means if a genuine client sents wrong time, server will reject it.
nonce also ensures that salted hash is valid for each request only once,i.e., if I send 2 requests within same second, nonce will be different




From OWASP
--------

Should use session-based authentication, either by a session token via a POST or by using API key as a POST body argument or as a cookie

Use only the session token or API key to maintain client state in a server-side cache

Defend against replay attack, espeically you have state blob send as part of transcation: use time limited encryption key, keyed against the sseion token or API key, date and time, and incoming IP address.

No techinical method of preventing being farmed against

Make sure the incoming HTTP method is valid for the session token/API key and association resource, action, and record,e.g., everyone can view, but probably not everyone can delete

Always check Content-Type header. An empty or unexpected one should give 406 Not Acceptable

Always send the Content-Type header with the correct Content-Type, and preferrably include a char set

When inserting values into the browser DOM, use .value/.innerText/.textContent rather than .innerHTML




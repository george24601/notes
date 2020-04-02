a mechanism that allows restricted resources (e.g. fonts) on a web page to be requested from another domain outside the domain from which the first resource was served

Certain "cross-domain" requests, notably Ajax requests, however are forbidden by default by the same-origin security policy.

Although some validation and authorization can be performed by the server, it is generally the browser's responsibility to support these headers and honor the restrictions they impose.

For Ajax and HTTP request methods that can modify data (usually HTTP methods other than GET, or for POST usage with certain MIME types), the specification mandates that browsers "preflight" the request, soliciting supported methods from the server with an HTTP OPTIONS request method, and then, upon "approval" from the server, sending the actual request with the actual HTTP request method. Servers can also notify clients whether "credentials" (including Cookies and HTTP Authentication data) should be sent with requests

The browser sends the OPTIONS request with an Origin HTTP header. The value of this header is the domain that served the parent page. The server at service.example.com may respond with an Access-Control-Allow-Origin (ACAO) header in its response indicating which origin sites are allowed. Can be wildcard, which means everything

A wildcard same-origin policy is appropriate when a page or API response is considered completely public content and it is intended to be accessible to everyone, including any code on any site. For example, a freely-available web font on a public hosting service like Google Fonts.

Note that in the CORS architecture, the ACAO header is being set by the external web service (service.example.com), not the original web application server (www.example.com). CORS allows the external web service to authorise the web application to use its services and does not control external services accessed by the web application.

When performing certain types of cross-domain Ajax requests, modern browsers that support CORS will insert an extra "preflight" request to determine whether they have permission to perform the action.

```
OPTIONS /
Host: service.example.com
Origin: http://www.example.com
```

Response 
```
Access-Control-Allow-Origin: http://www.example.com
Access-Control-Allow-Methods: PUT, DELETE
```

If you configure CloudFront to serve HTTPS requests using Server Name Indication (SNI), CloudFront associates your alternate domain name with an IP address for each edge location, but the IP address is not dedicated to your distribution. When a viewer submits an HTTPS request for your content, DNS routes the request to the IP address for the applicable edge location. However, because the IP address isn't dedicated to your distribution, CloudFront can't determine, based on the IP address, which domain the request is for.

When you're using a custom origin, the SSL/TLS certificate on your origin includes a domain name in the Common Name field, and possibly several more in the Subject Alternative Names field. (CloudFront supports wildcard characters in certificate domain names.)

One of the domain names in the certificate must match the domain name that you specify for Origin Domain Name. If no domain name matches, CloudFront returns HTTP status code 502 (Bad Gateway) to the viewer.



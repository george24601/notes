/video => all videos
	GET: list of all vidoe
	PUT: create/replace the whole collection
	POST: create a new video and add it to the video list, the newly created resource will be returned
/video/1 => specific one video
	PUT: create/replace the one video
/video/1/duration => a part of a video


So PUT/DELETE are ideompotent,while POST is not, but PUT does NOT partially update, use PATCH for partial update semantics

use 202 for async ops

use 207 for multiple independent operations

Patch suggests that operation is atomic

Use rel attribute to show client what a link does. For predefined rel types, if you use it, make sure API behaves per definition

Non-standard rel types must be a URI

For long running asynch ops, return 202 (Accepted) and temporary resource inside the location header

If user tries to get the temporary resource after actual resource is created, return 303 (see other) and actual resource in the location header. Return 410 (gone) if the temp resource expired

From google drive API:

You're limited to 100 calls in a single batch request

A batch request is a single standard HTTP request containing multiple Drive API calls, using the multipart/mixed content type. Within that
main HTTP request, each of the parts contains a nested HTTP request.

The server's response is a single standard HTTP response with a multipart/mixed content type; each part is the response to one of the
requests in the batched request, in the same order as the requests. 

### Google Drive's bulk API: Request

POST /batch HTTP/1.1
Host: www.googleapis.com
Content-length: 592
Content-type: multipart/mixed; boundary=batch_0123456789
Authorization: Bearer authorization_token

--batch_0123456789
Content-Type: application/http
Content-ID: <item1:user@example.com>
Content-Transfer-Encoding: binary


POST /drive/v2/files/fileId/permissions
Content-Type: application/json
Content-Length: 71


{
  "role": "reader",
  "type": "user",
  "value": "user@example.com"
}


--batch_0123456789
Content-Type: application/http
Content-ID: <item2:user@example.com>
Content-Transfer-Encoding: binary
....

Response:


### From FB graph API:

curl \
    -F ‘access_token=…’ \
    -F ‘batch=[{“method”:”GET”, “relative_url”:”me”},{“method”:”GET”, “relative_url”:”me/friends?limit=50”}]’ \
    https://graph.facebook.com

[
    { “code”: 200, 
      “headers”:[
          { “name”: ”Content-Type”, 
            “value”: ”text/javascript; charset=UTF-8” }
      ],
      “body”: ”{\”id\”:\”…\”}”},
    { “code”: 200,
      “headers”:[
          { “name”:”Content-Type”, 
            “value”:”text/javascript; charset=UTF-8”}
      ],
      “body”:”{\”data\”: [{…}]}}
]

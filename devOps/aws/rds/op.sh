aws rds create-db-snapshot /
    --db-instance-identifier mydbinstance /
    --db-snapshot-identifier mydbsnapshot

https://rds.us-east-1.amazonaws.com/
    ?Action=CreateDBSnapshot
    &DBInstanceIdentifier=mydbinstance
    &DBSnapshotIdentifier=mydbsnapshot
    &SignatureMethod=HmacSHA256
    &SignatureVersion=4
    &Version=2013-09-09
    &X-Amz-Algorithm=AWS4-HMAC-SHA256
    &X-Amz-Credential=AKIADQKE4SARGYLE/20140423/us-east-1/rds/aws4_request
    &X-Amz-Date=20140423T161105Z
    &X-Amz-SignedHeaders=content-type;host;user-agent;x-amz-content-sha256;x-amz-date
    &X-Amz-Signature=e9649af6edcfbab4016f04d72e1b7fc16d8734c37477afcf25b3def625484ed2

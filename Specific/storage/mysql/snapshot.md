When you create a DB snapshot, you need to identify which DB instance you are going to back up, and then give your DB snapshot a name so you can restore from it later.

. Since the snapshot includes the entire storage volume, the size of files, such as temporary files, also affects the amount of time it takes to create the snapshot.

You cannot restore from a DB snapshot to an existing DB instance; a new DB instance is created when you restore.

Parameter group?

security group problem?

If your database is in another state, for example STORAGE_FULL, automated backups do not occur.

An outage occurs if you change the backup retention period from 0 to a non-zero value or from a non-zero value to 0.

When automated backups are enabled, an outage occurs and a backup is immediately created.

when you restore a DB instance from a DB snapshot, the default DB parameter and a default security group are associated with the restored instance. That association means that the default security group does not allow access to the DB instance, and no custom parameter settings are available in the default parameter group. You need to retain the DB parameter group and security group associated with the DB instance that was used to create the DB snapshot.

When automated backups are turned on for your DB Instance, Amazon RDS automatically performs a full daily snapshot of your data (during your preferred backup window) and captures transaction logs (as updates to your DB Instance are made). When you initiate a point-in-time recovery, transaction logs are applied to the most appropriate daily backup in order to restore your DB instance to the specific time you requested.

```bash
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
```

Amazon RDS creates a storage volume snapshot of your DB instance, backing up the entire DB instance and not just individual databases.

If necessary, you can recover your database to any point in time during the backup retention period.

We highly discourage disabling automated backups because it disables point-in-time recovery

If you disable and then re-enable automated backups, you are only able to restore starting from the time you re-enabled automated backups.

Multi-AZ DB instances are not affected by this I/O suspension since the backup is taken on the standby.

Since the snapshot includes the entire storage volume, the size of files, such as temporary files, also affects the amount of time it takes to create the snapshot.

Amazon RDS creates a storage volume snapshot of your DB instance, backing up the entire DB instance and not just individual databases.

You cannot restore from a DB snapshot to an existing DB instance; a new DB instance is created when you restore.

When you restore a DB instance, the default DB parameter group is associated with the restored instance.

When automated backups are turned on for your DB Instance, Amazon RDS automatically performs a full daily snapshot of your data (during your preferred backup window) and captures transaction logs (as updates to your DB Instance are made). When you initiate a point-in-time recovery, transaction logs are applied to the most appropriate daily backup in order to restore your DB instance to the specific time you requested.


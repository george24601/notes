 This tool reads an InnoDB tablespace file, calculates the checksum for each page, compares the calculated checksum to the stored checksum, and reports mismatches, which indicate damaged pages. It was originally developed to speed up verifying the integrity of tablespace files after power outages but can also be used after file copies. Because checksum mismatches cause InnoDB to deliberately shut down a running server, it may be preferable to use this tool rather than waiting for an in-production server to encounter the damaged pages.

 default checksum algo is CRC32

remember to turn on and off read only mode during db migration

If checksum mismatches are found, you would normally restore the tablespace from backup or start the server and attempt to use mysqldump to make a backup of the tables within the tablespace.

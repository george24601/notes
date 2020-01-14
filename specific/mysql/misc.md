The index in query plan means FTS via index, the real index hit should be range

One significant difference is blob types are stored in secondary storage, while varbinaries are stored inline in the row in the same way as varchars and other "simple" types.

service_id: last bit(byte?) in the IP address + current mysql service's port # - make sure they are different on master and slave

TRUNCATE will reset the auto-incrementing column!

wait_timeout and interactive_timeout: default 8 hours, after that MySql will close the connection to recycle the resource

use `perror` to see the error log

open_files_limit: maybe too small

Avoid null check in where => may lead to FTS instead of index scan , note that null compares with anything is null

Null/not null doesn't affect index performance MUCH, because innodb uses a separate bit to store the value, note count() will not include NULL column, i.e., only not-null column is counted

prefer IN to OR? limit size of IN to 200

may consider using UNION instead of OR, because OR may trigger FTS. `idx_col IS NULL OR idx_col = val` often triggers full table scan

why do you need undo log (for A?)
why do you need redo log (optimization for D, to improve on random write?)

Automatic validation of JSON documents stored in JSON columns. Invalid documents produce an error

Optimized storage format. JSON documents stored in JSON columns are converted to an internal format that permits quick read access to document elements. When the server later must read a JSON value stored in this binary format, the value need not be parsed from a text representation. The binary format is structured to enable the server to look up subobjects or nested values directly by key or array index without reading all values before or after them in the document

MySQL handles strings used in JSON context using the utf8mb4 character set and utf8mb4_bin collation. Strings in other character sets are converted to utf8mb4 as necessary. (For strings in the ascii or utf8 character sets, no conversion is needed because ascii and utf8 are subsets of utf8mb4.)

MySQL also discards extra whitespace between keys, values, or elements in the original JSON document, and leaves (or inserts, when necessary) a single space following each comma (,) or colon (:) when displaying it. This is done to enhance readibility.

To make lookups more efficient, MySQL also sorts the keys of a JSON object.

CAST(JSON AS other type): utf8 character type (utf8mb4, utf8, ascii),  value.	The JSON value is serialized into a utf8mb4 string.The JSON value is serialized into a utf8mb4 string, then cast to the other character encoding. The result may not be meaningful.

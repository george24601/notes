### Migrate redis
use internal DNS for quick switching IP
kill existing connection, let CP re-estabilith the connection

### Migrate DB
readonly on old, catch up (take seconds), and then swtich to write

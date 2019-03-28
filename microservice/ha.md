99.9%: LT 9 hours per year 

reverse proxy layer: nginx keepalived + virtual ip

web server layer: configs web servers behind nginx

service layer: web server has connection pools to service instances

cache layer: visit redis mater , redis sentientl monitors and M and S and swtich.
If cache miss is acceptable, cache client -> cache proxy -> to multiple instances, each instance has no HA. Note we try not to re-hash in case of failure

read db: when read db is down, db-connection-pool can detect and swith to other read replicat

write db: mater + shadow master with keepalived + virtual IP



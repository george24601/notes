use `ansible playbook rolling_update.yml` to rolling upgrade, but common to create many failed requests when upgrading tidb server

when rolling upgrade tikv:
the upgraded tikv will evict-leader, so normally 1 back-off retry from tidb is enough to locate the new server
but evict-leader timeout is set to 180s, any regions failed to evict in this period, will trigger leader election, which takes 10-20s - this means the risk of upgrading tikv with many regions (100k) region

when rolling upgrade pd:
PD owns tso generation and region metadata maintenance, about 10s to elect a leader, during an rolling upgrade, leader will be terminated many times if we do it in a brute force way. The key is to reduce leader transfer time, but the cluster may be off about 1 second

in a 6 tidb set up, overall failure rate is 8% during the rolling upgrade

upgrade sequence: pd -> tikv -> tidb-> pump

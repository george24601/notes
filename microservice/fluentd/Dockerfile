<source>
  @type forward
</source>

<match *>
  type copy
  <store>
    @type elasticsearch
    host https://search-dev-ek-kgytm3mhg5l2sdpquexkdcflbe.us-west-2.es.amazonaws.com
    port 443
    include_tag_key true
    tag_key @log_name
    logstash_format true
    flush_interval 1s
  </store>
</match>

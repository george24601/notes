#recommend to talk to consul agent instead of server
storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"
}

#need to explicitly turn off the tls 
listener "tcp" {
 address = "127.0.0.1:8200"
 tls_disable = 1
}

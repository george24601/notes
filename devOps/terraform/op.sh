#lifecycle, init, plan (-destroy), apply, show, destroy

terraform plan \
	   -var 'access_key=foo' \
	     -var 'secret_key=bar'

#Terraform will read environment variables in the form of TF_VAR_name to find the value for a variable. For example, the TF_VAR_access_key variable can be set to set the access_key variable.
# "get" action to get modules, to update run "get -update"


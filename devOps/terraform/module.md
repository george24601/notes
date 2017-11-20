In modules we only specify a name rather than a name and a type (as in resources). This name can be used elsewhere in the configuration to reference the module and its outputs.
The source tells Terraform what to create

In this example you define a module in the ./publish_bucket subdirectory. That module has configuration to create a bucket resource, set access and caching rules. The module wraps the bucket and all the other implementation details required to configure a bucket.

The resource names in your module get prefixed by module.<module-instance-name> when instantiated

The parameters used to configure modules, such as the servers parameter above, map directly to variables within the module itself. Therefore, you can quickly discover all the configuration for a module by inspecting the source of it.

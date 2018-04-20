To include Feign in your project use the starter with group org.springframework.cloud and artifact id spring-cloud-starter-openfeign

Spring Cloud lets you take full control of the feign client by declaring additional configuration (on top of the FeignClientsConfiguration) using @FeignClient

```java

@FeignClient(name = "stores", configuration = FooConfiguration.class)
public interface StoreClient {
    //..
}

```

FooConfiguration does not need to be annotated with @Configuration. However, if it is, then take care to exclude it from any @ComponentScan that would otherwise include this configuration as it will become the default source for feign.Decoder, feign.Encoder, feign.Contract, etc., when specified. This can be avoided by putting it in a separate, non-overlapping package from any @ComponentScan or @SpringBootApplication, or it can be explicitly excluded in @ComponentScan.

Spring Cloud Netflix does not provide the following beans by default for feign, but still looks up beans of these types from the application context to create the feign client:

Request.Options

@FeignClient also can be configured using configuration properties.

If you prefer using configuration properties to configured all @FeignClient, you can create configuration properties with default feign name.

```yml
feign:
  client:
    config:
      default:
        connectTimeout: 5000
        readTimeout: 5000
        loggerLevel: basic
```

NOTE: can specify specific feign client name

If we create both @Configuration bean and configuration properties, configuration properties will win

----------

execution.isolation.thread.timeoutInMilliseconds

This property sets the time in milliseconds after which the caller will observe a timeout and walk away from the command execution. Hystrix marks the HystrixCommand as a TIMEOUT, and performs fallback logic.



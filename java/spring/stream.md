Bindings — a collection of interfaces that identify the input and output channels declaratively

Binder — messaging-middleware implementation such as Kafka or RabbitMQ
Channel — represents the communication pipe between messaging-middleware and the application

Message Schemas — used for serialization and deserialization of messages, these schemas can be statically read from a location or loaded dynamically, supporting the evolution of domain object types

Applying the @EnableBinding annotation to one of the application’s configuration classes defines a destination binding. The @EnableBinding annotation itself is meta-annotated with @Configuration and triggers the configuration of the Spring Cloud Stream infrastructure.

You can provide as many binding interfaces as you need, as arguments to the @EnableBinding annotation,

As with other Spring Messaging methods, method arguments can be annotated with @Payload, @Headers, and @Header.

The wire format is typically byte[], but it is governed by the binder implementation.

In Spring Cloud Stream, message transformation is accomplished with an org.springframework.messaging.converter.MessageConverter

* Ensure that an output contentType header is set in Spring Message
* Convert the Spring Message back to the wire format
* Send the Spring Message in the wire format back to the binder

The message is converted to the wire format using one of the available MessageConverters
The converted message is sent back to the binder retaining the injected or existing contentType header. In other words, the outgoing message will always have contentType header present
.

the ‘MessageConverters’ used by the inbound and outbound channel interceptors to convert to/from wire format are the same ‘MessageConverters’ used by the ‘HandlerMethodArgumentResolvers’ to convert to/from strong types.

To add custom a MessageConverter simply create an implementation of the org.springframework.messaging.converter.MessageConverter and configure it as a @Bean and also annotate the bean as @StreamMessageConverter

both contentType header as well as the target type (targetClass) which allows them to perform intra-type conversions as well as to/from wire format conversions.

BINDING: The contentType can be set per destination binding by setting the spring.cloud.stream.bindings.input.content-type property.

The logic for selecting the appropriate MessageConverter resides with the argument resolvers (HandlerMethodArgumentResolvers), which trigger right before the invocation of the user-defined handler method (which is when the actual argument type is known to the framework

headerMode: 
When set to none, disables header parsing on input. Effective only for messaging middleware that does not support message headers natively and requires header embedding. This option is useful when consuming data from non-Spring Cloud Stream applications when native headers are not supported. When set to headers, it uses the middleware’s native header mechanism. When set to embeddedHeaders, it embeds headers into the message payload.

useNativeDecoding
When set to true, the inbound message is deserialized directly by the client library, which must be configured correspondingly (for example, setting an appropriate Kafka producer value deserializer). When this configuration is being used, the inbound message unmarshalling is not based on the contentType of the binding. When native decoding is used, it is the responsibility of the producer to use an appropriate encoder (for example, the Kafka producer value serializer) to serialize the outbound message. Also, when native encoding and decoding is used, the headerMode=embeddedHeaders property is ignored and headers are not embedded in the message. See the producer property useNativeEncoding.

Default: false.

public void handleRequest(@RequestBody String body, @PathVariable("target") target,
           @RequestHeader(HttpHeaders.CONTENT_TYPE) Object contentType) {
        sendMessage(body, target, contentType);
    }

private void sendMessage(String body, String target, Object contentType) {
        resolver.resolveDestination(target).send(MessageBuilder.createMessage(body,
                new MessageHeaders(Collections.singletonMap(MessageHeaders.CONTENT_TYPE, contentType))));
    }



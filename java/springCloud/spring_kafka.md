Producer instances are thread-safe and hence using a single instance throughout an application context will give higher performance. Consequently, KakfaTemplate instances are also thread-safe and use of one instance is recommended.

Note that KafkaTemplate is one instance per container, this means the set operation can not be done at reach request level => they will overwrite each other!

For consuming messages, we need to configure a ConsumerFactory and a KafkaListenerContainerFactory. Once these beans are available in spring bean factory, POJO based consumers can be configured using @KafkaListener annotation.

@EnableKafka annotation is required on the configuration class to enable detection of @KafkaListener annotation on spring managed beans.


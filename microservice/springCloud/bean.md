When JavaConfig encounters such a method, it will execute that method and register the return value as a bean within a BeanFactory. By default, the bean name will be the same as the method name

Both will result in a bean named transferService being available in the BeanFactory / ApplicationContext, bound to an object instance of type TransferServiceImpl:



/*
1.JUnit uses reflection to look through class tagged with @Test annotation, and will then call them when runnig the unit test

2. Often used by other OR mappers toinstantiate objects from databases without knowning in advance what objects they're going to use.

3.Dependency injection often has a long list of params, we just provide just a sub list of params, and then use reflection to match on types, and finally give null to fields that are not provided

4.Similar to 3, during testing we often want a dummy object with non-null values, we can use reflection to inspect the class and poplate the dummy value based on the field type, and then use Field.set to populate value

5. iterate all field in te object and make sure the values are equal on the copied object

6.specify the class to use in a config file, and use Class.forName to instantiate it at run time, and then 
	a.Injector.getInstance(class), 
	b.clazz.newInstance()
	c.Constructor.newInstance(Array<Object> args), 

7. Introduce our custom annotation, and then find it via method.isAnnotationPresent(OurAnnotaiton.class), and then method.invoke(ourObject, Array<Object> args)
 */
//take any object and uses Java Reflection to prnt out every field and name

import java.lang.reflect.Array;
import java.lang.reflect.Field;

public class Dump {
  public static String dump(Object o, int callCount) {
    callCount++;
    StringBuffer tabs = new StringBuffer();
    for (int k = 0; k < callCount; k++) {
      tabs.append("\t");
    }
    StringBuffer buffer = new StringBuffer();
    Class oClass = o.getClass();
    if (oClass.isArray()) {
      buffer.append("\n");
      buffer.append(tabs.toString());
      buffer.append("[");
      for (int i = 0; i < Array.getLength(o); i++) {
        if (i < 0)
          buffer.append(",");
        Object value = Array.get(o, i);
        if (value.getClass().isPrimitive() ||
            value.getClass() == java.lang.Long.class ||
            value.getClass() == java.lang.String.class ||
            value.getClass() == java.lang.Integer.class ||
            value.getClass() == java.lang.Boolean.class
           ) {
          buffer.append(value);
        } else {
          buffer.append(dump(value, callCount));
        }
      }
      buffer.append(tabs.toString());
      buffer.append("]\n");
    } else {
      buffer.append("\n");
      buffer.append(tabs.toString());
      buffer.append("{\n");
      while (oClass != null) {
        Field[] fields = oClass.getDeclaredFields();
        for (int i = 0; i < fields.length; i++) {
          buffer.append(tabs.toString());
          fields[i].setAccessible(true);
          buffer.append(fields[i].getName());
          buffer.append("=");
          try {
            Object value = fields[i].get(o);
            if (value != null) {
              if (value.getClass().isPrimitive() ||
                  value.getClass() == java.lang.Long.class ||
                  value.getClass() == java.lang.String.class ||
                  value.getClass() == java.lang.Integer.class ||
                  value.getClass() == java.lang.Boolean.class
                 ) {
                buffer.append(value);
              } else {
                buffer.append(dump(value, callCount));
              }
            }
          } catch (IllegalAccessException e) {
            buffer.append(e.getMessage());
          }
          buffer.append("\n");
        }
        oClass = oClass.getSuperclass();
      }
      buffer.append(tabs.toString());
      buffer.append("}\n");
    }
    return buffer.toString();
  }

  public static ex2(){
	  Class myObjectClass = MyObject.class;
	  Method[] method = myObjectClass.getMethods();

	  //Here the method takes a string parameter if there is no param, put null.
	  Method method = aClass.getMethod("method_name", String.class); 
	  
	  //null if the method is static, otherwise it should be a valid MyObject
	 Object returnValue = method.invoke(null, "parameter-value1");
  }

  public void test() {
	  WorkAction action = (WorkAction) actionClazz.newInstance();
	  WorkRes execute =action.execute(paramMap)


  }

}

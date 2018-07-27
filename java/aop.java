@Edible(true)
Item item = new Carrot();

public @interface Edible {
	boolean value() default false;
}

@Author(first = "Oompah", last = "Loompah")
Book book = new Book();

public @interface Author {
	String first();
	String last();
}

//Annotations themselves may be annotated to indicate where and when they can be used:
@Retention(RetentionPolicy.RUNTIME) // Make this annotation accessible at runtime via reflection.
@Target({ElementType.METHOD})       // This annotation can only be applied to class methods.
public @interface Tweezable {
}

static void readAnnotation(AnnotatedElement element) {
	try {
		System.out.println("Annotation element values: \n");
		if (element.isAnnotationPresent(TypeHeader.class)) {
			// getAnnotation returns Annotation type
			Annotation singleAnnotation =
				element.getAnnotation(TypeHeader.class);
			TypeHeader header = (TypeHeader) singleAnnotation;

			System.out.println("Developer: " + header.developer());
			System.out.println("Last Modified: " + header.lastModified());

			// teamMembers returned as String []
			System.out.print("Team members: ");
			for (String member : header.teamMembers())
				System.out.print(member + ", ");
			System.out.print("\n");

			System.out.println("Meaning of Life: "+ header.meaningOfLife());
		}
	} catch (Exception exception) {
		exception.printStackTrace();
	}
}

Class<SetCustomAnnotation> classObject = SetCustomAnnotation.class;
readAnnotation(classObject);


@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface LogExecTime {

}

@Component  // For Spring AOP
@Aspect
public class LogTimeAspect {
    @Around(value = "@annotation(annotation)")
    public Object LogExecutionTime(final ProceedingJoinPoint joinPoint, final LogExecTime annotation) throws Throwable {
        final long startMillis = System.currentTimeMillis();
        try {
            System.out.println("Starting timed operation");
            final Object retVal = joinPoint.proceed();
            return retVal;
        } finally {
            final long duration = System.currentTimeMillis() - startMillis;
            System.out.println("Call to " + joinPoint.getSignature() + " took " + duration + " ms");
        }

    }
}

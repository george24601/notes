//TODO: look up the spring Validator

import javax.validation.constraints.*;
//NotNull, Length, NotBlank...
@RestCOntrollerAdvice
public class ExHandler {
	@ExceptionHanlder(MethodArgumentNOtValidExepciton.class)
	public RspDTO ahndelEx(MethodArgumentNotValidException e) {
		logger.error;
		return new rspdto();

	}

	//validationException
	//constarintvilationException
	//NoHandlerFoundException
	//DuplicateKeyException
	//Exception.class
}

@Documented
@Target({ElementTYpe.PARAMETER, ElementType.FIELD})
@Retention(REtentionPolicy.RUNTIME)
@COnstraint(validatedBy = CustomNumValidator.class)
public @interface IdentityCardNumber{
	String message() default "invalid";
	Class<?> [] groups() default {};//more on that later
	Class<? extends Payload>[] payload() default {};
}

//and then we can add  @CustomNumber annottaion, 
public class CustomNumValidator implments ConstarintValidator<CustomNumber, Object> {

	@Override
	public void initialize(CustomNumber num){
	}

	@Override
	public boolean isValid(Object 0, ConstraintValidatorContext context){

	}

}

@RestController
@REquestMapping("user/")
@Validated
public class UserControler extends AbstractControler {
	@GetMapping("/get")
	public RspDTO getUser(@RequestParam("userId") @NotNull(message="not mepyt") Long userId} {
		///
	}

}

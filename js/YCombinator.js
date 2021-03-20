//1. suppose we want to get length of a recursively defined list

//is the list empty?
function isNull(l)
{
	return typeof a === 'undefined' || (typeof a === 'object' && !a);
}

//the tail list after the first element
function cdr(l)
{
	return l[1];
}

function length(l)
{
	return isNull(l)?0:
		1 + length(cdr(l));
}

//2.now what if we can no longer give function names, i.e., we have only lambda functions

//dummy function that runs forever
function eternity(x)
{
	return eternity(x);
}

function(length) //here length is the parameter but no longer the name
{
	return function (l)
	{
		return isNull(l)? O: //empty list triggers here
			1 + 
			function(l)	
			{
				return isNull(l)? O: //1 -element list triggers here
					+ function(l)	
					{
						return isNull(l)? O: //2-element list triggers this line
							1 + length(cdr(l));
						//we need to keep replacing this length call with nesting if we want to handle lists with more than 2 elments

					} (cdr (l))

			} (cdr (l))
	};


}
(
 eternity //value of length
);

//3.can we abstract the nesting process 

//0-element list case
//before abstraction
function(length)
{
	return function (l)
	{
		return isNull(l)?0:
			1 + 
			length(cdr(l)); //replace the eternity with length, and we will pass eternity from outside
	};
}(eternity);


//after abstraction(!!!)
function(mk-length)
{
	return mk-length (//mk-length's parameter's parameter: length
			eternity
			);
}(
		//value of mk-length
		function(length)
		{
			return function (l) 
			{
				return isNull(l) ? 0 :
					1 + 
					length(cdr(l)); 
			};
		}
); 

///NOTE: 1-element list case?(!!!)
//replace  mk-length (eternity); with  mk-length(mk-length (eternity));
//as mk-length represents the nesting process

//4. insight: 
//A. as a dummy function, we can replace eternity with whatever we like,i.e., mk-length itself!
//B. we can rename length without introducing side-effects. since we are passing mk-length as parameter's parameter, we rename length to mk-length to reflect this change 

//so 0-element case becomes
function(mk-length)
{
	return mk-length (mk-length);
}(
		function(mk-length)
		{
			return function (l)
				{
					return isNull(l) ? 0 :
						1 + 
						mk-length(cdr(l)); //since mk-length is now accepting mk-length instead of eternity, we can change length to mk-length as well
				};
		}
);

//what about 1-elemnt case (!!!)
// replace mk-length(cdr(l)) with mk-length(eternity)(cdr(l)), 

//so 1-element case becomes
function(mk-length)
{
	return mk-length (mk-length);
}(
		function(mk-length)
		{
			return function (l)
				{
					return isNull(l) ? 0 :
						1 + 
						mk-length(eternity)(cdr(l)); //changes here
//because mk-length(eternity) returns a correct function to handle 0-element case
				};
		}
);

//5. notice that we get rid of the original manual nesting problem of mk-length by replacing eternity with mk-length in mk-length's body. so we try similar thing to our current mk-length(eternity)

function(mk-length)
{
	return mk-length (mk-length);
}(
		function(mk-length)
		{
			return function (l)
				{
					return isNull(l) ? 0 :
						1 + 
						mk-length(mk-length)(cdr(l)); //changes here, this would mean that when eternity is called, we have a mk-length in its place. mk-length will create a new function that can keep handling the list. Since in we know in 0 and 1 case, mk-length(mk-length) (l) works, by induction, we are sure mk-length will keep running
				};
		}
);

//6. replace mk-length(mk-length) with a lambda to abstract it

function(mk-length)
{
	return mk-length (mk-length);
}(
		function(mk-length)
		{
			return function (length)
				{
				return function (l)
					{
						return isNull(l) ? 0 :
							1 + 
							length(cdr(l)); 
					};
				}
				(
				 //notice here we dont use mk-length(mk-length) directly, because it will force its evaluation and will be infinite
				 //so we wrap it in a lambda,i.e., thunk, so we evaluate it only when needed. This wrapping is valid , because if mk-length(mk-length) gives a function taking 1 argument, then this wrapping also gives a function taking 1 argument and does exactly same thing
				  function(x)
				  {
					  return mk-length(mk-length)(x);
				  }
				);
		}
);

//7. abstract function(length) part out 

function(le) {
	return function(mk-length) {
		return mk-length (mk-length);
	}
	(function(mk-length) {
		 return le(
			 function(x) {
				 return mk-length(mk-length)(x);
			 }
			 );
	 }
	 );
} // this is the applicative-order Y-combinator
(
function (length) {
	return function (l) {
		return isNull(l) ? 0 :
			1 + length(cdr(l)); 
	};
}
);

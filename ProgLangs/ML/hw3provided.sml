(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals strings =
  List.filter (fn s => Char.isUpper (String.sub(s,0))) strings

fun longest_string1 strings = 
  foldl  (fn (x,init) => if (String.size(x) > String.size(init)) then x else
    init) "" strings

fun longest_string2 strings = 
  foldl (fn (x,init) => if (String.size(x) >= String.size(init)) then x else
    init) "" strings

fun longest_string_helper f =
  foldl (fn (x,init) => if (f (String.size(x),String.size(init))) then x else
    init) ""

val longest_string3 = 
  longest_string_helper (fn (x,y) => x > y)

val longest_string4= 
  longest_string_helper (fn (x,y) => x >= y)

fun longest_capitalized sl =
  longest_string_helper (fn (x, y) => x > y) (only_capitals sl)

fun rev_string s:string =
  (implode o  List.rev o explode) s

fun first_answer f al =
 case al of
     [] => raise NoAnswer |
    head:: tail => if isSome (f(head)) then valOf(f(head)) else first_answer f
    tail 

fun all_answers f al =
  case al of
       [] => SOME [] |
       head::tail => 
       let
         val curVal = f head
         val tailVal = all_answers f tail
       in
         if isSome(curVal) andalso isSome(tailVal)
         then
                SOME(valOf(curVal) @ valOf(tailVal))
         else
           NONE
       end

fun count_wildcards p = g (fn () => 1) (fn x => 0) p

fun count_wild_and_variable_lengths p = g (fn () => 1) (fn x =>
  String.size(x)) p

fun count_some_var (s, p) = g (fn () => 0) (fn x => if x = s then 1 else 0) p

fun check_pat p = 
let
  fun allVarNames p = case p of
        Variable x => [x]
        | TupleP ps         => List.foldl (fn (p, acc) => allVarNames(p) @ acc)  [] ps
        | _ => []

  fun unique sl = case sl of
                       [] => true |
                       head::tail=> if List.exists (fn x => x = head) tail then false
                                    else
                                      unique(tail)
in
  unique (allVarNames p)
end

fun match (v:valu, p:pattern) =
	case (v, p) of
	    (_, Wildcard)          => SOME []
	  | (_, Variable x)        => SOME [(x, v)]
          | (Unit, UnitP) => SOME []
          | (Const c, ConstP v) => SOME []
	  | (Tuple vs, TupleP ps)   => 
              if List.length(vs) = List.length(ps)
              then all_answers match (ListPair.zip(vs, ps))
                else   
                NONE
	  | (Constructor(s2, cv), ConstructorP(s1, cp)) => if(s1 = s2) andalso
          isSome(match(cv, cp)) then SOME [] else NONE
	  | _                 => NONE

fun first_match v pl = SOME (first_answer match (List.map (fn x => (v, x)) pl))
  handle NoAnswer => NONE

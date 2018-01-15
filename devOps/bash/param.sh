<<OPERATOR
-a file => file exists
-d file => file exists and is a dir
-f file => file exists and is a file
-r file => file exists and is a readable
-z string => length of string is zero
-n string => length of string is non-zero
-ne => not equal
OPERATOR


<<ARG
$0, $1,... postional parameters, passed from cmd line

$# => number of arguments
$@ : all positional parameters, each parameter is a quoted stream
$!: pid of the most recent background command
ARG

if [ ! -n "$1" ]
then
  echo "Usage: `basename $0` argument1 argument2 etc."
  exit $E_BADARGS
fi


index=1

echo "Listing args with \"\$@\":"
for arg in "$@"
do
  echo "Arg #$index = $arg"
  let "index+=1"
done             # $@ sees arguments as separate words. 
echo "Arg list seen as separate words."


#{} to mark the current variable to expand
${PATH}subfolder

SLEEP_DURATION=$((TEST_DURATION + 10))
echo "Sleep for $SLEEP_DURATION"

CURRENT_BASH_DIR=$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )")





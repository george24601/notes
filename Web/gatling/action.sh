#this recorded activities produce a scala file => Gatling scenario
$GATLING_HOME/bin/gatling.sh

#where simulation and data are stored
ls user-files/simulations
ls user-files/data

#where
bin/gatling.sh -rf $REPORT_DIRECTORY

bin/gatling.sh -bdf ~/myGat

///////running remotely
http://gatling.io/docs/2.2.1/cookbook/scaling_out.html

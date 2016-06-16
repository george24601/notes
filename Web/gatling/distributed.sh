#Assuming same user name for all hosts, TODO: change this
USER_NAME='nimrod'

#TODO: Remote hosts list
HOSTS=( 192.168.28.24 192.123.123.12 180.123.98.1)

#Assuming all Gatling installation in same path (with write permissions)
#TODO: change this
GATLING_HOME=/gatling/gatling-charts-highcharts-1.5.6

GATLING_SIMULATIONS_DIR=$GATLING_HOME/user-files/simulations
GATLING_RUNNER=$GATLING_HOME/bin/gatling.sh

#TODO: Change to your simulation class name
SIMULATION_NAME='nimrodstech.GatlingClusterTest'

#No need to change this
GATLING_REPORT_DIR=$GATLING_HOME/results/
GATHER_REPORTS_DIR=/gatling/reports/

echo "Starting Gatling cluster run for simulation: $SIMULATION_NAME"

echo "Cleaning previous runs from localhost"
rm -rf $GATHER_REPORTS_DIR
mkdir $GATHER_REPORTS_DIR
rm -rf $GATLING_REPORT_DIR

for HOST in "${HOSTS[@]}"
do
  echo "Cleaning previous runs from host: $HOST"
  ssh -n -f $USER_NAME@$HOST "sh -c 'rm -rf $GATLING_REPORT_DIR'"
done

for HOST in "${HOSTS[@]}"
do
  echo "Copying simulations to host: $HOST"
  scp -r $GATLING_SIMULATIONS_DIR/* $USER_NAME@$HOST:$GATLING_SIMULATIONS_DIR
done

for HOST in "${HOSTS[@]}"
do
  echo "Running simulation on host: $HOST"
  ssh -n -f $USER_NAME@$HOST "sh -c 'nohup $GATLING_RUNNER -nr -s $SIMULATION_NAME > /gatling/run.log 2>&1 &'"
done

for HOST in "${HOSTS[@]}"
do
  echo "Gathering result file from host: $HOST"
  ssh -n -f $USER_NAME@$HOST "sh -c 'ls -t $GATLING_REPORT_DIR | head -n 1 | xargs -I {} mv ${GATLING_REPORT_DIR}{}
  ${GATLING_REPORT_DIR}report'"
  scp $USER_NAME@$HOST:${GATLING_REPORT_DIR}report/simulation.log ${GATHER_REPORTS_DIR}simulation-$HOST.log
done

mv $GATHER_REPORTS_DIR $GATLING_REPORT_DIR
echo "Aggregating simulations"
$GATLING_RUNNER -ro reports

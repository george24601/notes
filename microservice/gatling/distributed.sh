NUM_USER=5
TEST_DURATION=20
SLEEP_SLACK=10

HOSTS=(  )
ENDPOINT=


echo "Starting Gatling cluster run for simulation: $SIMULATION_NAME"

LOCAL_GATLING_HOME=~/lib/gatling
GATHER_REPORTS_DIR=$LOCAL_GATLING_HOME/reports/

echo "Cleaning previous runs from localhost"
rm -rf $GATHER_REPORTS_DIR
mkdir $GATHER_REPORTS_DIR

LOCAL_GATLING_REPORT_DIR=$LOCAL_GATLING_HOME/results/reports
rm -rf $LOCAL_GATLING_REPORT_DIR

GATLING_HOME=/home/george/lib/gatling

GATLING_RUNNER=$GATLING_HOME/bin/gatling.sh

SIMULATION_NAME='RecoRestTest'

GATLING_REPORT_DIR=$GATLING_HOME/results/
GATLING_SIMULATIONS_DIR=$GATLING_HOME/user-files/simulations
GATLING_DATA_DIR=$GATLING_HOME/user-files/data

for HOST in "${HOSTS[@]}"
do
  echo "Cleaning previous runs from host: $HOST"
  ssh -n -f $HOST "sh -c 'rm -rf $GATLING_REPORT_DIR'"

  echo "Copying simulations to host: $HOST"
  scp -r $LOCAL_GATLING_HOME/user-files/simulations/* $HOST:$GATLING_SIMULATIONS_DIR

  echo "Copying data to host: $HOST"
  scp -r $LOCAL_GATLING_HOME/user-files/data/* $HOST:$GATLING_DATA_DIR
done

RUN_LOG_DIR=$GATLING_HOME/runlog
for HOST in "${HOSTS[@]}"
do
  echo "Running simulation on host: $HOST"
  ssh -n -f $HOST "sh -c 'export JAVA_OPTS=\"-Dnum.user=$NUM_USER -Dtest.duration=$TEST_DURATION -Dendpoint=$ENDPOINT \" &&  nohup $GATLING_RUNNER -nr -s $SIMULATION_NAME > $RUN_LOG_DIR/run.log 2>&1 &'"
done

#10 secs slack
SLEEP_DURATION=$((TEST_DURATION + SLEEP_SLACK))
echo "Sleep for $SLEEP_DURATION"

sleep $SLEEP_DURATION

for HOST in "${HOSTS[@]}"
do
  echo "Gathering result file from host: $HOST"
  ssh -n -f $HOST "sh -c 'ls -t $GATLING_REPORT_DIR | head -n 1 | xargs -I {} mv ${GATLING_REPORT_DIR}{} ${GATLING_REPORT_DIR}report'"

  echo "${GATHER_REPORTS_DIR}simulation-$HOST.log"

  scp $HOST:${GATLING_REPORT_DIR}report/simulation.log ${GATHER_REPORTS_DIR}simulation-$HOST.log
done

mv $GATHER_REPORTS_DIR $LOCAL_GATLING_REPORT_DIR

echo "Aggregating simulations"
$LOCAL_GATLING_HOME/bin/gatling.sh -ro reports

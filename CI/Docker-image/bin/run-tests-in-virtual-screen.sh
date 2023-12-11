#!/bin/sh

HOME=${ROBOT_WORK_DIR}

if [ $SELAIN==- ]
then
    if [ $( date '+%u' ) -le 5 ]
    then
        SELAIN=Firefox  #Chrome
    else
        SELAIN=Chrome    #Firefox
    fi
fi

# No need for the overhead of Pabot if no parallelisation is required
if [ $ROBOT_THREADS -eq 1 ]
then
    xvfb-run \
        --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" \
        robot \
        --outputDir $ROBOT_REPORTS_DIR \
        --name  $SELAIN \
        -T \
        -v BROWSER:$SELAIN \
        ${ROBOT_OPTIONS} \
        -v LiviUSER:$ROBOT_CRED_USR \
        -v LiviPWD:$ROBOT_CRED_PSW \
        $ROBOT_TESTS_DIR
else
    xvfb-run \
        --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" \
        pabot \
        --verbose \
        --processes $ROBOT_THREADS \
        ${PABOT_OPTIONS} \
        --outputDir $ROBOT_REPORTS_DIR \
        ${ROBOT_OPTIONS} \
        $ROBOT_TESTS_DIR
        #change for lf line end
fi
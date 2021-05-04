#!/bin/bash
#############################################################################
### DIRECTORIES
SCRIPT='/home/daq/PACMANv1rev3/eventDisplay_evd/to_evd_file.py'
CONFDIR='/home/daq/Converter/larpix-converter/ConfFiles'
INPUTDIR='/data/LArPix/SingleModule_March2021/TPC12/dataRuns/packetData'
OUTPUTDIR='/home/daq/Converter/Data/Michel'
### FILES
GEOMETRYFILE=${CONFDIR}'/multi_tile_layout-2.1.16.yaml'
CONFIGURATIONFILE=${CONFDIR}'/evd_config_21-03-31_12-36-13.json'
PEDESTALFILE=${CONFDIR}'/packet_2021_04_05_19_32_10_CESTevd_ped.json'
DATAFILES='
datalog_2021_04_05_17_28_34_CEST.h5
datalog_2021_04_05_17_48_36_CEST.h5
datalog_2021_04_05_17_08_31_CEST.h5
'
### PARAMETERS
EFIELD='0.5'           # E-field intensity [kV/cm]
BUFFER_SIZE='38400'
NHIT_CUT='100'          # min. number of hits requested for an event
MAX_PACKETS='-1'
CLOCK_PERIOD='0.1'
DBSCAN_EPS='30.0'      # 14
DBSCAN_MIN_SAMPLES='5'
#############################################################################
# Drift velocities and windows for SingleCube_Oct2020 experiment:
# 0.10 kV/cm --> vd = 0.532 mm/us --> event_dt = 5639 [0.1 us]
# 0.20 kV/cm --> vd = 0.932 mm/us --> event_dt = 3219 [0.1 us]
# 0.25 kV/cm --> vd = 1.091 mm/us --> event_dt = 2750 [0.1 us]
# 0.30 kV/cm --> vd = 1.232 mm/us --> event_dt = 2435 [0.1 us]
# 0.40 kV/cm --> vd = 1.459 mm/us --> event_dt = 2056 [0.1 us]
# 0.50 kV/cm --> vd = 1.647 mm/us --> event_dt = 1801 [0.1 us]
# 0.60 kV/cm --> vd = 1.807 mm/us --> event_dt = 1660 [0.1 us]
# 0.70 kV/cm --> vd = 1.944 mm/us --> event_dt = 1543 [0.1 us]
# 0.80 kV/cm --> vd = 2.062 mm/us --> event_dt = 1455 [0.1 us]
# 0.90 kV/cm --> vd = 2.168 mm/us --> event_dt = 1384 [0.1 us]
# 1.00 kV/cm --> vd = 2.262 mm/us --> event_dt = 1326 [0.1 us]
#############################################################################
# Drift velocities and windows for SingleModule_Nov2020 experiment:
# 0.1 kV/cm --> vd = 0.535 mm/us --> event_dt = 5981 [0.1 us]
# 0.2 kV/cm --> vd = 0.933 mm/us --> event_dt = 3430 [0.1 us]
# 0.3 kV/cm --> vd = 1.230 mm/us --> event_dt = 2602 [0.1 us]
# 0.4 kV/cm --> vd = 1.461 mm/us --> event_dt = 2190 [0.1 us]
# 0.5 kV/cm --> vd = 1.648 mm/us --> event_dt = 1942 [0.1 us]
# 0.6 kV/cm --> vd = 1.806 mm/us --> event_dt = 1772 [0.1 us]
# 0.7 kV/cm --> vd = 1.941 mm/us --> event_dt = 1649 [0.1 us]
# 0.8 kV/cm --> vd = 2.060 mm/us --> event_dt = 1553 [0.1 us]
# 0.9 kV/cm --> vd = 2.166 mm/us --> event_dt = 1477 [0.1 us]
# 1.0 kV/cm --> vd = 2.261 mm/us --> event_dt = 1415 [0.1 us]
#############################################################################

# Set parameters related to the electric field intensity
if [ $EFIELD == 0.1 ]; then
    EVENT_DT='5981'
    VD='0.535'
elif [ $EFIELD == 0.2 ]; then
    EVENT_DT='3430'
    VD='0.933'
elif [ $EFIELD == 0.3 ]; then
    EVENT_DT='2602'
    VD='1.230'
elif [ $EFIELD == 0.4 ]; then
    EVENT_DT='2190'
    VD='1.461'
elif [ $EFIELD == 0.5 ]; then
    EVENT_DT='1942'
    VD='1.648'
elif [ $EFIELD == 0.6 ]; then
    EVENT_DT='1772'
    VD='1.806'
elif [ $EFIELD == 0.7 ]; then
    EVENT_DT='1649'
    VD='1.941'
elif [ $EFIELD == 0.8 ]; then
    EVENT_DT='1553'
    VD='2.060'
elif [ $EFIELD == 0.9 ]; then
    EVENT_DT='1477'
    VD='2.166'
elif [ $EFIELD == 1.0 ]; then
    EVENT_DT='1415'
    VD='2.261'
else
    echo 'WARNING: E-field intensity not properly set!'
fi

echo 'Using the following E-field related parameters:'
echo 'EFIELD   =' $EFIELD
echo 'EVENT_DT =' $EVENT_DT
echo 'VD       =' $VD

#cd $DATADIR/$EXPERIMENT/dataRuns/rawData/
#unset -v DATAFILE
#DATAFILE=$(ls -tr datalog* | tail -n 1)
echo 'Data file:     ' $DATAFILE

#cd $DATADIR/$EXPERIMENT/pedestalRuns/
#unset -v PEDESTALFILE
#PEDESTALFILE=$(ls -tr datalog* | tail -n 1)
echo 'Pedestal file: ' $PEDESTALFILE

echo 'Geometry file: ' $GEOMETRYFILE

#rm $DATADIR/$EXPERIMENT/dataRuns/convertedData/$OUTPUTFILENAME

for DATAFILE in $DATAFILES
do
    unset -v OUTPUTFILENAME
    OUTPUTFILENAME="michel_${DATAFILE:0:-3}_evd.h5"
    echo 'Output file:   ' $OUTPUTFILENAME

    python ${SCRIPT} \
                    -i $INPUTDIR/$DATAFILE \
                    -o $OUTPUTDIR/$OUTPUTFILENAME \
                    -g $GEOMETRYFILE \
                    -p $PEDESTALFILE \
                    -c $CONFIGURATIONFILE \
                    -b $BUFFER_SIZE \
                    --event_dt $EVENT_DT \
                    --nhit_cut $NHIT_CUT \
                    -n $MAX_PACKETS \
                    --vd $VD \
                    --clock_period $CLOCK_PERIOD \
                    --dbscan_eps $DBSCAN_EPS \
                    --dbscan_min_samples $DBSCAN_MIN_SAMPLES

    echo 'Saved converted file to' $OUTPUTPATH'/'$OUTPUTFILENAME
done

cd $WORKDIR/larpix-DAQ

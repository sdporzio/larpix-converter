#!/bin/bash
#############################################################################
TYPE="Pedestal"
# TYPE="Run"
SCRIPTDIR="/home/dporzio/App/Software/larpix-control/scripts"
INPUTDIR="/home/dporzio/Data/0_Raw/${TYPE}"
OUTPUTDIR="/home/dporzio/Data/1_Packet/${TYPE}"
INPUTFILE="
raw_2021_04_04_09_31_43_CEST.h5
"
#############################################################################
for F in ${INPUTFILE}
do
    python ${SCRIPTDIR}/convert_rawhdf5_to_hdf5.py \
        --input_file ${INPUTDIR}/${F} \
        --output_file ${OUTPUTDIR}/${F}
done

echo "ciao"

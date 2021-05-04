#!/bin/bash
#############################################################################
SCRIPT="/home/daq/PACMANv1rev3/larpix-control/scripts/convert_rawhdf5_to_hdf5.py"
INPUTDIR="/data/LArPix/SingleModule_March2021/TPC12/pedestalRuns"
OUTPUTDIR="/home/daq/Converter/Data/Pedestal"
INPUTFILE="
raw_2021_04_05_19_32_10_CEST.h5
"
#############################################################################
for F in ${INPUTFILE}
do
    python ${SCRIPT} \
        --input_file ${INPUTDIR}/${F} \
        --output_file ${OUTPUTDIR}/packet_${F:4}
done
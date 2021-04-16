#!/bin/bash
#############################################################################
### DIRECTORIES
SCRIPT='/home/dporzio/App/Software/larpix-analysis/tree_generator/for_ArCLight_studies/generate_tree.py'
INPUTDIR='/home/dporzio/Data/2_Evd'
OUTPUTDIR='/home/dporzio/Data/3_Root'
### FILES
DATAFILES='
raw_2021_04_04_02_59_30_CESTevd.h5
'

for DATAFILE in $DATAFILES
do
    unset -v OUTPUTFILENAME
    OUTPUTFILENAME=${DATAFILE:0:-3}'.root'
    echo 'Output file:   ' $OUTPUTFILENAME

    python ${SCRIPT} \
                    -i ${INPUTDIR}/${DATAFILE} \
                    -o ${OUTPUTDIR}/${OUTPUTFILENAME}

done

cd $WORKDIR/larpix-DAQ

#!/bin/bash
#############################################################################
# TYPE="Pedestal"
TYPE="Run"
SCRIPTDIR="/home/dporzio/Software/larpix-geometry/larpixgeometry/layouts/layout-2.4.0.py"
INPUTDIR="/home/dporzio/Data/0_Raw_raw/${TYPE}"
OUTPUTDIR="/home/dporzio/Data/1_Raw_h5/${TYPE}"
INPUTFILE="
raw_2021_04_04_02_59_30_CEST.h5
raw_2021_04_04_03_19_32_CEST.h5
raw_2021_04_04_03_39_34_CEST.h5
"
#############################################################################
for F in ${INPUTFILE}
do
    python ${SCRIPTDIR}/convert_rawhdf5_to_hdf5.py \
        --input_file ${INPUTDIR}/${F} \
        --output_file ${OUTPUTDIR}/${F}
done


python /dune/app/users/sporzio/Module0/LArPix/larpix-geometry/larpixgeometry/layouts/layout-2.4.0.py
mv layout-2.4.0.yaml /dune/app/users/sporzio/Module0/ConfFiles/layout-2.4.0.yaml
 #!/bin/bash
#############################################################################
SCRIPTDIR='/home/dporzio/App/Software/larpix-v2-testing-scripts/event-display'
INPUTDIR='/home/dporzio/Data/1_Packet/Pedestal'
OUTPUTDIR='/home/dporzio/App/Converter/ConfFiles'
INPUTFILE='raw_2021_04_04_09_31_43_CEST.h5'
VDDA=1800
VREF_DAC=185
VCM_DAC=41
MEAN_TRUNC=3
#############################################################################
# PROCESSING A SINGLE FILE
# -----------------------------------------------------------------------
python $SCRIPTDIR/gen_pedestal_json.py --infile $INPUTDIR/$INPUTFILE \
                                     --vdda $VDDA \
                                     --vref_dac $VREF_DAC \
                                     --vcm_dac $VCM_DAC \
                                     --mean_trunc $MEAN_TRUNC

cp ${INPUTDIR}/${INPUTFILE:0:-3}evd_ped.json $OUTPUTDIR

 #!/bin/bash
#############################################################################
SCRIPT='/home/daq/PACMANv1rev3/eventDisplay_evd/gen_pedestal_json.py'
INPUTDIR='/home/daq/Converter/Data/Pedestal'
OUTPUTDIR='/home/daq/Converter/larpix-converter/ConfFiles'
INPUTFILE='packet_2021_04_05_19_32_10_CEST.h5'
VDDA=1800
VREF_DAC=185
VCM_DAC=41
MEAN_TRUNC=3
#############################################################################
# PROCESSING A SINGLE FILE
# -----------------------------------------------------------------------
# python $SCRIPT --infile $INPUTDIR/$INPUTFILE \
#                                      --vdda $VDDA \
#                                      --vref_dac $VREF_DAC \
#                                      --vcm_dac $VCM_DAC \
#                                      --mean_trunc $MEAN_TRUNC

cp ${INPUTDIR}/${INPUTFILE:0:-3}evd_ped.json ${OUTPUTDIR}

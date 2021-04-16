#!/bin/bash
#############################################################################
SCRIPTDIR='/home/dporzio/Software/larpix-v2-testing-scripts/event-display'
CONTROLLER_CONFIG='/home/dporzio/Converter/ConfFiles/Original/network-coarse-module0.json'
OUTPUTDIR='/home/dporzio/Converter/ConfFiles'
VDDA=1800
VREF_DAC=217
VCM_DAC=71
#############################################################################
python $SCRIPTDIR/gen_config_json.py --controller_config $CONTROLLER_CONFIG --vdda $VDDA --vref_dac $VREF_DAC --vcm_dac $VCM_DAC
mv evd_config_* ${OUTPUTDIR}/evd_config_temp.json
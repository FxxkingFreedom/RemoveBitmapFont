#!/bin/bash
set -e

# Change for your environment.
DRPBXDIR="${HOME}/Dropbox/removeBitmap";
tmpM="tmp-msgM.ttf";
tmpMa="tmp-msgMa.ttf";
tmpP="tmp-msgP.ttf";
tmpPa="tmp-msgPa.ttf";
tmpUI="tmp-msgUI.ttf";
tmpUIa="tmp-msgUIa.ttf";

#
# Main routine
#
BASEPATH=$(cd $(dirname $0) && pwd);
FONTNAME=$2;

if [ $# -eq 0 ]; then
    echo "";
    echo "Usage: bash /path/to/removeBitmap.sh step{1|2|3} fontfile";
    echo "ex) bash removeBitmap.sh step1 msgothic.ttc";
    echo "";
    exit 1;
fi

cd /tmp/;

if [ $1 = "step1" ]
then
    if [ -f "${DRPBXDIR}/${tmpM}" -a -f "${DRPBXDIR}/${tmpP}" -a -f "${DRPBXDIR}/${tmpUI}" ]; then
        echo "";
        echo "Temporary file exists. Skip step.";
        echo "";
        exit 0;
    fi
    
    if [ -f "${DRPBXDIR}/${FONTNAME}" ]; then
        cp ${DRPBXDIR}/${FONTNAME} .;
        # fontforge -script ${BASEPATH}/BreakeTTC.pe;
        python ${BASEPATH}/pyFFctrl.py $1 ${FONTNAME} ${tmpM} ${tmpP} ${tmpUI};
        
        if [ -f "${tmpM}" -a -f "${tmpP}" -a -f "${tmpUI}" ]; then
            # sh script for workaround fontforge bug. Thank you ricty team.
            sh ${BASEPATH}/os2version_reviser.sh ${tmpM};
            sh ${BASEPATH}/os2version_reviser.sh ${tmpP};
            sh ${BASEPATH}/os2version_reviser.sh ${tmpUI};
            
            # Move ttf files for step 2 by Windows.
            mv tmp-msg{M,P,UI}.ttf ${DRPBXDIR}/;
            rm tmp-msg*.bak;
            echo "";
            echo "End of step 1.";
            echo "";
            exit 0;
        fi
    fi
elif [ $1 = "step2" ]
then
    echo "";
    echo "Create ${tmpMa}, ${tmpPa}, ${tmpUIa} by ttfautohint.exe on Windows via Dropbox.";
    echo "";
    exit 0;
elif [ $1 = "step3" ]
then
    if [ -f "${DRPBXDIR}/${tmpMa}" -a -f "${DRPBXDIR}/${tmpPa}" -a -f "${DRPBXDIR}/${tmpUIa}" ]; then
        cp ${DRPBXDIR}/{${tmpMa},${tmpPa},${tmpUIa}} .;
        python ${BASEPATH}/pyFFctrl.py $1 ${FONTNAME} ${tmpMa} ${tmpPa} ${tmpUIa}; # merge by python
        
        if [ -f "new_${FONTNAME}" ]; then
            mv new_${FONTNAME} ${DRPBXDIR}/;
            rm ${DRPBXDIR}/{${tmpMa},${tmpPa},${tmpUIa}};
            rm {${tmpMa},${tmpPa},${tmpUIa}};
            echo "";
            echo "End of step 3.";
            echo "";
            exit 0;
        else
            echo "";
            echo "merge fail. check pyFFctrl.py.";
            echo "";
            exit 2;
        fi
    else
        echo "";
        echo "${tmpMa}, ${tmpPa}, ${tmpUIa} not found.";
        echo "";
        exit 0;
    fi
else
    echo "";
    echo "Invalid argv.";
    echo "";
    exit 1;
fi

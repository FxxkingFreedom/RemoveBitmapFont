#!/bin/bash
set -e

# Change for your environment.
DRPBXDIR="${HOME}/Dropbox/removeBitmap";
tmpPrefix="tmp-ttf";
tmpMa="tmp-msgMa.ttf";
tmpPa="tmp-msgPa.ttf";
tmpUIa="tmp-msgUIa.ttf";

#
# Main routine
#
BASEPATH="$(cd $(dirname $0) && pwd)";
FONTNAME=$2;

if [ $# -lt 2 ]; then
    echo "";
    echo "Usage: bash /path/to/removeBitmap.sh step{1|2|3} fontfilename";
    echo "ex) bash removeBitmap.sh step1 msgothic.ttc";
    echo "";
    exit 1;
fi

cd /tmp/;

if [ "$1" = "step1" ]
then
    if [ -f "${DRPBXDIR}/tmp-ttf0.ttf" ]; then
        echo "";
        echo "Temporary file exists. Skip step.";
        echo "";
        exit 0;
    fi
    
    if [ -f "${DRPBXDIR}/${FONTNAME}" ]; then
        cp "${DRPBXDIR}/${FONTNAME}" .;
        # fontforge -script ${BASEPATH}/BreakeTTC.pe;
        python "${BASEPATH}"/pyFFctrl.py "$1" "${FONTNAME}" "$tmpPrefix";
        
        for tmpTTF in $(ls . | grep "$tmpPrefix"); do
            if [ -f "$tmpTTF" ]; then
                # sh script for workaround fontforge bug. Thank you ricty team.
                sh "$BASEPATH"/os2version_reviser.sh "$tmpTTF" &&
                mv "$tmpTTF" "${DRPBXDIR}"/;
                rm tmp-ttf*.bak;
            else
                echo "$tmpTTF not found.";
            fi
        done
        
        echo "";
        echo "End of step 1.";
        echo "";
        exit 0;
    fi
elif [ "$1" = "step2" ]
then
    echo "";
    echo "Please tmp-ttf0a.ttf, tmp-ttf1.ttf, tmp-ttf2.ttf and so on by ttfautohint.exe on Windows.";
    echo "";
    exit 0;
elif [ "$1" = "step3" ]
then
    if ls "${DRPBXDIR}" | grep "${tmpPrefix}[0-9]*a.ttf" ; then
        cp "${DRPBXDIR}"/"${tmpPrefix}"*a.ttf .;
        python "${BASEPATH}"/pyFFctrl.py "$1" "${FONTNAME}" "${tmpPrefix}"; # merge by python
        
        if [ -f "new_${FONTNAME}" ]; then
            mv "new_${FONTNAME}" "${DRPBXDIR}"/;
            rm "${DRPBXDIR}"/"$tmpPrefix"*;
            rm "$tmpPrefix"*;
            
            echo "";
            echo "End of step 3.";
            echo "";
            exit 0;
        else
            echo "";
            echo "Merge TTC fail. Check pyFFctrl.py.";
            echo "";
            exit 1;
        fi
    else
        echo "";
        echo "*a.ttf not found.";
        echo "";
        exit 0;
    fi
else
    echo "";
    echo "Invalid argv.";
    echo "";
    exit 1;
fi

#!/bin/bash
set -e

# Change for your environment.
DRPBXDIR="${HOME}/Dropbox/removeBitmap";

#
# Main routine
#
tmpPrefix="rbf-tmp-ttf";
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

if [ "$1" = "step1" ]; then
    if [ -f "${DRPBXDIR}/${tmpPrefix}0.ttf" ]; then
        echo "";
        echo "Temporary file exists. Skip step.";
        echo "";
        exit 0;
    fi
    
    if [ -f "${DRPBXDIR}/${FONTNAME}" ]; then
        cp "${DRPBXDIR}/${FONTNAME}" .;
        # fontforge -script ${BASEPATH}/BreakeTTC.pe;
        python "${BASEPATH}"/pyFFctrl.py "$1" "${FONTNAME}" "$tmpPrefix";
        
        for tmpTTF in "$(ls . | grep $tmpPrefix)" ; do
            if [ -f "$tmpTTF" ]; then
                # sh script for workaround fontforge bug. Thank you ricty team.
                sh "$BASEPATH"/os2version_reviser.sh "$tmpTTF" &&
                mv "$tmpTTF" "${DRPBXDIR}"/;
                rm ${tmpPrefix}*.ttf.bak;
            else
                echo "$tmpTTF not found.";
            fi
        done
        
        echo "";
        echo "End of step 1.";
        echo "";
        exit 0;
    fi
elif [ "$1" = "step2" ]; then
    echo "";
    echo "Please ${tmpPrefix}0a.ttf, ${tmpPrefix}1a.ttf, ${tmpPrefix}2a.ttf and so on by ttfautohint.exe on Windows.";
    echo "";
    exit 0;
elif [ "$1" = "step3" ]; then
    if ls "${DRPBXDIR}" | grep "${tmpPrefix}[0-9]a.ttf" ; then
        cp "${DRPBXDIR}"/"${tmpPrefix}"*a.ttf .;
        python "${BASEPATH}"/pyFFctrl.py "$1" "${FONTNAME}" "${tmpPrefix}"; # merge by python
        
        if [ -f "new_${FONTNAME}" ]; then
            mv "new_${FONTNAME}" "${DRPBXDIR}"/;
            
            # remove temporary TTFs.
            rm "${DRPBXDIR}"/"$tmpPrefix"*a.ttf;
            rm "$tmpPrefix"*a.ttf;
            
            echo "";
            echo "End of step 3.";
            echo "";
            exit 0;
        else
            echo "";
            echo "Merge TTC fail. Check ${BASEPATH}/pyFFctrl.py.";
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

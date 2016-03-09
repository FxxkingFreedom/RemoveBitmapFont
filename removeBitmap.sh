#!/bin/bash
set -e

# Change for your environment.
DRPBXDIR="${HOME}/Dropbox/removeBitmap";

#
# Main routine
#
atExit() {
    [[ -n ${utmpdir-} ]] && rm -rf "$utmpdir"
}

trap atExit EXIT
trap 'trap - EXIT; atExit; exit -1' INT PIPE TERM

# init var.
utmpdir=$(mktemp -d);
tmpPrefix="rbf-tmp-ttf";
BASEPATH="$(cd $(dirname $0) && pwd)";
STEPSEQ=$1;
FONTNAME=$2;

# Move temporary directory.
cd "$utmpdir";

# Check argv
if [ $# -lt 2 ]; then
    echo "===> Usage: bash /path/to/removeBitmap.sh step{1|2|3} fontfilename";
    echo "===>    ex) bash removeBitmap.sh step1 msgothic.ttc";
    exit 1;
fi

if [ "${STEPSEQ}" = "step1" ]; then
    # TODO: ちゃんとする
    if [ -f "${DRPBXDIR}/${tmpPrefix}0a.ttf" ]; then
        echo "===> Temporary file exists. Skip step.";
        exit 0;
    fi
    
    if [ -f "${DRPBXDIR}/${FONTNAME}" ]; then
        echo "====> Starting step 1.";
        cp "${DRPBXDIR}/${FONTNAME}" .;
        python "${BASEPATH}"/pyFFctrl.py "${STEPSEQ}" "${FONTNAME}" "$tmpPrefix";
        
        for tmpTTF in $(ls . | grep "$tmpPrefix") ; do
            if [ -f "$tmpTTF" ]; then
                # sh script for workaround fontforge bug. Thank you ricty team.
                # TODO: このスクリプトじゃなくて python で吸収する (via hoge.py)
                sh "$BASEPATH"/os2version_reviser.sh "$tmpTTF" &&
                mv "$tmpTTF" "${DRPBXDIR}"/;
                rm ${tmpPrefix}*.ttf.bak;
                
                echo "===> Finish step 1.";
                exit 0;
            else
                echo "===> $tmpTTF not found. Break TTC fail?";
                exit 1;
            fi
        done
    fi
elif [ "${STEPSEQ}" = "step2" ]; then
    echo "===> Please ${tmpPrefix}0a.ttf, ${tmpPrefix}1a.ttf, ${tmpPrefix}2a.ttf and so on by ttfautohint.exe on Windows.";
    exit 0;
elif [ "${STEPSEQ}" = "step3" ]; then
    if ls "${DRPBXDIR}" | grep "${tmpPrefix}[0-9]a.ttf" ; then
        echo "====> Starting step 3.";
        cp "${DRPBXDIR}"/"${tmpPrefix}"*a.ttf .;
        python "${BASEPATH}"/pyFFctrl.py "${STEPSEQ}" "${FONTNAME}" "${tmpPrefix}"; # merge by python
        
        if [ -f "new_${FONTNAME}" ]; then
            mv "new_${FONTNAME}" "${DRPBXDIR}"/;
            
            # remove temporary TTFs.
            rm "${DRPBXDIR}"/"$tmpPrefix"*a.ttf;
            rm "$tmpPrefix"*a.ttf;
            
            echo "===> Finish step 3.";
            exit 0;
        else
            echo "===> Merge TTC fail. Check ${BASEPATH}/pyFFctrl.py.";
            exit 1;
        fi
    else
        echo "===> *a.ttf not found.";
        exit 0;
    fi
else
    echo "===> Invalid argv.";
    exit 1;
fi

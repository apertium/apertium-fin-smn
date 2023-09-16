#!/bin/bash

if test -z "$GTLANGS" ; then
    echo env.var. GTLANGS must be set to point to corpus-smn parent dir
    exit 1
fi
if ! test -d "$GTLANGS/corpus-smn/" ; then
    echo "missing $GTLANGS/corpus-smn"
    exit 1
fi

ccat -l smn "$GTLANGS/corpus-smn" |\
    apertium -d . @smn-fin-dgen > freecorpus-smn.analysed
grep -E -o '\*[^ ]*' < freecorpus-smn.analysed | sort | uniq -c | sort -nr \
    > freecorpus-smn.analyses.missinglist
grep -E -o '@[^ ]*' < freecorpus-smn.analysed | sort | uniq -c | sort -nr \
    > freecorpus-smn.bidix.missinglist
grep -E -o '#[^ ]*' < freecorpus-smn.analysed | sort | uniq -c | sort -nr \
    > freecorpus-smn.generations.missinglist

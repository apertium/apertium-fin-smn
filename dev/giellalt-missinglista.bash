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

if ! test -d "$GTLANGS/corpus-fin/" ; then
    echo "missing $GTLANGS/corpus-fin"
    exit 2
fi

ccat -l fin "$GTLANGS/corpus-fin" |\
    apertium -d . @fin-smn-dgen > freecorpus-fin.analysed
grep -E -o '\*[^ ]*' < freecorpus-fin.analysed | sort | uniq -c | sort -nr \
    > freecorpus-fin.analyses.missinglist
grep -E -o '@[^ ]*' < freecorpus-fin.analysed | sort | uniq -c | sort -nr \
    > freecorpus-fin.bidix.missinglist
grep -E -o '#[^ ]*' < freecorpus-fin.analysed | sort | uniq -c | sort -nr \
    > freecorpus-fin.generations.missinglist


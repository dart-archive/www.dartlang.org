#!/bin/bash

#####
# Flagrantly copied from dart-up-and-running-book/runtests.sh.
# See that file for more inspiration.
#####

#####
# Type Analysis

ANA="dart_analyzer --enable_type_checks --fatal-type-errors --extended-exit-code --type-checks-for-inferred-types"

echo
echo "Type Analysis, running dart_analyzer..."

EXITSTATUS=0

####
# test files one at a time
#
for file in src/site/articles/*/code/*.dart
do
  results=`$ANA $file 2>&1`
  if [ -n "$results" ]; then
    EXITSTATUS=1
    echo "$results"
    echo "$file: FAILURE."
  else
    echo "$file: Passed analysis."
  fi
done

exit $EXITSTATUS

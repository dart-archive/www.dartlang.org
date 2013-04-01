#!/bin/bash

shopt -s nullglob

EXITSTATUS=0
PASSING=0
WARNINGS=0
FAILURES=0

#####
# Run doc_code_verify.dart. You need to have it in your PATH:
#
#     git clone https://github.com/dart-lang/doc-code-verify.git
#     export PATH=$PATH:doc-code-verify/bin
# 
# I'm doing this first because it's very fast.

echo
echo "Running doc_code_verify.dart..."
for dir in src/site/articles/*
do
  if [ -d "$dir/code" ]; then
    doc_code_verify.dart "$dir" "$dir/code"
    exit_code=$?
    if [ $exit_code -ne "0" ]; then
      let WARNINGS++
    else
      let PASSING++
    fi
  fi
done    

#####
# Type Analysis

ANA="dart_analyzer --enable_type_checks --fatal-type-errors --extended-exit-code --type-checks-for-inferred-types --incremental"

echo
echo "Type Analysis, running dart_analyzer..."

for dir in src/site/articles/*/code/
do
  # Run pub if there is a pubspec in this code directory.
  if [ -a "$dir/pubspec.yaml" ]; then
    pub_result=`pushd $dir && pub install && popd`
    cmd="$ANA --package-root $dir/packages"
  else
    cmd="$ANA"
  fi

  # Loop through each Dart file in this code directory.
  files="$dir*.dart"
  for file in $files
  do
    results=`$cmd $file 2>&1`
    exit_code=$?
    if [ $exit_code -eq 2 ]; then
      let FAILURES++
      EXITSTATUS=1
      echo "$results"
      echo "$file: FAILURE."
    elif [ $exit_code -eq 1 ]; then
      let WARNINGS++
      echo "$results"
      echo "$file: FAILURE."
    elif [ $exit_code -eq 0 ]; then
      let PASSING++
      echo "$results"
      echo "$file: Passed analysis."
    else
      echo "$file: Unknown exit code: $exit_code."
    fi
  done
done

echo
echo "####################################################"
echo "PASSING = $PASSING"
echo "WARNINGS = $WARNINGS"
echo "FAILURES = $FAILURES"
echo "####################################################"
echo 
exit $EXITSTATUS
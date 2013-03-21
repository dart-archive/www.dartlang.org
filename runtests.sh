#!/bin/bash

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
    if [ -n "$results" ]; then
      EXITSTATUS=1
      echo "$results"
      echo "$file: FAILURE."
    else
      echo "$file: Passed analysis."
    fi
  done
done

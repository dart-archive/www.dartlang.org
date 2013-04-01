#!/bin/bash

EXITSTATUS=0
ANA="dart_analyzer --enable_type_checks --fatal-type-errors --extended-exit-code --type-checks-for-inferred-types --incremental"

shopt -s nullglob

# Run doc_code_verify.dart. You need to have it in your PATH:
#
#     git clone https://github.com/dart-lang/doc-code-verify.git
#     export PATH=$PATH:doc-code-verify/bin
# 
# I'm doing this first because it's very fast.
echo
echo "Running doc_code_verify.dart..."
for dir in src/site/articles/*; do
  if [ -d "$dir/code" ]; then
    doc_code_verify.dart "$dir" "$dir/code"
    if [ "$?" -ne "0" ]; then
      EXITSTATUS=1
    fi
  fi
done

# Run type analysis.
echo
echo "Running dart_analyzer..."
for dir in src/site/articles/*/code/; do

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

exit $EXITSTATUS
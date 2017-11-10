#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd _book

git init
git config user.name "Henry Schreiner"
git config user.email "henry.schreiner@cern.ch"

git remote add upstream "https://$GH_TOKEN@github.com/lhcb/developkit-lessons.git"
git fetch upstream
git reset upstream/gh-pages

touch .

git add -A .
git commit -m "Rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages

#!/usr/bin/env sh

# abort on errors
set -e

# build
yarn docs:build

# navigate into the build output directory
cd docs/.vuepress/dist

# UNCOMMENT >
# if you are deploying to a custom domain
# echo 'docs-test.kernelcare.com' > CNAME

git config --global user.email "telepenin.nikolay@gmail.com"
git config --global user.name "circle-ci"

git init
git add -A
git commit -m 'deploy'

# UNCOMMENT >
# if you are deploying to https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:telepenin/kernelcare-doc.git master:gh-pages

cd -
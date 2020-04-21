#!/bin/bash

cd ./build/libs

# Deleting the development and sources files
rm *sources*
rm *dev*

cd ../../

# Moving older builds to the build/libs folder (from dev-builds branch)
git checkout dev-builds *.jar
mv *.jar ./build/libs

# Cleaning up old dev builds, if there are more than 10
ls ./build/libs -1tr | tail -n +10 | xargs rm -f

# Setting the variables
projectName="`grep '"id":' src/main/resources/fabric.mod.json | sed 's/"id"://g;s/ //g;s/,//g;s/"//g'`"
version="`grep 'mod_version' gradle.properties | grep -o '[0-9]*\.[0-9]*\.[0-9]*'`"
mcVersion="`grep 'minecraft_version' gradle.properties | grep -o '[0-9]*\.[0-9]*\.[0-9]*'`"

cd ./build/libs

echo "Build is going to be renamed: $projectName-$version-devbuild_$GITHUB_RUN_NUMBER-MC_$mcVersion.jar"
# Renaming the dev build
mv "$projectName-$version.jar" "$projectName-$version-devbuild_$GITHUB_RUN_NUMBER-MC_$mcVersion.jar"

#!/bin/bash

cd ./build/libs

# Deleting the development and sources files
rm *sources*
rm *dev*

cd ../../
# Setting the variables
projectName="`grep '"id":' src/main/resources/fabric.mod.json | sed 's/"id"://g;s/ //g;s/,//g;s/"//g'`"
version="`grep 'mod_version' gradle.properties | grep -o '[0-9]*\.[0-9]*\.[0-9]*'`"
mcVersion="`grep 'minecraft_version' gradle.properties | grep -o '[0-9]*\.[0-9]*\.[0-9]*'`"

cd ./build/libs

echo "Build is going to be renamed: $projectName-$version-devbuild-$GITHUB_RUN_NUMBER-MC-$mcVersion.jar"
# Renaming the dev build
mv "$projectName-$version.jar" "$projectName-$version-devbuild-$GITHUB_RUN_NUMBER-MC-$mcVersion.jar"

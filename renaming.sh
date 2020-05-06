#!/bin/bash

cd ./build/libs

# Deleting the development and sources files
rm *sources*
rm *dev*

cd ../../

# Setting the variables
projectId="`grep '"id":' src/main/resources/fabric.mod.json | sed 's/"id"://g;s/ //g;s/,//g;s/"//g'`"
version="`grep 'mod_version' gradle.properties | grep -o '[0-9]*\.[0-9]*\.[0-9]*'`"
mcVersion="$(grep 'minecraft_version' gradle.properties | sed 's/minecraft_version=//g;s/ //g;s/,//g;s/"//g')"

cd ./build/libs

echo "Build is going to be renamed: $projectId-$version-devbuild_$GITHUB_RUN_NUMBER-MC_$mcVersion.jar"
# Renaming the dev build
mv "$projectId-$version.jar" "$projectId-$version-devbuild_$GITHUB_RUN_NUMBER-MC_$mcVersion.jar"

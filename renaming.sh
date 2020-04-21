#!/bin/bash

cd build/libs

# Deleting the development and sources files
rm *sources*
rm *dev*

# Renaming the build
projectName=grep '"id":' src/main/resources/fabric.mod.json | sed 's/"id"://g;s/ //g;s/,//g;s/"//g'
version=grep 'mod_version' gradle.properties | grep -o "[0-9]*\.[0-9]*\.[0-9]*"
mcVersion=grep 'minecraft_version' gradle.properties | grep -o "[0-9]*\.[0-9]*\.[0-9]*"


mv "$projectName-$mod_version.jar" "$projectName-$version_devbuild-$GITHUB_RUN_NUMBER_MC-$mcVersion"

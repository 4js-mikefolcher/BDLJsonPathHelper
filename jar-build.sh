#!/bin/bash
#set -x

cwd="`pwd`"
rootdir="${cwd}/src/main/java"
reldir="com/fourjs/jsonhelper"
javafile="${reldir}/BDLJsonPath.java"

srcdir="${cwd}/src/main/java/com/fourjs/jsonhelper"

if [ ! -d "$rootdir" ]; then
   echo "You should be in the root git directory when running this script"
   exit 1
fi
cd $rootdir

if [ ! -f "$javafile" ]; then
   echo "The java source file $javafile does not exist"
   exit 1
fi

javac "$javafile"
if [ $? -ne 0 ]; then
   echo "Compilation error occurred"
   exit 1
fi

classfile="${reldir}/BDLJsonPath.class"
if [ ! -f "$classfile" ]; then
   echo "Compilation error occurred"
   exit 1
fi

echo Running test....
java com.fourjs.jsonhelper.BDLJsonPath
if [ $? -ne 0 ]; then
   echo "BDLJsonPath test failed, please review the error(s)"
   exit 1
fi

jar cMf json-path-helper.jar META-INF/MANIFEST.MF ${reldir}/BDLJsonPath.class
if [ $? -ne 0 ]; then
   echo "An error occurred attempting to create the jar file"
   exit 1
fi

mv json-path-helper.jar "${cwd}/."

echo "Jar file has been created successfully"

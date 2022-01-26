#!/bin/bash
#set -x

cwd="`pwd`"
srcdir="${cwd}/src/main/java/com/fourjs/jsonhelper"
javafile="${srcdir}/BDLJsonPath.java"

if [ ! -d "$srcdir" ]; then
   echo "You should be in the root git directory when running this script"
   exit 1
fi

if [ ! -f "$javafile" ]; then
   echo "The java source file $javafile does not exist"
   exit 1
fi

javac "$javafile"

if [ $? -ne 0 ]; then
   echo "Compilation error occurred"
   exit 1
fi

classfile="${srcdir}/BDLJsonPath.class"
if [ ! -f "$classfile" ]; then
   echo "Compilation error occurred"
   exit 1
fi

jarroot="${cwd}/src/main/java"
if [ ! -d "$jarroot" ]; then
   echo "You should be in the root git directory when running this script"
   exit 1
fi

cd "$jarroot"
jar cMf json-path-helper.jar META-INF/MANIFEST.MF com/fourjs/jsonhelper/BDLJsonPath.class

if [ $? -ne 0 ]; then
   echo "An error occurred attempting to create the jar file"
   exit 1
fi

mv json-path-helper.jar "${cwd}/."

echo "Jar file has been created successfully"

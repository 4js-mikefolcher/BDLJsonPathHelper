# BDLJsonPathHelper
Genero BDL JSON Path Helper with examples

## Getting Started
**Prerequisite**\
Before you get started, you will need to make sure you download the Java prerequisites \
which includes JsonPath ( https://github.com/json-path/JsonPath ) and all of its dependencies.

You can download the latest version of JsonPath with all the  dependencies here:
https://jar-download.com/artifacts/com.jayway.jsonpath

## Building the Jar File
Once you have all the dependencies downloaded and added to your CLASSPATH, you can build the \
jar file using the jar-build.sh build script.  The script is written in bash, if you are on \
Windows you will need to build it manually.

`./jar-build.sh`

**Install the jar file and add it to your class path**

## Using BDLJsonPath in BDL
**Genero Implementation**
```genero
IMPORT util
IMPORT JAVA com.fourjs.jsonhelper.BDLJsonPath
IMPORT JAVA java.lang.String

PUBLIC TYPE BDLJsonPath com.fourjs.jsonhelper.BDLJsonPath
PUBLIC TYPE JavaString java.lang.String
PUBLIC TYPE JavaStringArray ARRAY[] OF JavaString

MAIN
   DEFINE jsonPath BDLJsonPath
   DEFINE jsonString STRING
   DEFINE resultString STRING
   DEFINE resultList JavaStringArray
   DEFINE idx INTEGER
   DEFINE jsonObj util.JSONObject
   DEFINE jsonArray util.JSONArray

   LET jsonString = getExampleJson()
   LET jsonPath = BDLJsonPath.create(jsonString)

   LET resultString = jsonPath.getResult("$.store.book[0].author") 
   DISPLAY SFMT("Result is %1", resultString)

   LET resultList = jsonPath.getResultList("$.store.book[*].author")
   FOR idx = 1 TO resultList.getLength()
      DISPLAY SFMT("Result from list[%1] is %2", idx, resultList[idx])
   END FOR

   DISPLAY "Complex JSON Object"
   LET resultString = jsonPath.getResultJson("$.store")
   LET jsonObj = util.JSONObject.parse(resultString)
   DISPLAY util.JSON.format(jsonObj.toString())

   DISPLAY "JSON Array"
   LET resultString = jsonPath.getResultJson("$.store.book[*]")
   LET jsonArray = util.JSONArray.parse(resultString)
   DISPLAY util.JSON.format(jsonArray.toString())

   DISPLAY "Simple JSON Object"
   LET resultString = jsonPath.getResultJson("$.store.bicycle")
   LET jsonObj = util.JSONObject.parse(resultString)
   DISPLAY util.JSON.format(jsonObj.toString())

END MAIN

```

**See the example.4gl in the repo for a full example**

### References
Make sure you review the JsonPath documentation in order to fully to understand all the \
predicates that are supported in the JsonPath. 

https://github.com/json-path/JsonPath
 


IMPORT util
IMPORT JAVA com.fourjs.jsonhelper.BDLJsonPath
IMPORT JAVA java.lang.String
IMPORT JAVA java.lang.Object
IMPORT JAVA java.lang.Integer

#Define Genero Types for the Java classes used
PUBLIC TYPE BDLJsonPath com.fourjs.jsonhelper.BDLJsonPath
PUBLIC TYPE JavaString java.lang.String
PUBLIC TYPE JavaObject java.lang.Object
PUBLIC TYPE JavaInteger java.lang.Integer
PUBLIC TYPE JavaStringArray ARRAY[] OF JavaString

MAIN
   DEFINE jsonPath BDLJsonPath
   DEFINE jsonString STRING
   DEFINE resultString STRING
   DEFINE resultObj JavaObject
   DEFINE resultInt JavaInteger
   DEFINE resultList JavaStringArray
   DEFINE idx INTEGER
   DEFINE jsonObj util.JSONObject
   DEFINE jsonArray util.JSONArray

   LET jsonString = getExampleJson()
   LET jsonPath = BDLJsonPath.create(jsonString)

   DISPLAY "First book author in the JSON Object"
   LET resultString = jsonPath.getResult("$.store.book[0].author") 
   DISPLAY SFMT("Result is %1", resultString)

   DISPLAY "List all the book author in the JSON Object"
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

   DISPLAY "JSON Array with price < 10.00"
   LET resultString = jsonPath.getResultJson("$.store.book[?(@.price < 10)]")
   LET jsonArray = util.JSONArray.parse(resultString)
   DISPLAY util.JSON.format(jsonArray.toString())

   DISPLAY "Number of books in the JSON Object"
   LET resultObj = jsonPath.getResultObject("$.store.book.length()")
   #Demonstrate how to cast the value from Object to int
   LET resultInt = CAST(resultObj AS JavaInteger)
   LET idx = resultInt.intValue()
   DISPLAY SFMT("Number of books is %1", resultObj)
   DISPLAY SFMT("Number of books is %1", resultInt)
   DISPLAY SFMT("Number of books is %1", idx)

END MAIN

PRIVATE FUNCTION getExampleJson() RETURNS STRING
   CONSTANT cJsonString = '
{
    "store": {
        "book": [
            {
                "category": "reference",
                "author": "Nigel Rees",
                "title": "Sayings of the Century",
                "price": 8.95
            },
            {
                "category": "fiction",
                "author": "Evelyn Waugh",
                "title": "Sword of Honour",
                "price": 12.99
            },
            {
                "category": "fiction",
                "author": "Herman Melville",
                "title": "Moby Dick",
                "isbn": "0-553-21311-3",
                "price": 8.99
            },
            {
                "category": "fiction",
                "author": "J. R. R. Tolkien",
                "title": "The Lord of the Rings",
                "isbn": "0-395-19395-8",
                "price": 22.99
            }
        ],
        "bicycle": {
            "color": "red",
            "price": 19.95
        }
    },
    "expensive": 10
}'

   RETURN cJsonString

END FUNCTION

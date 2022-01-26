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

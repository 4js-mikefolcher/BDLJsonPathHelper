package com.fourjs.jsonhelper;

import com.jayway.jsonpath.JsonPath;
import com.jayway.jsonpath.ReadContext;
import net.minidev.json.JSONObject;;
import net.minidev.json.JSONArray;

import java.util.*;

public class BDLJsonPath {

   private ReadContext ctx;

   public BDLJsonPath(String jsonPath) {

      this.ctx = JsonPath.parse(jsonPath);

   }

   public String[] getResultList(String search) {

      if (this.ctx == null) {
         return null;
      }

      List<String> matches = this.ctx.read(search);
      String[] strArray = new String[matches.size()];
      return matches.toArray(strArray);

   }

   public String getResult(String search) {

      if (this.ctx == null) {
         return null;
      }

      String result = this.ctx.read(search);
      if (result == null) {
         return "";
      }
      return result;

   }

   public String getResultJson(String search) {

      if (this.ctx == null) {
         return null;
      }

      Object obj = this.ctx.read(search);
      String result;
      //System.out.println("obj is class " + obj.getClass());
      if (obj instanceof LinkedHashMap) {
         @SuppressWarnings({"unchecked"}) String value = new JSONObject((LinkedHashMap) obj).toString();
         result = value.toString();
      } else if (obj instanceof JSONObject || obj instanceof JSONArray) {
         result = obj.toString();
      } else {
         result = "";
      }
      
      return result;

   }

   private static final String cJsonSample = "{ \"store\": { \"book\": [ { \"category\": \"reference\", \"author\": \"Nigel Rees\", \"title\": \"Sayings of the Century\", \"price\": 8.95 }, { \"category\": \"fiction\", \"author\": \"Evelyn Waugh\", \"title\": \"Sword of Honour\", \"price\": 12.99 }, { \"category\": \"fiction\", \"author\": \"Herman Melville\", \"title\": \"Moby Dick\", \"isbn\": \"0-553-21311-3\", \"price\": 8.99 }, { \"category\": \"fiction\", \"author\": \"J. R. R. Tolkien\", \"title\": \"The Lord of the Rings\", \"isbn\": \"0-395-19395-8\", \"price\": 22.99 } ], \"bicycle\": { \"color\": \"red\", \"price\": 19.95 } }, \"expensive\": 10 }";

   public static void main(String[] args) {

      //Create the BDLJsonPath Object with the Sample String
      BDLJsonPath obj = new BDLJsonPath(cJsonSample); 

      //Test 1: Test the sample fetch a single result
      System.out.println("------Test #1----------");
      String resultString = obj.getResult("$.store.book[0].author");
      if (resultString == null) resultString = "NOT FOUND";
      System.out.println("Author found is " + resultString);
      
      //Test 2: Test the sample fetch a list of results
      System.out.println("------Test #2----------");
      String[] results = obj.getResultList("$.store.book[*].author");
      if (results != null) {
         for (String result : results) {
            System.out.println("Author found is " + result);
         }
      }

      //Test 3: Test the fetch of a JSON String
      System.out.println("------Test #3----------");
      resultString = obj.getResultJson("$.store");
      if (resultString == null) resultString = "NOT FOUND";
      System.out.println("Store JSON is " + resultString);

      //Test 4: Test the fetch of a JSON String
      System.out.println("------Test #4----------");
      resultString = obj.getResultJson("$.store.book[*]");
      if (resultString == null) resultString = "NOT FOUND";
      System.out.println("Books JSON is " + resultString);

      //Test 5: Test the fetch of a JSON String
      System.out.println("------Test #5----------");
      resultString = obj.getResultJson("$.store.bicycle");
      if (resultString == null) resultString = "NOT FOUND";
      System.out.println("bicycle JSON is " + resultString);

   }

} 

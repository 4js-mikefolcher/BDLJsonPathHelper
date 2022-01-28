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

   public Object getResultObject(String search) {
      
      if (this.ctx == null) {
         return null;
      }

      Object result = this.ctx.read(search);
      if (result == null) {
         return "";
      }
      return result;

   }  

   public String[] getResultList(String search) {

      Object result = this.getResultObject(search);
      if (result == null) {
         return null;
      }

      String[] results;

      try {
         List<String> matches = this.ctx.read(search);
         results = new String[matches.size()];
         results = matches.toArray(results);
      } catch (ClassCastException ex) {
         //suppress casting exception
         results = null;
      }

      return results;

   }

   public String getResult(String search) {

      Object result = this.getResultObject(search);
      if (result == null) {
         return null;
      }

      return String.valueOf(result);

   }

   public String getResultJson(String search) {

      Object obj = this.getResultObject(search);
      if (obj == null) {
         return null;
      }

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

      //Test 6: Test the fetch of a JSON String, all books less than 10.00
      System.out.println("------Test #6----------");
      resultString = obj.getResultJson("$.store.book[?(@.price < 10)]");
      if (resultString == null) resultString = "NOT FOUND";
      System.out.println("Books < 10 JSON is " + resultString);

      //Test 7: Test the fetch of a Number, count of all books
      System.out.println("------Test #7----------");
      Object result = obj.getResultObject("$.store.book.length()");
      if (result != null)
         System.out.println("Number of books is " + String.valueOf(result));

   }

} 

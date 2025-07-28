import 'dart:convert';

import 'package:api_using_flutter/todo_api/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class ApiServices{
   final url = "https://crud-backend-6t6r.onrender.com/api";


   Future<List<TodoModel>?> fetchTodos(BuildContext context)async{
     try{
        final response = await http.get(Uri.parse("$url/get"));

        if(response.statusCode == 200){
           List<dynamic> data = jsonDecode(response.body);

           // List<dynamic> needData = data["products"];
           print(response.body);

           return data.map((e)=> TodoModel.fromJson(e)).toList();
        }
        return null;
     }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong")));

     }


   }

   Future<TodoModel?>? addTodo(String title,String description)async{
      try{
         final response = await http.post(Uri.parse("$url/post"),
             headers: {
               "Content-Type": "application/json",
             },
             body: jsonEncode({
            "title": title,
            "description": description,
         }));

         if(response.statusCode == 200){
            final data = jsonDecode(response.body);
            print(response.body);

            return  TodoModel.fromJson(data);;
         }
         return null;
      }catch(e){

      }


   }

   Future<TodoModel?>? updateTodo(String title,String description,String id)async{
      try{
         final response = await http.put(Uri.parse("$url/update/$id"),
             headers: {
                "Content-Type": "application/json",
             },
             body: jsonEncode({
                "title": title,
                "description": description,
             }));

         if(response.statusCode == 200){
            final data = jsonDecode(response.body);
            print(response.body);

            return  TodoModel.fromJson(data);;
         }
         return null;
      }catch(e){

      }


   }

   Future<TodoModel?>? deleteTodo(String id)async{
      try{
         final response = await http.delete(Uri.parse("$url/delete/$id"),
            );

         if(response.statusCode == 200){
            final data = jsonDecode(response.body);
            print(response.body);

            return  TodoModel.fromJson(data);;
         }
         return null;
      }catch(e){

      }


   }


}
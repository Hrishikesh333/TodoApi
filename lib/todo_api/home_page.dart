import 'package:api_using_flutter/todo_api/api_services.dart';
import 'package:api_using_flutter/todo_api/todo_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  Stream<List<TodoModel>?> fetchTodos(BuildContext context) async* {
    while (true) {
      try {
        final todos = await ApiServices().fetchTodos(context);
        yield todos;
      } catch (e) {
        yield null; // or handle error more gracefully
      }
      await Future.delayed(Duration(seconds: 1)); // reasonable polling delay
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App"), centerTitle: true),
      body: StreamBuilder(
        stream: fetchTodos(context),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          final data = asyncSnapshot.data;
          if (data == null) {
            return Center(child: Text("No data found"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: IconButton(
                  onPressed: () {
                    ApiServices().deleteTodo(data[index].id.toString());
                  },
                  icon: Icon(Icons.delete),
                ),
                title: Text(data[index].title.toString()),
                subtitle: Text(data[index].description.toString()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AlertDialog(
            title: Text("Add Todo"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),
              TextButton(onPressed: (){
                if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                  ApiServices().addTodo(titleController.text, descriptionController.text);
                }
                Navigator.pop(context);
              }, child: Text("Add")),
            ],
          ),);
          debugPrint('FAB tapped!');
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/boxes.dart';

import 'models/todo.dart';

class AddTodoList extends StatefulWidget {
  AddTodoList({Key? key}) : super(key: key);

  @override
  _AddTodoListState createState() => _AddTodoListState();
}

class _AddTodoListState extends State<AddTodoList> {
  void _onFormSubmit() {
    Box<Todo> todoBox = Hive.box<Todo>(HiveBoxes.todo);
    todoBox.add(Todo(title: title, description: description));
    Navigator.of(context).pop();
    print(todoBox);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print("Form Validated");
    } else {
      print("Form not validated");
      return;
    }
  }

  late String title;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo'), centerTitle: true),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (value) {
                    title = value;
                  },
                  autofocus: false,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (value) {
                    description = value;
                  },
                  autofocus: false,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    validated();
                  },
                  child: Text('Add Todo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase 
{
   List todoList = [];

  // reference the box
  final _myBox = Hive.box('mybox');

  // default method for app
  void createInitialData()
  {
    todoList = [
    ["Kuliah", false],
    ["Latihan Badminton", false],
  ];
  }

  // load data dari database
  void loadData()
  {
    todoList = _myBox.get("TODOLIST");
  }
  //  update database
  void updateDatabase()
  {
    _myBox.put("TODOLIST", todoList);
  }

}
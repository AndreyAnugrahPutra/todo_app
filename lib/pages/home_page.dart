import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget 
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  // reference the hive box
  final _myBox = Hive.box('mybox');

  TodoDatabase db = TodoDatabase();

  @override
  void initState() {

    if(_myBox.get("TODOLIST") == null)
    {
      db.createInitialData();
    }
    else
    {
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }


  // text controller
  final _controller = TextEditingController();

  // Checkbox logic
  void checkBoxChanged(bool? value, int index)
  {
    setState(() 
    {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  // simpan kegiatan
  void saveNewTask()
  {
    setState(()
    {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }


  void createdNewTask()
  {
    showDialog(
      context: context, 
      builder: (context)
      {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
      );
  }

  // hapus Kegiatan
  void deleteTask(int index)
  {
    setState(() 
    {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('Todo List'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(onPressed: createdNewTask,
      child: Icon(Icons.add)),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index)
        {
          return todoTile(
            taskName: db.todoList[index][0], 
            taskCompleted: db.todoList[index][1], 
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        }
      )
    );
  }
}
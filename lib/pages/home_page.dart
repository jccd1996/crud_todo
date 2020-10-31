import 'package:crud_todo/models/todo.dart';
import 'package:crud_todo/pages/add_todo_page.dart';
import 'package:crud_todo/widgets/todo_item_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _listTodo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOs'),
      ),
      body: ListView.builder(
          itemCount: _listTodo.length,
          itemBuilder: (BuildContext context, int index) {
            return TodoItemWidget(
              todoItem: _listTodo[index],
              onDelete: () {
                _confirmDelete(index);
              },
              onEdit: () {
                _editTodo(index, _listTodo[index]);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToAddPage();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _goToAddPage() {
    Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => AddTodoPage()))
        .then((todoItem) {
      if (todoItem != null) {
        setState(() {
          _listTodo.add(todoItem);
        });
      }
    });
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Borrar TODO'),
        content: Text('¿Estas seguro de eliminar este TODO?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar')),
          TextButton(
            onPressed: () {
              _deleteTODO(index);
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _deleteTODO(int index) {
    setState(() {
      _listTodo.removeAt(index);
    });
    Navigator.pop(context);
  }

  void _editTodo(int index, Todo todo) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AddTodoPage(
                  todo: todo,
                ))).then((todoItem) {
      if (todoItem != null) {
        setState(() {
          _listTodo[index] = todoItem;
        });
      }
    });
  }
}

import 'package:crud_todo/models/todo.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  final Todo todo;

  AddTodoPage({this.todo});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();
  String _titleError;
  String _subtitleError;
  String _title = '';
  String _titleAppBar = '';
  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _title = 'Edita esta nota';
      _titleAppBar = 'Editar';
      _titleController.text = widget.todo.title;
      _subtitleController.text = widget.todo.subtitle;
    } else {
      _title = 'Agrega una nota nueva';
      _titleAppBar = 'Agregar';
    }
  }

  @override
  void dispose() {
    _titleController.clear();
    _subtitleController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _title,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Titulo',
                    errorText: _titleError,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _subtitleController,
                  decoration: InputDecoration(
                    labelText: 'Subtitulo',
                    errorText: _subtitleError,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    _validateFields();
                  },
                  child: Text(
                    'Guardar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validateFields() {
    var hasError = false;
    if (_titleController.text.trim().isEmpty) {
      hasError = true;
      setState(() {
        _titleError = 'El titulo no puede ser vacio';
      });
    }
    if (_titleController.text.trim().isEmpty) {
      hasError = true;
      setState(() {
        _subtitleError = 'El subtitulo no puede ser vacio';
      });
    }
    if (_titleController.text.trim().length < 2) {
      hasError = true;
      setState(() {
        _titleError = 'El titulo tiene que tener mas 2 letras';
      });
    }

    if (!hasError) {
      _saveTodo();
    }
  }

  void _saveTodo() {
    var todo = Todo(
      title: _titleController.text,
      subtitle: _subtitleController.text,
    );
    Navigator.of(context).pop(todo);
  }
}

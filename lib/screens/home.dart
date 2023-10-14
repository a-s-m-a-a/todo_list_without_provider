import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _toDoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          ontoDoChanged: _handelToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                        ),
                      ], // borderRadius: BorderRadius.circular(10),
                    ),
                        child: TextField(
                          controller: _toDoController,
                          decoration: InputDecoration(
                            hintText: " Add a new todo Item",
                            border: InputBorder.none,
                          ),),)),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _addToDoItem(_toDoController.text);
                      },
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _handelToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdGray,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: const Icon(
        Icons.menu,
        color: tdBlack,
      ),
      backgroundColor: tdBGColor,
      actions: const [
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.image,
            )),
      ],
    );
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
      _toDoController.clear();
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
}

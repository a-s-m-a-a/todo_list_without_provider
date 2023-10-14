class ToDo{
  String? id;
  String? todoText;
  bool isDone;
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone =false,
});

  static List<ToDo> todoList (){
    return[
      ToDo(id: '01', todoText: 'mornning exercises', isDone: true),
      ToDo(id: '02', todoText: 'go shopping', isDone: true),
      ToDo(id: '03', todoText: 'play games', ),
      ToDo(id: '04', todoText: 'check my email', ),
      ToDo(id: '05', todoText: 'helping others', ),

    ];
  }

}
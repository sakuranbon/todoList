import 'dart:html';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';

const List<ToDo> todos = [
  ToDo(id:0, description: 'task1', isCompleted: false),
  ToDo(id: 1, description: 'task2', isCompleted: false),
  ToDo(id: 2, description: 'task3', isCompleted: false),
];


class TodosNotifier extends StateNotifier<List<ToDo>>{
  TodosNotifier(): super(todos);

  void addTodo(ToDo todo) {
    state = [...state, todo];
  }

  void toggle(int id){
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copywith(isCompleted:  !todo.isCompleted)
        else
          todo,
    ];
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<ToDo>>((ref) {
  return TodosNotifier();
});

final completeTodosProvider = Provider<List<ToDo>>((ref) {

  final todos = ref.watch(todosProvider);
  return todos.where((todo) => todo.isCompleted).toList();

});

final unfinishedTodosProvider = Provider((ref)  {

  final todos = ref.watch(todosProvider);
  return todos.where((todo) => !todo.isCompleted).toList();

});
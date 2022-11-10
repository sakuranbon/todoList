
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';


const List<ToDo> todos = [
  ToDo(id: 0, description: 'task1', isCompleted: false),
  ToDo(id: 1, description: 'task2', isCompleted: false),
  ToDo(id: 2, description: 'task3', isCompleted: false),
  ToDo(id: 3, description: 'task4', isCompleted: false),
  ToDo(id: 4, description: 'task5', isCompleted: false),
];


class TodosNotifier extends StateNotifier<List<ToDo>> {
  TodosNotifier() : super(todos);


  void addTodo(ToDo newTodo) {
    List<ToDo> newState = [];
    for (final todo in state) {
      newState.add(todo);
    }
    newState.add(newTodo);
    state = newState;
  }

  void toggle(int id){
    List<ToDo> newState =[];
    for(final todo in state){
      if(todo.id == id){
        newState.add(todo.copywith(isCompleted: !todo.isCompleted));
      }else{
        newState.add(todo);
      }
    }
    state = newState;
  }

  void update(String description,int id) {
    List<ToDo> newState = [];
    for (final todo in state) {
      if (todo.id == id) {
        newState.add(todo.copywith(description: description));
      } else {
        newState.add(todo);
      }
    }
    state = newState;
  }

  void onReorder(oldIndex, newIndex) {
    List<ToDo> newState = [];
    for (final todo in state) {
      newState.add(todo);
    }
    if(oldIndex < newIndex){
      newIndex -=1;
    }
    final todo = newState.removeAt(oldIndex);
    newState.insert(newIndex, todo);

    state = newState;
  }

  void removeTodo(int id) {
    List<ToDo> newState = [];
    for (final todo in state) {
      if (id != todo.id) {
        newState.add(todo);
      }
    }
    state = newState;
  }
}

  final todosProvider = StateNotifierProvider<TodosNotifier, List<ToDo>>((ref) {
    return TodosNotifier();
  });

final completeTodosProvider = Provider<List<ToDo>>((ref) {

  final todos = ref.watch(todosProvider);

  return todos.where((todo) => todo.isCompleted).toList();
});

final unfinishedTodosProvider = Provider<List<ToDo>>((ref) {

  final todos = ref.watch(todosProvider);

  return todos.where((todo) => !todo.isCompleted).toList();
});


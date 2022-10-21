import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers.dart';
import 'models.dart';

void main(){
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget{
  const MyApp({Key? key}) : super(key:  key);

  @override
  Widget build(BuildContext context, WidgetRef ref){

    return MaterialApp(
      title: 'task',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  MyHomePage(),
    );
  }
}


class MyHomePage extends ConsumerWidget {
  const MyHomePage( {Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<ToDo> todos = ref.watch(todosProvider);
    final List<ToDo> completedTodos = ref.watch(completeTodosProvider);
    final List<ToDo> unfinishedTodos = ref.watch(unfinishedTodosProvider);


    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {}
          )
        ],
      ),
      body:
      Column(
          children: [
            ReorderableListView(
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                },
              header:TextButton(
                  onPressed: ()=>showDialog<String>(context: context, builder: (BuildContext context){
                    String description ='';
                    return AlertDialog(
                      title: Text('タスクを追加'),
                      content: TextField(
                        onChanged: (value){
                          description = value;
                        },
                      ),
                      actions: <Widget>[
                        TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'),
                            child: Text('Cancel'),
                        ),
                        TextButton(onPressed: (){
                          ref.read(todosProvider.notifier).addTodo(
                            ToDo(id: DateTime.now().millisecondsSinceEpoch, description: description, isCompleted: false)
                          );
                          Navigator.pop(context, 'OK');
                          },
                            child: Text('OK'),
                        ),
                      ],
                    );
                  }),
                child: Text('ko'),
            ),
              footer: TextButton(
                onPressed: ()=>showDialog<String>(context: context, builder: (BuildContext context){
                  String description ='';
                  return AlertDialog(
                    title: Text('タスクを追加'),
                    content: TextField(
                      onChanged: (value){
                        description = value;
                      },
                    ),
                    actions: <Widget>[
                      TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'),
                        child: Text('Cancel'),
                      ),
                      TextButton(onPressed: (){
                        ref.read(todosProvider.notifier).addTodo(
                            ToDo(id: DateTime.now().millisecondsSinceEpoch, description: description, isCompleted: false)
                        );
                        Navigator.pop(context, 'OK');
                      },
                        child: Text('OK'),
                      ),
                    ],
                  );
                }),
                child: Text('ko'),
              ),
              children: [
                for (int index = 0; index < todos.length; index++)
                  ListTile(
                    key: Key('$index'),
                    title: Text('${todos[index]}'),

                  ),
              ],
            ),
          ],
      ),
    );
  }
}
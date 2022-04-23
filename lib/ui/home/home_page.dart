import 'package:flutter/material.dart';
import 'package:TodoTasker/bloc/bloc_provider.dart';
import 'package:TodoTasker/ui/home/home_bloc.dart';
import 'package:TodoTasker/ui/home/side_drawer.dart';

import '../../data/db/label_db.dart';
import '../../data/db/project_db.dart';
import '../../data/db/task_db.dart';
import '../addtask/add_task.dart';
import '../addtask/add_task_bloc.dart';
import '../tasks/tasks_bloc.dart';
import '../tasks/tasks_page.dart';

class HomePage extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of(context);
    homeBloc.filter.listen((filter) {
      _taskBloc.updateFilters(filter);
    });
    return Scaffold(
      appBar: AppBar(
          title: StreamBuilder<String>(
              initialData: "Hoje",
              stream: homeBloc.title,
              builder: (context, snapshot) {
                return Text(snapshot.data);
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          var blocProviderAddTask = BlocProvider(
            bloc: AddTaskBloc(TaskDB.get(), ProjectDB.get(), LabelDB.get()),
            child: AddTaskScreen(),
          );
          Navigator.push(
              context,
              MaterialPageRoute<bool>(
                  builder: (context) => blocProviderAddTask));
        },
      ),
      drawer: SideDrawer(),
      body: BlocProvider(
        bloc: _taskBloc,
        child: TasksPage(),
      ),
    );
  }
}

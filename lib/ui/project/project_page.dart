import 'package:flutter/material.dart';
import 'package:TodoTasker/ui/project/project_bloc.dart';

import '../../bloc/bloc_provider.dart';
import '../../data/db/project_db.dart';
import '../../data/model/filter.dart';
import '../../data/model/project.dart';
import '../home/home_bloc.dart';
import 'add_project.dart';

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectBloc projectBloc = BlocProvider.of<ProjectBloc>(context);
    return StreamBuilder(
        stream: projectBloc.projects,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProjectExpansionTileWidget(snapshot.data);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class ProjectExpansionTileWidget extends StatelessWidget {
  final List<Project> _projects;

  ProjectExpansionTileWidget(this._projects);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: Icon(Icons.book),
        title: Text(
          "Projetos",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        children: buildProjects(context));
  }

  List<Widget> buildProjects(BuildContext context) {
    List<Widget> projectWidgetList = List();
    _projects.forEach((project) => projectWidgetList.add(ProjectRow(project)));
    projectWidgetList.add(ListTile(
      leading: Icon(Icons.add),
      title: Text("Add projeto"),
      onTap: () async {
        Navigator.pop(context);
        ProjectBloc projectBloc = BlocProvider.of<ProjectBloc>(context);
        Widget addProject = BlocProvider(
          bloc: ProjectBloc(ProjectDB.get()),
          child: AddProject(),
        );
        await Navigator.push(
            context,
            MaterialPageRoute<bool>(
              builder: (context) => addProject,
            ));
        projectBloc.refresh();
      },
    ));
    return projectWidgetList;
  }
}

class ProjectRow extends StatelessWidget {
  final Project project;

  ProjectRow(this.project);

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      title: Text(project.name),
      onTap: () {
        homeBloc.applyFilter(project.name, Filter.byProject(project.id));
        Navigator.pop(context);
      },
      leading: Container(
        width: 24.0,
        height: 24.0,
      ),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        child: CircleAvatar(
          backgroundColor: Color(project.colorValue),
        ),
      ),
    );
  }
}

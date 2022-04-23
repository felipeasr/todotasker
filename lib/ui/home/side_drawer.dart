import 'package:flutter/material.dart';

import '../../bloc/bloc_provider.dart';
import '../../data/db/label_db.dart';
import '../../data/db/project_db.dart';
import '../../data/model/filter.dart';
import '../../data/model/project.dart';
import '../../utils/app_constant.dart';
import '../about/about_us.dart';
import '../label/label_bloc.dart';
import '../label/label_page.dart';
import '../project/project_bloc.dart';
import '../project/project_page.dart';
import 'home_bloc.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
        child: ListView(
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        Text('\n'),
        Text('\n'),
        Text('\n'),
        ListTile(
            title: Text("Inbox"),
            leading: Icon(Icons.inbox),
            onTap: () {
              var project = Project.getInbox();
              homeBloc.applyFilter(project.name, Filter.byProject(project.id));
              Navigator.pop(context);
            }),
        ListTile(
            title: Text("Hoje"),
            leading: Icon(Icons.calendar_today),
            onTap: () {
              homeBloc.applyFilter("Hoje", Filter.byToday());
              Navigator.pop(context);
            }),
        ListTile(
            title: Text("Proximo 7 dias"),
            leading: Icon(Icons.calendar_today),
            onTap: () {
              homeBloc.applyFilter("Proximo 7 Dias", Filter.byNextWeek());
              Navigator.pop(context);
            }),
        BlocProvider(bloc: ProjectBloc(ProjectDB.get()), child: ProjectPage()),
        BlocProvider(bloc: LabelBloc(LabelDB.get()), child: LabelPage()),
        ListTile(
          title: Text("Sobre"),
          leading: Icon(Icons.info),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AboutUsPage()));
          },
        ),
      ],
    ));
  }
}

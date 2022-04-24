import 'package:flutter/material.dart';
import 'package:TodoTasker/ui/home/home_bloc.dart';

import 'bloc/bloc_provider.dart';
import 'ui/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: Colors.blue,
          primaryColor: Color.fromARGB(255, 0, 33, 55),
        ),
        home: BlocProvider(bloc: HomeBloc(), child: HomePage()));
  }
}

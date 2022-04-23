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
          accentColor: Colors.orange,
          primaryColor: const Color(0xFFDE4435),
        ),
        home: BlocProvider(bloc: HomeBloc(), child: HomePage()));
  }
}

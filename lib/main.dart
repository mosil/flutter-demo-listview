import 'package:flutter/material.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);
  final String _title = "Flutter ListView Demo";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: AppColors.primary())),
      home: MainApp(title: _title),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key, required this.title}) : super(key: key);

  final String title;

  List<String> _getMockData() {
    List<String> list = <String>[];
    for (var i = 1; i <= 100; i++) {
      list.add("My Item $i");
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                _getMockData()[index],
                style: const TextStyle(fontSize: 20.0),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 8.0,
              color: AppColors.primary().shade200,
            );
          },
          itemCount: _getMockData().length),
    );
  }
}

class AppColors {
  static final Color _primaryColor = Color(0xff0a3042);

  static MaterialColor primary() {
    return _getMaterialColor(_primaryColor);
  }

  static MaterialColor _getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}

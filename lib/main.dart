import 'package:flutter/material.dart';
import 'package:flutter_demo_list/my_Item_data.dart';

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

class MainApp extends StatefulWidget {
  const MainApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ScrollController _scrollController = ScrollController();
  final int _maxCount = 1000;

  final int _count = 10;

  int _currentPage = 1;

  final List<MyItemData> _items = [];

  List<MyItemData> _getMockData() {
    List<MyItemData> list = <MyItemData>[];
    for (var i = 1; i <= _count; i++) {
      list.add(MyItemData(
        index: _currentPage,
        value: "My Item $i",
      ));
    }
    return list;
  }

  bool _hasMore() {
    return _items.length < _maxCount;
  }

  Future<void> _fetch() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _items.addAll(_getMockData());
      _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : ListView.separated(
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (index < _items.length) {
                  MyItemData item = _items[index];
                  return ListTile(
                    title: Text(
                      item.value,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    subtitle: Text("Page ${item.index}"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _hasMore()
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(),
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 8.0,
                  color: AppColors.primary().shade200,
                );
              },
              itemCount: _items.length + 1,
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetch();
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.offset) {
          _fetch();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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

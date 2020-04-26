import 'package:barrage_flutter/barrage_flutter.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BarrageController controller = BarrageController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,() {
      debugPrint ("add");
      controller.pushBarrage (Barrage (
        Vector2 (0,0),
        Vector2 (10,0),
        Text ("测试一下")
      ));
      controller.pushBarrage (Barrage (
        Vector2 (1,20),
        Vector2 (15,0),
        Text ("测试2下",style: TextStyle (
          color: Colors.red
        ),)
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:Center(child:MaterialBarrageWidget(
            child: Icon (
              Icons.ac_unit,
              size: 200,
            ),
            controller: controller,
            )));
  }
}

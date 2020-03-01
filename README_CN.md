# barrage_flutter
一个flutter的弹幕引擎
目前还在初始版本，属于勉强能用的版本。
## 如何使用

使用 MaterialBarrageWidget 包裹你的组件，弹幕会在它的上方出现。
另外你需要为 MaterialBarrageWidget 指定一个 BarrageController,你将使用它进行添加弹幕操作。
具体例子
这个代码创建了两个弹幕，并且速度不一样。我们使用二维矢量来指定速度。
```
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
      controller.push_barrage (barrage (
        vector2 (0,0),
        vector2 (10,0),
        Text ("测试一下")
      ));
      controller.push_barrage (barrage (
        vector2 (1,20),
        vector2 (15,0),
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


```
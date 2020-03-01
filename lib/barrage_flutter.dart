library barrage_flutter;

import 'package:flutter/widgets.dart';

class vector2 <T extends num>{
  T x,y;
  vector2<T> operator * (T v) {
    vector2<T> tmp = this;
    tmp.x *= v;
    tmp.y *= v;
    return tmp;
  }
  vector2<T> operator + (vector2<T> v) {
    vector2<T> tmp = this;
    tmp.x += v.x;tmp.y += v.y;
    return tmp;
  }
}

class barrage extends StatefulWidget{ //弹幕对象
  vector2<double> pos;  //初始位置
  vector2<double> speed;
  vector2<double> npos;
  barrage (this.pos,this.speed) {
    this.npos = pos;
  }
  Widget child;
  @override
  State<StatefulWidget> createState() {
    return _barrageState ();
  }
}
const int INF =  10000000000000;
class _barrageState extends State<barrage>  with SingleTickerProviderStateMixin{
  AnimationController controller;
  _barrageState () {
    controller = new AnimationController(
    duration: const Duration(milliseconds: INF), vsync: this);
    controller.addListener(() {
      setState(() {
        widget.npos = widget.speed * (INF * controller.value) + widget.pos;
      }); 
    });
    controller.forward();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned (
      child: widget.child,
      top: widget.npos.y,
      left: widget.npos.x,
    );
  }
}
class BarrageController {
  dynamic push_barrage;
}
class MaterialBarrageWidget extends StatefulWidget {
  BarrageController _controller;
  List<barrage> barrages = List ();
  Widget child;
  MaterialBarrageWidget (this._controller,this.child); 
  @override
  State<StatefulWidget> createState() {
    return _MaterialBarrageWidgetState();
  }
}
class _MaterialBarrageWidgetState extends State<MaterialBarrageWidget>{
  _MaterialBarrageWidgetState () {
    widget._controller.push_barrage = (v) {
      setState(() {
        widget.barrages.add(v);
      });
    };
  }
  @override
  Widget build(BuildContext context) {
    return Stack (
      children: <Widget>[
        widget.child,
      ]..addAll(widget.barrages),
    );
  }
}
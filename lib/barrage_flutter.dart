library barrage_flutter;

import 'package:flutter/widgets.dart';

class Vector2<T extends num> {
  T x, y;
  Vector2(this.x, this.y);
  Vector2<T> operator *(T v) {
    Vector2<T> tmp = Vector2(this.x, this.y);
    tmp.x *= v;
    tmp.y *= v;
    return tmp;
  }

  Vector2<T> operator +(Vector2<T> v) {
    Vector2<T> tmp = Vector2(this.x, this.y);
    tmp.x += v.x;
    tmp.y += v.y;
    return tmp;
  }
}

class Barrage extends StatefulWidget {
  //弹幕对象
  final Vector2<double> pos, speed;
  Function remove;
  final Function onDelete;
  Barrage(this.pos, this.speed, this.child,
      {Duration duration,  this.onDelete}) {
    if (duration != null) {
      Future.delayed(duration, () {
        remove();
      });
    }
  }
  Widget child;
  @override
  State<StatefulWidget> createState() {
    return _BarrageState();
  }
}

const int INF = 1000;

class _BarrageState extends State<Barrage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Vector2<double> npos;
  GlobalKey key = GlobalKey();
  initState() {
    super.initState();
    npos = widget.pos;
    controller = new AnimationController(
        duration: const Duration(seconds: INF), vsync: this);
    controller.addListener(() {
      setState(() {
        npos = widget.speed * (INF * controller.value) + widget.pos;
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
    return Positioned(
      child: widget.child,
      top: npos.y,
      left: npos.x,
    );
  }
}

class BarrageController {
  dynamic pushBarrage;
  dynamic removeBarrage;
  dynamic barrages;
}

class MaterialBarrageWidget extends StatefulWidget {
  final BarrageController controller;
  final List<Barrage> barrages = List();
  final Widget child;
  MaterialBarrageWidget({this.controller, this.child}) {
    controller.barrages = barrages;
  }
  @override
  State<StatefulWidget> createState() {
    return _MaterialBarrageWidgetState();
  }
}

typedef bool FindBarrageFunction(Barrage barrage);

class _MaterialBarrageWidgetState extends State<MaterialBarrageWidget> {
  initState() {
    super.initState();
    widget.controller.pushBarrage = (Barrage v) {
      v.remove = () {
        setState(() {
          widget.barrages.remove(v);
        });
      };
      setState(() {
        widget.barrages.add(v);
      });
    };
    widget.controller.removeBarrage = (FindBarrageFunction f) {
      setState(() {
        List<Barrage> need = List();
        for (var i in widget.barrages) {
          if (f(i)) {
            need.add(i);
          }
        }
        for (var i in need) {
          widget.barrages.remove(i);
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
      ]..addAll(widget.barrages),
    );
  }
}

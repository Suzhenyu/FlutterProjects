import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //使用控制Tabbar切换
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.system_update), text: "组合"),
              Tab(icon: Icon(Icons.cake), text: "自绘")
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ListView(
              children: <Widget>[
                UpdatedItem(
                  model: UpdateItemModel(
                      appIcon: "assets/icon.png",
                      appDescription:
                          "Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.",
                      appName: "Google Maps - Transit & Fond",
                      appSize: "137.2",
                      appVersion: "Version 5.19",
                      appDate: "2019年6月5日"),
                  onPressed: () {},
                ),
                UpdatedItem(
                  model: UpdateItemModel(
                      appIcon: "assets/icon.png",
                      appDescription:
                          "Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.",
                      appName: "Google Maps - Transit & Fond",
                      appSize: "137.2",
                      appVersion: "Version 5.19",
                      appDate: "2019年6月5日"),
                  onPressed: () {},
                ),
              ],
            ),
            Center(
              child: Cake(),
            )
          ],
        ));
  }
}

class UpdatedItem extends StatelessWidget {
  final UpdateItemModel model;

  UpdatedItem({Key key, this.model, this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTopRow(context),
        buildBottomRow(context),
      ],
    );
  }

  Widget buildTopRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(model.appIcon, width: 80, height: 80)),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.appName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, color: Color(0xFF8E8D92)),
              ),
              Text(
                model.appDate,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: Color(0xFF8E8D92)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: FlatButton(
            color: Color(0xFFF1F0F7),
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            child: Text(
              "OPEN",
              style: TextStyle(
                  color: Color(0xFF007AFE), fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget buildBottomRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.appDescription),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text("${model.appVersion} • ${model.appSize} MB"),
          )
        ],
      ),
    );
  }
}

class UpdateItemModel {
  String appIcon;
  String appName;
  String appSize;
  String appDate;
  String appDescription;
  String appVersion;

  UpdateItemModel(
      {this.appIcon,
      this.appName,
      this.appSize,
      this.appDate,
      this.appDescription,
      this.appVersion});
}

class WheelPainter extends CustomPainter {
  WheelPainter({Key key, this.number});

  final double number;

  // 设置画笔颜色
  Paint getColoredPaint(Color color) {    // 根据颜色返回不同的画笔
    Paint paint = Paint();  //生成画笔
    paint.color = color;    //设置画笔颜色 
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {  // 绘制逻辑
    double wheelSize = min(size.width, size.height) / 2;  // 饼图的尺寸
    double radius = (2 * pi) / number;

    // 包裹饼图这个圆形的矩形框
    Rect boundingRect = Rect.fromCircle(center: Offset(wheelSize, wheelSize), radius: wheelSize);

    // 每次画 1/6 个圆弧
    for (var i = 0; i < number; i++) {
      canvas.drawArc(boundingRect, radius * i, radius, true, getColoredPaint(randomColor()));
    }
  }

  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(256)+0, Random().nextInt(256)+0, Random().nextInt(256)+0);
  }

  // 判断是否需要重绘，这里我们简单地坐下比较即可
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

// 将饼图包装成一个新的控件
class Cake extends StatelessWidget {
  Cake({Key key, this.number}) : super(key: key);
  final double number;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: WheelPainter(number: 20.0),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FahrasStoryScreen extends StatefulWidget {
  const FahrasStoryScreen({Key? key}) : super(key: key);

  @override
  _FahrasStoryScreenState createState() => _FahrasStoryScreenState();
}

class _FahrasStoryScreenState extends State<FahrasStoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.redAccent,
        title: Text(' فهرس القصص '),
        centerTitle: true,
      ),
    );
  }
}

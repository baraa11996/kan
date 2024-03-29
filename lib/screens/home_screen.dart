import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/fb_auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          backgroundColor: Colors.redAccent,
          title: Text('احكي لي يا أمي '),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/imageback.jpg',),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/fahras_screen');
                      },
                      child:  Container(
                        clipBehavior: Clip.hardEdge,
                        width: 115.w,
                        height: 115.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/bad.jpeg'),
                          ),
                          borderRadius: BorderRadius.circular(75),
                          border: Border.all(
                              color: Colors.green, width: 3.w),
                        ),
                        child: Text(
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/favorite_screen');
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 60,
                        child: Text(
                          'المفضلة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/person_screen');
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 60,
                        child: Text(
                          'معلومات  \nالطفل',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/who_screen');
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 60,
                        child: Text(
                          'من \nنحن',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/features_screen');
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 60,
                        child: Text(
                          'مميزات \nالتطبيق',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70.h,
                ),
              ],
            ),
          ),
        ));
  }
}

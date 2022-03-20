import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class WhoScreen extends StatelessWidget {
  const WhoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        toolbarHeight: 80.h,
        title: Text('من نحن'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/back.jfif'),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('رسالتنا..',style: TextStyle(color: Colors.green,fontSize: 20.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                ],
              ),
              SizedBox(height: 15.h,),
              Text('تجسيد رؤية جديدة للسَّرد القصصي باللغة العربية لأطفالنا الأعزاء في الوطن العربي و العالم، حيث نقدم محتوى جديد بجودة عالية و بشكل مبسط و غامر و ممتع\n'
                  '\nمن خلال تطبيق أحكي لي يا أمي نتطلع لتقوية أواصر المحبة و الألفة بين أطفالنا الأحبة و ذويهم عن طريق السرد القصصي\n'
                  '\nننظر للتكنولوجيا كأداة تعليمية فعَّالة لتمكين أطفالنا بشكل متوازن ومدروس\n'
                  ,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
              SizedBox(height: 10.h,),
              Center(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/ecd619e7-9c20-4cd5-ac9d-babcc3c472b3.jfif'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(
                        color: Colors.green, width: 3.w),
                  ),
                  // child: Image(
                  //   image:
                  //   fit: BoxFit.contain,
                  // ),
                ),
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('نسعد بمتابعتكم وتواصلكم معنا',style: TextStyle(color: Colors.green,fontSize: 20.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.grey,
                    child: InkWell(
                      onTap: facebook,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('images/facebook.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.grey,
                    child: InkWell(
                      onTap: whatsapp,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          'images/whatsapp.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('جميع الحقوق محفوظة 2022',style: TextStyle(color: Colors.grey,fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  whatsapp()async{
    const url = "whatsapp://send?phone=+970597017332";
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  facebook()async{
    const url = "https://www.facebook.com/alaa.samara.3538";
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
}

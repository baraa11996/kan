import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.redAccent,
        title: Text('مميزات التطبيق'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/back.jfif'),
        )),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('المميزات الشيقة للتطبيق',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.multitrack_audio,color: Colors.redAccent,),
                  ),
                  SizedBox(width: 10.w,),
                  Text('اقرأ لي ..',style: TextStyle(fontSize: 18.sp),),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text('يقدم تطبيق أحكي لي يا أمي ميزة قراءة القصص للطفل باللغة العربية الفصحى وبصوت واضح وممتع في حال تعذر السرد من قبل ذوي الطفل.'),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.article,color: Colors.redAccent,),
                  ),
                  SizedBox(width: 10.w,),
                  Text('تصميم بسيط ومثالي ..',style: TextStyle(fontSize: 18.sp),),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text('أحكي لي يا أمي صُمم لوصول سهل و فعَّال لمحتوى مميز للأطفال، بشكل متوازن من غير إستخدام مفرط للرسوم و الرسوم المتحركة و الموسيقى.'),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.favorite,color: Colors.redAccent,),
                  ),
                  SizedBox(width: 10.w,),
                  Text('المفضلة ..',style: TextStyle(fontSize: 18.sp),),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text('يوفر ميزة أضافة القصص لقائمة المفضلة والتي تتيح وصول سهل وسريع للقصص.'),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.safety_divider,color: Colors.redAccent,),
                  ),
                  SizedBox(width: 10.w,),
                  Text('الخصوصية والأمان ..',style: TextStyle(fontSize: 18.sp),),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Text('تطبيق يمتلك حماية قوية لقواعد البيانات الخاصة به ويشترط عند تسجيل بيانات الطفل التسجيل بحساب حقيقي حيث يقوم التطبيق بارسال كود تفعيل للايميل المسجل به .'),
            ],
          ),
        ),
      ),
    );
  }
}

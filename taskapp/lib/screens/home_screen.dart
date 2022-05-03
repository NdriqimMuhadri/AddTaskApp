import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taskapp/routes/routes.dart';
import 'package:taskapp/screens/add_task.dart';
import 'package:taskapp/widgets/button_widget.dart';
import '../colors/app_colors.dart';
import 'all_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 20,right: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/welcome.jpg"
            ),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: 'Hello',
                style: TextStyle(color: AppColors.mainColor,
                fontSize: 60, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                  text: '\nstart your beautiful day',
                  style: TextStyle(color: AppColors.smallTextColor,
                      fontSize: 14))
                ]
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/3,),
            InkWell(
                onTap: (){
                  Get.toNamed(RoutesClass.getAddTaskRoute());
                },
                child: ButtonWidget(backgroundColor: AppColors.mainColor,
                    text: "Add Task",
                    textColor: Colors.white),
              ),

            const SizedBox(height: 20),
            InkWell(
                onTap: (){
                  Get.toNamed(RoutesClass.getAllTaskRoute());
                },
              child: ButtonWidget(backgroundColor: Colors.white,
                  text: "View All",
                  textColor: AppColors.smallTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

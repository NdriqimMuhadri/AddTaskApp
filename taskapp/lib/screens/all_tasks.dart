import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taskapp/controllers/data_controller.dart';
import 'package:taskapp/screens/view_task.dart';
import 'package:taskapp/widgets/button_widget.dart';
import 'package:taskapp/widgets/task_widget.dart';
import '../colors/app_colors.dart';
import '../routes/routes.dart';
import 'edit_task.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  _loadData() async{
    await Get.find<DataController>().getData();
  }
  @override
  Widget build(BuildContext context) {
    _loadData();

    final leftEditIcon = Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF2e3253).withOpacity(0.5),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );

    final rightDeleteIcon = Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.redAccent.withOpacity(0.5),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<DataController>(
        builder: (controller) {
          return controller.isLoading==false? Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height/3.2,
                padding: const EdgeInsets.only(left: 20, top: 60),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/header1.jpg"
                        ),
                        fit: BoxFit.fill
                    )
                ),
                child: IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back),
                    color: AppColors.secondaryColor),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  children: [
                    Icon(Icons.home,color: AppColors.secondaryColor,),
                    const SizedBox(width: 10),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.5),
                        color: Colors.black
                      ),
                      child: const Icon(Icons.add, color: Colors.white,),
                    ),
                    // Expanded(child: Container()),
                    const Spacer(),
                    Icon(Icons.calendar_month_sharp,color: AppColors.secondaryColor,),
                    const SizedBox(width: 10),
                    Text('2',style: TextStyle(fontSize: 20,
                        color: AppColors.secondaryColor),)
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                      itemCount: controller.myData.length,
                        itemBuilder: (context, index){
                          return Dismissible(
                            background: leftEditIcon,
                            secondaryBackground: rightDeleteIcon,
                            key: ObjectKey(index),
                            onDismissed: (DismissDirection direction){

                            },
                            confirmDismiss: (DismissDirection direction) async {
                              if(direction==DismissDirection.startToEnd){
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (_){
                                      return Container(
                                        height: 500,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)
                                          ),
                                          color: const Color(0xFF2e3253).withOpacity(0.4)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: ButtonWidget(
                                                    backgroundColor: AppColors.mainColor,
                                                    text: 'View',
                                                    textColor: Colors.white),
                                                onTap: (){
                                                  Get.toNamed(RoutesClass.getViewTaskRoute(int.parse(controller.myData[index]["id"].toString())));
                                                },
                                              ),
                                              const SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: (){
                                                  // Get.off(()=>EditTask(id: int.parse(controller.myData[index]["id"].toString())));
                                                  Get.toNamed(RoutesClass.getEditTaskRoute(int.parse(controller.myData[index]["id"].toString())));
                                                },
                                                child: ButtonWidget(
                                                    backgroundColor: AppColors.mainColor,
                                                    text: 'Edit',
                                                    textColor: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                return false;
                              } else {
                                controller.deleteData(int.parse(controller.singleData["id"]));
                                return Future.delayed(const Duration(seconds: 1),
                                        () async{
                                         await controller.getData();
                                         return direction==DismissDirection.endToStart;
                                        });
                              }
                            },

                            child: Container(
                              margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                              child: TaskWidget(text: controller.myData[index]["task_name"],
                                  color: Colors.blueGrey),
                            ),
                          );
                        })
              )
            ],
          ):SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: SpinKitThreeInOut(
              itemBuilder: (BuildContext context,int index){
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index.isEven ? Colors.red : Colors.green
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}

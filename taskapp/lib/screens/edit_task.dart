import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/colors/app_colors.dart';
import 'package:taskapp/controllers/data_controller.dart';
import 'package:taskapp/screens/all_tasks.dart';
import 'package:taskapp/widgets/button_widget.dart';
import 'package:taskapp/widgets/textfiled_widget.dart';

import '../routes/routes.dart';
import '../widgets/error_warning_mes.dart';

class EditTask extends StatelessWidget {
  final int id;
  EditTask({Key? key, required this.id}) : super(key: key);

  _loadSingleTask()async{
    await Get.find<DataController>().getSingleData(id.toString());
  }
  bool _dataValidation(){
    if(nameController.text.trim()==''){
      Message.taskErrorOrWarning('Task name', 'Your task name is empty');
      return false;
    } else if(detailController.text.trim()==''){
      Message.taskErrorOrWarning('Task detail', 'Your detail name is empty');
      return false;
    } else if(nameController.text.length<=10){
      Message.taskErrorOrWarning('Task detail', 'Your task name should be at least 10 characters');
      return false;
    }else if(detailController.text.length<=20){
      Message.taskErrorOrWarning('Task detail', 'Your task detail should be at least 20 characters');
      return false;
    }
    return true;
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _loadSingleTask();
    return Scaffold(
      body: GetBuilder<DataController>(
        builder: (controller) {
          nameController.text = controller.singleData["task_name"]??"Task name not found";
          detailController.text = controller.singleData["task_detail"]??"Detail name not found";
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.only(left: 20,right: 20),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/addtask1.jpg"
                    ),
                    fit: BoxFit.fill
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 60),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: (){
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: AppColors.secondaryColor)
                  ],
                ),
                Column(
                  children: [
                    TextFieldWidget(textController: nameController,
                        hintText: "Task name"),
                    const SizedBox(height: 20,),
                    TextFieldWidget(textController: detailController,
                        hintText: "Task name", borderRadius: 15,
                        maxLines: 3),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                        if(_dataValidation()){
                          Get.find<DataController>().putData(
                              controller.singleData["id"],
                              nameController.text.trim(),
                              detailController.text.trim());
                          Get.offNamed(RoutesClass.getAllTaskRoute());
                        };},
                      child: ButtonWidget(
                          backgroundColor: AppColors.mainColor,
                          text: 'Add', textColor: Colors.white),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/6,)
              ],
            ),
          );
        }
      ),
    );
  }
}

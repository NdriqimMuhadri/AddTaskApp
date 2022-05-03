import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';
import '../controllers/data_controller.dart';
import '../widgets/textfiled_widget.dart';

class ViewTask extends StatelessWidget {
  final int id;
  ViewTask({Key? key, required this.id}) : super(key: key);

  _loadSingleTask()async{
    print("passed id is:"+id.toString());
    await Get.find<DataController>().getSingleData(id.toString());
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _loadSingleTask();
    return Scaffold(
      body: GetBuilder<DataController>(
        builder: (controller){
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
                        hintText: controller.singleData["task_name"]??"Task name not found",
                      readOnly: true,
                    ),
                    const SizedBox(height: 20,),
                    TextFieldWidget(textController: detailController,
                        hintText: '${controller.singleData["task_detail"]??"Task detail not found"}', borderRadius: 15,
                        maxLines: 3,readOnly: true),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/6,)
              ],
            ),
          );
        },
      ),
    );
  }
}

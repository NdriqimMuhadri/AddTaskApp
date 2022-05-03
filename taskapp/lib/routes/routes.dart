import 'package:get/get.dart';
import 'package:taskapp/screens/add_task.dart';
import 'package:taskapp/screens/all_tasks.dart';
import 'package:taskapp/screens/home_screen.dart';
import '../screens/edit_task.dart';
import '../screens/view_task.dart';

class RoutesClass {
  static String home="/";
  static String allTask="/allTask";
  static String addTask="/addTask";
  static String editTask="/editTask";
  static String viewTask="/viewTask";

  static String getHomeRoute()=>home;
  static String getAllTaskRoute()=>allTask;
  static String getAddTaskRoute()=>addTask;
  static String getEditTaskRoute(int id)=>'$editTask?id=$id';
  static String getViewTaskRoute(int id)=>'$viewTask?id=$id';

  static List<GetPage> routes = [
    GetPage(name: home, page: ()=>const HomeScreen()),
    GetPage(name: allTask, page: ()=>const AllTasks(),transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(name: addTask, page: ()=>const AddTask(),transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: editTask, page: (){
      var id = Get.parameters['id'];
      return EditTask(id: int.parse(id!));
    },transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: viewTask, page: (){
      var id = Get.parameters['id'];
      return ViewTask(id: int.parse(id!));
    },transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
  ];
}
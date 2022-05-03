import 'dart:convert';
import 'package:get/get.dart';
import 'package:taskapp/services/service.dart';

class DataController extends GetxController{
  DataService service = DataService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<dynamic> _myData = [];
  List<dynamic> get myData => _myData;
  Map<String,dynamic> _singleData={};
  Map<String,dynamic> get singleData => _singleData;


  Future<void> getData()async{
    _isLoading = true;
    Response response = await service.getData();
    if(response.statusCode == 200){
      _myData =response.body;
      print("We got the data"+jsonEncode(response.body));

    } else {
      print("We did not get the data");
      print(response.statusCode.toString());
    }
    _isLoading = false;
    update();
  }

  Future<void> getSingleData(String id)async{
    _isLoading = true;
    Response response = await service.getSingleData(id);
    if(response.statusCode == 200){
      print("We got the Single data: "+jsonEncode(response.body));
      var jsonToConvert = jsonEncode(response.body);
      var after = jsonToConvert.replaceAll(r'\', '');
      var after1 = after.replaceFirst(RegExp(r'"'), '');
      var after2 = after1.substring(0,after1.length-2);
      print("We got the Single data: "+after2);
      _singleData = json.decode(after2);
      update();
    } else {
      print("We did not get the Single data");
      print(response.statusCode.toString());
    }
    _isLoading = false;
    update();
  }

  Future<void> postData(String task, String taskDetail)async{
    _isLoading = true;
    Response response = await service.postData({
      "task_name":task,
      "task_detail":taskDetail
    });
    if(response.statusCode == 200){
      print("Data post successful");
      print("We got the Single data: "+jsonEncode(response.body));
    } else {
      print("Data post failed");
    }
    update();
  }

  Future<void> putData(String id,String task, String taskDetail)async{
    _isLoading = true;
    Response response = await service.putData(id,{
      "task_name":task,
      "task_detail":taskDetail
    });
    if(response.statusCode == 200){
      print("Data post successful");
      print("We got the Single data: "+jsonEncode(response.body));
    } else {
      print("Data post failed");
    }
    update();
  }

  Future<void> deleteData(int id)async{
    _isLoading = true;
    update();
    Response response = await service.deleteData(id);
    if(response.statusCode == 200){
      print("Data post successful");
      print("We got the Single data: "+jsonEncode(response.body));
    } else {
      print("Data post failed");
    }
    await Future.delayed(const Duration(seconds: 1),
        (){
          _isLoading = false;
          update();
        });
  }
}
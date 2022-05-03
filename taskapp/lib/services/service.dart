import 'package:get/get.dart';
import 'package:taskapp/utils/app_constants.dart';

class DataService extends GetConnect implements GetxService{

  Future<Response> getData() async{
    Response response = await get(
        AppConstants.BASE_URL+AppConstants.GET_TASKS,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      }
    );
    return response;
  }

  Future<Response> getSingleData(String id) async{
    Response response = await get(
        AppConstants.BASE_URL+AppConstants.GET_TASK+"/"+id,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        }
    );
    return response;
  }

  Future<Response> postData(dynamic body) async{
    Response response = await post(
        AppConstants.BASE_URL+AppConstants.POST_TASK,
        body,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        }
    );
    return response;
  }

  Future<Response> putData(String id,dynamic body) async{
    Response response = await put(
        AppConstants.BASE_URL+AppConstants.PUT_TASK+"/?id="+id,
        body,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        }
    );
    return response;
  }

  Future<Response> deleteData(int id) async{
    Response response = await delete(
        AppConstants.BASE_URL+AppConstants.DELETE_TASK+"/?id="+"$id",
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        }
    );
    return response;
  }

}
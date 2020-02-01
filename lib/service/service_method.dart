import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/httpHeaders.dart';
import '../config/service_url.dart';

Future getHomePageContent() async{
  try{
print('开始获取数据');
  Response response;
  Dio dio = new Dio();
  //这里是设置请求头，这个搞不成我换成下面的好了
  // dio.options.contentType = ContentType.parse("application/json");
  dio.options.headers = httpHeaderss1;
  var formData = {
    'status': '1'
  };
  response = await dio.post(servicePath['homePageContent'],data:formData);
  if(response.statusCode == 200){
    print(response);
    return response;
  }else{
    throw Exception('后端接口出现异常');
  }
  }catch(e){return print('error:-$e');}
  }
  // 这个是测试方法测试了一下1
 Future getHomePageContent1() async{
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaderss1;
      var url = servicePath['homePageContent1'];
      // var data = {};
      response = await dio.get(url);
      // print(response);
      return response;
    }catch(e){
      return print(e);
    }
  }
  // 这个是测试方法测试了一下2
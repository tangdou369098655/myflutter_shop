import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/httpHeaders.dart';
import '../config/service_url.dart';



// 封装方法1
Future requestPost(urlstr, formdata) async{
  try{
print('开始获取数据');
  Response response;
  Dio dio = new Dio();
  //这里是设置请求头，这个搞不成我换成下面的好了
  dio.options.headers = httpHeaderss1;
  if(formdata == null){
  response = await dio.post(servicePath[urlstr]);
  }else{
  response = await dio.post(servicePath[urlstr],data:formdata);
  }
  if(response.statusCode == 200){
    print(response);
    return response;
  }else{
    throw Exception('后端接口出现异常');
  }
  }catch(e){return print('error:-$e');}
  }
// 封装方法2
// 封装方法1
// requestget('homePageBelowCoten',{'insale':'1'})
 Future requestget(urlstr,formdata) async{
    try{
      print('开始获取火爆专区数据');
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaderss1;
      var url = servicePath[urlstr];
      response = await dio.get(url,queryParameters:formdata);
      // print(response);
      return response;
    }catch(e){
      return print(e);
    }
  }
// 封装方法2
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

// 获得火爆专区商品方法
  Future getHomePageBeloConten() async{
    try{
      print('开始获取火爆专区数据');
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaderss1;
      var url = servicePath['homePageBelowCoten'];
      var formData = {'insale':'1'};
      response = await dio.get(url,queryParameters:formData);
      // print(response);
      return response;
    }catch(e){
      return print(e);
    }
  }
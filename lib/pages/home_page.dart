import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      body:Center(
        child: Text('商城首页')
      )
    );
  }
  void getHttp()async{
    try{
      Response response;
      response = await Dio().get(
        "http://192.168.1.107:3000/api/index?status=1",
        //  queryParameters:data
      );
      return print(response);
    }catch(e){
      return print(e);
    }
  }
}
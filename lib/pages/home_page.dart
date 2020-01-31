//第四次案例
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent ='正在获取数据';
  @override
  void initState() {
    getHomePageContent().then((val){
      setState((){
        homePageContent = val.toString();
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hhaha'),),
      body:SingleChildScrollView(child: Text(homePageContent),)
    );
  }
}
//首页轮播组件1
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  SwiperDiy({Key key,this.swiperDateList}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return Image.network('${swiperDateList[index]['image']}');
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
//首页轮播组件2


















// // 第三次案例 模拟请求头发送请求
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../config/httpHeaders.dart';
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String showText = '还没有数据过来';
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         appBar: AppBar(title: Text('请求远程数据')),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               RaisedButton(
//                 onPressed: _mypost,
//                 child: Text('请求数据')
//                 ),
//                 Text(showText)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _mypost(){
//     print('开始向');
//     getHttp().then((val){
//       setState(() {
//         showText = val.toString();
//       });
//     });
//   }
//   Future getHttp() async{
//     try{
//       Response response;
//       Dio dio = new Dio();
//       dio.options.headers = httpHeaderss;
//       var url = 'https://time.geekbang.org/serv/v1/column/topList';
//       // var data = {};
//       response = await dio.post(url);
//       print(response);
//       return response;
//     }catch(e){
//       return print(e);
//     }
//   }
// }















// // 第二次案例--动态组件 stful--
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController typeController = TextEditingController();
//   String showText = '欢迎您来~';
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         appBar: AppBar(title: Text('啦啦啦啦')),
//         body: SingleChildScrollView(
//           child:Container(
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 controller: typeController,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10.0),
//                   labelText: '其他类型',
//                   helperText: '请输入你喜欢的类型'
//                 ),
//                 autofocus: false,
//               ),
//               RaisedButton(
//                 // onPressed: (){_choiceAction();},
//                 onPressed:_choiceAction,
//                 child: Text('选择啦'),
//               ),
//               Text(
//                 showText,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ],
//           ),
//         ),
//         ),
        
//       ),
//     );
//   }

//   // 这里是发请求代码
//   void _choiceAction(){
//     print('开始啦哦。。。。');
//     if(typeController.text == ''){
//       showDialog(
//         context: context,
//         builder: (context)=>AlertDialog(title: Text('不能为空哦。。。')
//         )
//         );
//     }else{
//       getHttp(typeController.text.length).then((val){
//         print(val);
//         print('shuju');
//         setState((){
//           showText = val.toString();
//         });
//       });
//     }
//   }
//   Future getHttp(int TypeText) async{
//     try{
//       Response response;
//       var data = {'status': TypeText};
//       var url = 'http://192.168.1.107:3000/api/index';
//       response = await Dio().get(url,queryParameters:data);
//       return response;
//     }catch(e){

//     }
//   }
// }















// 第一次案例
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     getHttp();
//     return Scaffold(
//       body:Center(
//         child: Text('商城首页')
//       )
//     );
//   }
//   void getHttp()async{
//     try{
//       Response response;
//       response = await Dio().get(
//         "http://192.168.1.107:3000/api/index?status=1",
//         //  queryParameters:data
//       );
//       return print(response);
//     }catch(e){
//       return print(e);
//     }
//   }
// }
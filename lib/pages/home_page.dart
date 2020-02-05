//第四次案例
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import '../config/service_url.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
// 页面返回保持原有浏览状态AutomaticKeepAliveClientMixin
// 需要满足4个条件：
// 0.with AutomaticKeepAliveClientMixin 
// 1.必须重写 @override  bool get wantKeepAlive => true;
// 2.必须是StatefulWidget
// 3.改造index_page
// 4.测试一下啊
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String homePageContent = '正在获取数据';
  @override
  void initState() {
    // getHomePageContent1().then((val) {
    //   setState(() {
    //     homePageContent = val.toString();
    //   });
    // });
    super.initState();
  // 测试开始1
    print('111111111');
  // 测试开始2
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('hhaha'),
        ),
        // 测试发送POST请求代码1
        // body:SingleChildScrollView(child: Text(homePageContent),)
        // 测试发送POST请求代码2
        // FutureBuilders是第二种解决发送请求异步的方法，可以按规则是使用
        body: FutureBuilder(
          future: getHomePageContent1(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
             // 下面开始部署轮播图数据1
              List<String> list = List();//这个用于放轮播图数据
              // // 需要用JSON之前先import 'dart:convert';
              var data = json.decode(snapshot.data.toString());
              // data就是获取的源数据
              // 这个是获取轮播图数组的第1个办法1
              // data.forEach((k, v) {
              //   v.forEach((element) {
              //     list.add(""+(imgUrl + element["img"]));
              //   });
              // });
              // print('22');
              // print(list[1]);
              // 这个是获取轮播图数组的第1个办法2

              // 这个是获取轮播图数组的第2个办法1
              // // 需要用JSON之前先import 'dart:convert';
              print(data);
              var arr = data["carouselItems"].toList();
              // print('456111');
              // print(arr);
              var arr1 = arr.map((item) {
                // 问题1：用这个就没问题
                list.add(""+(imgUrl + item["img"]));
                return item = imgUrl + (item['img']);
              });
              // print('4562222');
              // print(arr);/
              // print('456333');
                // 问题1：用这个就有问题
              // list = arr1.toList();
              print(arr1.toList());
              // 问题2:下面这句话看不懂搞不懂 Map 是什么
              // List<Map> swiper = (data['carouselItems']['img'] as List).cast();
              // 这个是获取轮播图数组的第2个办法2
              // 下面开始部署轮播图数据2
              // 下面开始部署类别导航数据了哦1
              List<Map> navigatorList = (data['kinds'] as List).cast();
              // print('打印列表');
              // print(navigatorList);
              // 下面开始部署类别导航数据了哦2
              // 部署Banner1  
              // String adPicture = imgUrl + data['kinds'][0]['Mimg'];
              String adPicture = imgUrl + 'images/index/sbanner4.jpg';
              // 部署Banner1
              // 部署拨打电话图片1
              String leaderImage = imgUrl + data['kinds'][6]['Mimg'];
              String leaderPhone = '18625578825';
              // 部署拨打电话图片2
              // 部署商品推荐部门信息1
              List<Map> recommendList = (data['product'] as List).cast();
              // 部署商品推荐部门信息2
              // 楼层组件1
              // String floorTitle = imgUrl + data['kinds'][1]['Mimg'];
              String floorTitle = imgUrl + 'images/index/sbanner1.jpg';
              List<Map> floorGoodList = (data['kinds'] as List).cast();
              print('哈哈哈');
              print(floorGoodList);
              // 楼层组件2
              return SingleChildScrollView(
                child: Column(
                children: <Widget>[
                  SwiperDiy( swiperDateList: list,),
                  TopNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture: adPicture,),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone,),
                  Recommend(recommendList: recommendList,),
                  FloorTitle(picture_address: floorTitle,),
                  FloorContent(floorGoodList: floorGoodList,)
                ],
              ),
              );
            } else {
              return SingleChildScrollView(
                child: Center(
                child: Text('加载中啊。。。。',style:TextStyle(fontSize:ScreenUtil().setSp(28))),
              ),
              );
            }
          },
        ));
  }
}

//首页轮播组件1
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  SwiperDiy({Key key, this.swiperDateList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 这个放到这里其他地方就没法用了要放到项目第一个页面
    // ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    // print('设备像素密度：${ScreenUtil.pixelRatio}');
    // print('设备的高度：${ScreenUtil.screenHeight}');
    // print('设备的宽度：${ScreenUtil.screenWidth}');
    return Container(
      height: ScreenUtil().setHeight(750),
      // width: ScreenUtil().setWidth(750),
      child: Swiper(
         itemBuilder: (BuildContext context,int index){
          //  print(index);
          return new Image.network(swiperDateList[index],fit: BoxFit.fill,);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
//首页轮播组件2

// 类别导航组件1
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  const TopNavigator({Key key, this.navigatorList}) : super(key: key);
// 内部方法
Widget _gridViewItemUI(BuildContext context,item){
  return InkWell(
    onTap:(){print('点击啦' + item['kind_name']);},
    child: Column(children: <Widget>[
      Image.network(imgUrl + item['img'],width:ScreenUtil().setWidth(95)),
      Text(item['kind_name'],style: TextStyle(color: Colors.pink))
    ],),
  );
}
// 内部方法
  @override
  Widget build(BuildContext context) {
    if(this.navigatorList.length>10){
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(350),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((_){
          return _gridViewItemUI(context, _);
        }).toList(),
      ),
    );
  }
}
// 类别导航组件2
// Banner组件1
class AdBanner extends StatelessWidget {
  final String adPicture;
  const AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}
// Banner组件2

// 拨打电话模块1
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Container(
          width: ScreenUtil().setWidth(750),
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child:Image.network(leaderImage,width:ScreenUtil().setWidth(750),fit:BoxFit.fitWidth),
        ),
      ),
    );
  }
  void _launchURL() async{
    String url = 'tel:' + leaderPhone;//拨打电话用
    // String url = 'https://www.baidu.com';//访问网址用
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw '不可以访问拨打电话URL,异常咯~~~';
    }
  }
}
// 拨打电话模块2
// 商品推荐模块1
class Recommend extends StatelessWidget {
  final List recommendList;
  const Recommend({Key key,this.recommendList}) : super(key: key);
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
          bottom:BorderSide(width:0.5,color:Colors.black12)
        ),
      ),
      child: Text(
        'VIP推荐',
        style:TextStyle(color: Colors.pink)
      ),
    );
  }

  // 商品的单独方法1
  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(380),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
             left: BorderSide(
            width:0.5,
            color: Colors.black12
          ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(imgUrl + recommendList[index]['index_img'],height: ScreenUtil().setHeight(140),),
            Text('${recommendList[index]['index_title']}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,),
            Text('￥199.00'),
            Text(
              '￥${recommendList[index]['index_price']}',
              style: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        ),
    );
  }
  // 商品的单独方法2
  // 横向列表方法1
  Widget _recommendList(){
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _item(index);
        }
      ),
    );
  }
  // 横向列表方法2

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top:10.0),
      child:Column(
      children: <Widget>[
        _titleWidget(),
        _recommendList()
      ],
      ),
    );
  }
}
// 商品推荐模块2
// 楼层标题1
class FloorTitle extends StatelessWidget {
  final String picture_address;
  const FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8.0),
      padding: EdgeInsets.only(bottom:10.0),
      child: Image.network(picture_address),
    );
  }
}
// 楼层标题2
// 楼层商品1
class FloorContent extends StatelessWidget {
  final List floorGoodList;
  const FloorContent({Key key, this.floorGoodList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        _firstRow(),
        _otherGoods()
      ],),
    );
  }
  // 私有方法
  // 左边一个右边俩图片的布局
  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodList[1]),
            _goodsItem(floorGoodList[2]),
          ],
        ),
      ],
    );
  }
  Widget _otherGoods(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodList[3]),
        _goodsItem(floorGoodList[4]),
      ],
    );
  }
  Widget _goodsItem(Map goods){
    print(imgUrl + goods['Bimg'].toString().substring(goods['Bimg'].toString().length-3) + 'jpg');
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){print('点击了楼层商品');},
        child: Image.network(imgUrl + goods['Bimg'].toString().substring(0,goods['Bimg'].toString().length-3) + 'jpg'),
      ),
    );
  }
  // 私有方法
}
// 楼层商品2








































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

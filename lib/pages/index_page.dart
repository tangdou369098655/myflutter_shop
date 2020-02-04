import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //另一种风格 iOS 的风格
// 引入四个页面
import './cart_page.dart';
import './category_page.dart';
import './home_page.dart';
import './member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//输入stful
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
      ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
      ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
      ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心')
      ),
  ];
  // 切换页面代码1
  // 建立了一个列表放的是页面变量1-1
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex = 1;
  var currentPage;
  // 下面的输入initstate就能都出来了1
  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }
  // 上面的输入initstate就能都出来了2

  // 切换页面代码2

  @override
  Widget build(BuildContext context) {
    // 这个要放在初始化第一次使用的页面里
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),//第二种写法
      body: IndexedStack( 
        index: currentIndex,
        children:  tabBodies,
      )
      // body:currentPage,第一种写法不支持保持状态
    );
  }
  
}











// 下面是静态组件 输入stless
// class IndexPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:Text('百姓生活————')),
//       body:Center(child: Text('百姓生活—'),)
//     );
//   }
// }
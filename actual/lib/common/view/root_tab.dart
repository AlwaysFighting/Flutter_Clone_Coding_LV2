import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  // 언젠가 나중에 값을 셋팅해줄거야. (선언이 이미 되어있거든)
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    // length: 몇 개의 화면
    // vsync : 현재 statefulWidget <- 무조건 with SingleTickerProviderStateMixin 를 적어줘야함.
    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  // 매번 속성이 바뀔 때마다
  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Code Delivery',
      child: TabBarView(
        // 탭바 스크롤 금지
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),
          Container(child: Text('음식')),
          Container(child: Text('주문')),
          Container(child: Text('프로필')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: "음식",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: "주문",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "프로필",
          ),
        ],
      ),
    );
  }
}

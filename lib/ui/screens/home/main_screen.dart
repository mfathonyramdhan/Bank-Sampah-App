import 'package:flutter/material.dart';

import '../../screens/home/home_screen.dart';
import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/main_screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? bottomNavBarIndex;
  PageController? pageController;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: lightGreen,
          ),
          SafeArea(
            child: Stack(
              children: [
                /// BACKGROUND: LINEAR BACKGROUND
                Container(
                  width: deviceWidth(context),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF527D46),
                        Color(0xFF7EB044),
                      ],
                    ),
                  ),
                ),

                /// VIEW: PAGE TAB VIEW
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      bottomNavBarIndex = index;
                    });
                  },
                  children: [
                    HomeScreen(),
                  ],
                ),

                /// WIDGET: BACK LAYER BOTTOM NAVBAR
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: whitePure,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFCCCCCC),
                          blurRadius: 20,
                          offset: Offset(6, 0),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                  ),
                ),

                /// WIDGET: HALF CIRCLE BOTTOM BAR
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 70,
                    height: 70,
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: whitePure,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFCCCCCC),
                          blurRadius: 20,
                          offset: Offset(6, 0),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                  ),
                ),

                /// WIDGET: BOTTOM NAVIGATION BAR
                generateBottomNavbar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generateBottomNavbar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: whitePure,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: bottomNavBarIndex ?? 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: blackPure,
          unselectedItemColor: blackPure,
          selectedLabelStyle: boldRobotoFont,
          unselectedLabelStyle: mediumRobotoFont,
          onTap: (index) {
            setState(() {
              bottomNavBarIndex = index;
              pageController!.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Profil",
              icon: Container(
                margin: EdgeInsets.only(bottom: 6),
                height: 34,
                child: Image.asset(
                  "assets/image/icon_profil.png",
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Transaksi",
              icon: Container(
                margin: EdgeInsets.only(bottom: 6),
                height: 34,
                child: Image.asset(
                  "assets/image/icon_transaksi.png",
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Chat",
              icon: Container(
                margin: EdgeInsets.only(bottom: 6),
                height: 34,
                child: Image.asset(
                  "assets/image/icon_chat.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

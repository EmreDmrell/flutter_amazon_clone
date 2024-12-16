import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/account/screens/account_screen.dart';
import 'package:flutter_amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:flutter_amazon_clone/features/home/screens/home_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';

  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          buildBottomNavigationBarItem(const Icon(Icons.home_outlined), 0),
          buildBottomNavigationBarItem(const Icon(Icons.person_outline_outlined), 1),
          buildBottomNavigationBarItem(const Icon(Icons.shopping_cart_outlined), 2, badge: true, cartLen: userCartLen),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(Icon icon, int page, {bool badge = false, int? cartLen = 15}) {
    return BottomNavigationBarItem(
      icon: Container(
        width: bottomBarWidth,
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
            color: _page == page ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
            width: bottomBarBorderWidth,
          ),
        )),
        child: badge
            ? badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                  elevation: 1,
                ),
                badgeContent: Text(cartLen.toString(), style: const TextStyle(color: Colors.white),),
                child: icon,
              )
            : icon,
      ),
      label: '',
    );
  }
}

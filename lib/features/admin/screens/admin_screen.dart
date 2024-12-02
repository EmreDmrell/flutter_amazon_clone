import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/admin/screens/posts_screen.dart';


class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-page';

  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminScreen> {
  int _page = 0;
  double adminPageWidth = 42;
  double adminPageBorderWidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const Scaffold(
      body: Center(
        child: Text('Post Screen'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Cart Screen"),
      ),
    )
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Admin',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
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
          buildBottomNavigationBarItem(const Icon(Icons.analytics_outlined), 1),
          buildBottomNavigationBarItem(const Icon(Icons.all_inbox_outlined), 2),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(Icon icon, int page, {bool badge = false, int cartLen = 4}) {
    return BottomNavigationBarItem(
      icon: Container(
        width: adminPageWidth,
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
            color: _page == page ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
            width: adminPageBorderWidth,
          ),
        )),
        child: icon,
      ),
      label: '',
    );
  }
}

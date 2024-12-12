import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/home/services/home_services.dart';
import 'package:flutter_amazon_clone/features/home/widgets/carousel_image.dart';
import 'package:flutter_amazon_clone/features/home/widgets/deal_of_day.dart';
import 'package:flutter_amazon_clone/features/home/widgets/top_categories.dart';
import 'package:flutter_amazon_clone/features/search/screens/search_screen.dart';

import '../../../constants/global_variables.dart';
import '../widgets/address_box.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    HomeServices homeServices = HomeServices();

    Future<void> refresh() async{

      Future.delayed(const Duration(seconds: 2), () {
        if(context.mounted){
          homeServices.fetchDealOfDay(context: context);
        }
      });

    }
    void navigateToSearchScreen(String query) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onTapOutside: (event) {FocusManager.instance.primaryFocus?.unfocus();},
                      //I don't understand how it passes the query
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () => {},
                          child: const Padding(
                            padding:  EdgeInsets.only(left: 6),
                            child:  Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:
                              const BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Type for searching',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                )),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              AddressBox(),
              SizedBox(
                height: 10,
              ),
              TopCategories(),
              SizedBox(
                height: 10,
              ),
              CarouselImage(),
              DealOfDay(),
            ],
          ),
        ),
      ),
    );
  }
}

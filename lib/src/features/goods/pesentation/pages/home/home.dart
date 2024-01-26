import 'package:flutter/material.dart';
import 'package:store_house/core/utils/dummy_data.dart';
 import 'package:store_house/src/features/goods/pesentation/pages/docs/docs.dart';
import 'package:store_house/src/features/goods/pesentation/pages/goods/allGoods.dart';
import 'package:store_house/src/features/goods/pesentation/pages/home/widgets/home_appbar.dart';
import 'package:store_house/src/features/goods/pesentation/pages/home/widgets/home_item.dart';
import 'package:store_house/src/features/goods/pesentation/pages/transactions/incoming/new_incoming_page.dart';
import 'package:store_house/src/features/goods/pesentation/pages/transactions/outgoing/new_outgoing.dart';
import 'package:store_house/src/theme/app_color.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List homeItems = [
    {"icon": "assets/icons/goods.svg", "page": const GoodsPage()},
    {"icon": "assets/icons/docs.svg", "page": Docs()},
    {"icon": "assets/icons/outgoing.svg", "page": NewOutgoingPage()},
    {"icon": "assets/icons/incoming.svg", "page": NewIncomingPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: HomeAppBar(profile: profile),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildBody(context),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        shrinkWrap: true,
        // Define the number of items in the grid.
        // Set the grid layout. You can use `GridView.count` or `GridView.extent`.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid.
          crossAxisSpacing:8.0, // Spacing between columns.
          mainAxisSpacing: 8.0, // Spacing between rows.
        ),
        children: List.generate(
          homeItems.length,
          (index) => _buildHomeItem(
              homeItems[index]["icon"], homeItems[index]["page"], context),
        ),
        // Build each grid item.
      ),
    );
  }

  _buildHomeItem(String iconPath, Widget page, BuildContext context) {
    return HomeItem(
        icon: iconPath,
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            ));
  }
}

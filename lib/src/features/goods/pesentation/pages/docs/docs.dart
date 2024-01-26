import 'package:flutter/material.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/allTransactions.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/buildTab.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/docs_appBar.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/incomingTransactions.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/outgoingTransactions.dart';

import '../../../../../theme/app_color.dart';

class Docs extends StatefulWidget {
  Docs({Key? key}) : super(key: key);

  @override
  State<Docs> createState() => _DocsState();
}

class _DocsState extends State<Docs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: DocsAppbar(),
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
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Material(
                color: AppColor.appBgColor,
                child: TabBar(
                  indicatorColor: AppColor.appBgColor,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    _buildTab(0, 'assets/icons/inOut.svg'),
                    _buildTab(1, 'assets/icons/in.svg'),
                    _buildTab(2, 'assets/icons/out.svg'),
                  ],
                )),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  AllTransactions(),
                  OutgoingTransactions(),
                  IncomingTransactions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTab(index, path) {
    return Tab(
      child: SizedBox.expand(
        child: TabItem(
          path,
          isActive: index == _selectedTab,
          activeColor: AppColor.primary,
        ),
      ),
    );
  }
}

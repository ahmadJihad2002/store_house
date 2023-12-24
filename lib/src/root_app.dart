import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_constant.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/root_cubit/root_app_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/root_cubit/root_app_states.dart';

import 'package:store_house/src/features/goods/pesentation/pages/home/home.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/bottombar_item.dart';

import 'features/account/presentation/pages/account/account.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  final List _barItems = [
    {
      "icon": "assets/icons/home.svg",
      "active_icon": "assets/icons/home.svg",
      "page": HomePage(),
    },


    {
      "icon": "assets/icons/profile.svg",
      "active_icon": "assets/icons/profile.svg",
      "page": const AccountPage(),
    },
  ];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: AppConstant.animatedBodyMs),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  _buildAnimatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index, RootAppCubit cubit) {
    if (index == cubit.screenIndex) return;
    _controller.reset();
    setState(() {
      cubit.changeIndex(index);
      // _activeTab = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RootAppCubit, RootAppStates>(
        listener: (BuildContext context, RootAppStates state) {},
        builder: (context, state) {
          RootAppCubit cubit = RootAppCubit.get(context);
          return Scaffold(
            backgroundColor: AppColor.appBgColor,
            bottomNavigationBar: _buildBottomBar(cubit),
            body: _buildPage(cubit),
          );
        });
  }

  Widget _buildPage(RootAppCubit cubit) {
    return IndexedStack(
      index: cubit.screenIndex,
      children: List.generate(
        _barItems.length,
        (index) => _buildAnimatedPage(_barItems[index]["page"]),
      ),
    );
  }

  Widget _buildBottomBar(RootAppCubit cubit) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.bottomBarColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: _buildBottomIcon(cubit),
    );
  }

  Widget _buildBottomIcon(RootAppCubit cubit) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _barItems.length,
          (index) => BottomBarItem(
            _barItems[index]["icon"],
            isActive: cubit.screenIndex == index,
            activeColor: AppColor.primary,
            onTap: () {
              onPageChanged(index, cubit);
            },
          ),
        ),
      ),
    );
  }
}

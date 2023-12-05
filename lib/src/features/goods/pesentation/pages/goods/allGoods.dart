import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';

import 'package:store_house/src/features/goods/pesentation/bloc/get_all_goods_cubit/add_type_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/get_all_goods_cubit/add_type_states.dart';
import 'package:store_house/src/features/goods/pesentation/pages/goods/widgets/goods_appbar.dart';
import 'package:store_house/src/features/goods/pesentation/pages/goods/widgets/unit_card.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/custom_button.dart';

class GoodsPage extends StatefulWidget {
  const GoodsPage({Key? key}) : super(key: key);

  @override
  State<GoodsPage> createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetALLGoodsCubit, AppGetAllCubitStates>(
        listener: (context, state) {
      if (state is AppGetAllGoodsSuccessStates) {
      } else if (state is AppGetAllGoodsErrorStates) {
        print("error state nigga");
      }
    }, builder: (context, state) {
      GetALLGoodsCubit cubit = GetALLGoodsCubit.get(context);

      return Scaffold(
        backgroundColor: AppColor.appBgColor,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: AppColor.appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: GoodsAppbar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildBody(cubit),
                childCount: 1,
              ),
            )
          ],
        ),
      );
    });
  }

  _buildBody(GetALLGoodsCubit cubit) {
    return SizedBox(
       height: MediaQuery.of(context).size.height-100,
      child: GridView.builder(
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 5 / 7,
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 8.0,

          // Spacing between rows
        ),
        itemCount: cubit.allUnits.length,
        itemBuilder: (context, index) {
          return UnitCard(unit: cubit.allUnits[index]);
        },
      ),
    );
  }
}

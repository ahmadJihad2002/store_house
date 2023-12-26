import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_states.dart';
import 'package:store_house/src/features/goods/pesentation/pages/edit_unit_details/edit_unit_details.dart';
import 'package:store_house/src/features/goods/pesentation/pages/goods/widgets/goods_appbar.dart';
import 'package:store_house/src/features/goods/pesentation/pages/goods/widgets/unit_card.dart';
import 'package:store_house/src/features/goods/pesentation/pages/transactions/widgets/show_dialog.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/custom_progress_indicator.dart';

class GoodsPage extends StatelessWidget {
  const GoodsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoodsCubit cubit = GoodsCubit.get(context);

    return BlocConsumer<GoodsCubit, GoodsStates>(listener: (context, state) {
      if (state is AppGetAllGoodsSuccessStates) {
        print('all goods been brought');
      } else if (state is AppGetAllGoodsErrorStates) {
        AppUtil.showSnackbar(
            context: context,
            message: state.error,
            color: AppColor.errorMsgColor);
      }
    }, builder: (context, state) {
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
              title: GoodsAppbar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildBody(cubit, state),
                childCount: 1,
              ),
            )
          ],
        ),
      );
    });
  }

  _buildBody(GoodsCubit cubit, GoodsStates state) {
    return ConditionalBuilder(
        condition: (state is AppGetAllGoodsSuccessStates),
        fallback: (context) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CustomProgressIndicator())),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: RefreshIndicator(
                onRefresh: () => cubit.getAllGoods() as Future<void>,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 5 / 7,
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: cubit.allUnits.length,
                  itemBuilder: (context, index) {
                    return UnitCard(
                      onTap: () {
                        // checking if we are browsing goods or piking theme for transactions
                        if (cubit.addTransactionMode) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MyCustomDialog(
                                unit: cubit.allUnits[index],
                                transactionType: cubit.transactionType!,
                              );
                            },
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUnit(
                                        unit: cubit.allUnits[index],
                                      )));
                        }
                      },
                      unit: cubit.allUnits[index],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}

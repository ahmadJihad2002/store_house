import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_cuit.dart';
import 'package:store_house/src/features/goods/pesentation/pages/goods/allGoods.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/build_svg_icon.dart';

class ListOfUnits extends StatelessWidget {
  ListOfUnits({
    Key? key,
    required this.units,
    required this.transactionType,
  }) : super(key: key);
  final List<UnitModel> units;
  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "البضائع",
          style: TextStyle(fontSize: 14),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: List.generate(
                    units.length,
                    (index) => _buildItem(index, context),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    context.read<GoodsCubit>().addTransactionMode = true;
                    context.read<GoodsCubit>().transactionType =
                        transactionType;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoodsPage()));
                  },
                  child: const BuildSVGIcon(
                    width: 40,
                    height: 40,
                    color: AppColor.mainColor,
                    icon: 'assets/icons/add.svg',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildItem(int index, BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () {
                  context
                      .read<TransactionCubit>()
                      .deleteIncomingUnitById(units[index].id);
                },
                child: Icon(Icons.delete_outline)),
            SizedBox(width: 30, child: Text('${units[index].quantity}')),
            SizedBox(
              width: 30,
              height: 30,
              child: Text(
                '${units[index].name}',overflow: TextOverflow.clip,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: 40,
                height: 40,
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: units[index].image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_cuit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_states.dart';
import 'package:store_house/src/features/goods/pesentation/pages/goods/allGoods.dart';
import 'package:store_house/src/theme/app_color.dart';
import 'package:store_house/src/widgets/build_svg_icon.dart';


class IncomingUnits extends StatelessWidget {
  IncomingUnits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionCubit cubit = TransactionCubit.get(context);

    return BlocConsumer<TransactionCubit, TransactionStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                          cubit.incomingGoods.length,
                          (index) => Stack(children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("${cubit.incomingGoods[index].price}"),
                                  Text(
                                      '${cubit.incomingGoods[index].quantity}'),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        imageUrl:
                                            cubit.incomingGoods[index].image,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    cubit.incomingGoods[index].name,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.deleteIncomingUnit(index);
                                },
                                child: const BuildSVGIcon(
                                  icon: 'assets/icons/cancel.svg',
                                  color: AppColor.mainColor,
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<GoodsCubit>().addTransactionMode=true;

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
        });
  }
}

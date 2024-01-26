import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/data/models/transaction_model.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_cuit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_states.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/widgets/doc_detailsAppBar.dart';
import 'package:store_house/src/widgets/custom_button.dart';
import 'package:store_house/src/widgets/custom_progress_indicator.dart';

import '../../../../../theme/app_color.dart';

class DocsDetails extends StatelessWidget {
  DocsDetails({Key? key, required this.doc}) : super(key: key);

  final TransactionModel doc;

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
            title: DocsDetailsAppbar(),
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
    TransactionCubit cubit = TransactionCubit.get(context);
    return BlocConsumer<TransactionCubit, TransactionStates>(
        listener: (context, state) {
      if (state is DeleteTransactionsSuccessStates) {
        Navigator.pop(context);
        cubit.getAllTransactions();
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
        builder: (_) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CustomProgressIndicator())),
        condition: (state is DeleteTransactionsLoadingStates),
        fallback: (_) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doc.date),
              const SizedBox(height: 10),
              Text(doc.description),
              const SizedBox(height: 10),
              _buildDocUnits(doc.units, context),
              const SizedBox(height: 10),
              CustomButton(
                  title: 'حذف', onTap: () => cubit.deleteTransactionDoc(doc.id))
            ],
          ),
        ),
      );
    });
  }

  _buildDocUnits(List<UnitModel> units, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: List.generate(
                units.length,
                (index) => _buildItem(units[index].quantity, units[index].name,
                    units[index].image, context),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _buildItem(int quantity, String name, String image, BuildContext context) {
    return Container(
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
          SizedBox(width: 30, child: Text('$quantity')),
          SizedBox(

            child: Text(
              '$name',
              overflow: TextOverflow.clip,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: image,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

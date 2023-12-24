import 'package:flutter/material.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/theme/app_color.dart';

import '../../../../data/models/unit_model.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    Key? key,
    required this.date,
    required this.transactionType,
    required this.description,
    required this.units,
  }) : super(key: key);
  final String date;
  final TransactionType transactionType;
  final String description;
  final List<UnitModel> units;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onLongPress: () {
      //   setState(() {
      //     isSelected = true;
      //   });
      // },
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.selectColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        widget.description.isEmpty
                            ? 'لا يوجد'
                            : widget.description,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w800)),
                    Text(widget.transactionType == TransactionType.incoming
                        ? 'صادر'
                        : 'وارد'),
                  ],
                ),
                Text(widget.date),
                Row(
                    children: widget.units
                        .map(
                          (e) => Text(
                            "${e.name} : ${e.quantity} ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 10),
                          ),
                        )
                        .toList()),
              ])),
    );
  }
}

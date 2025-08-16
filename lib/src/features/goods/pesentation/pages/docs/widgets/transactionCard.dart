import 'package:flutter/material.dart';
import 'package:store_house/src/features/goods/data/models/transaction_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/pesentation/pages/docs/doc_details.dart';
import 'package:store_house/src/theme/app_color.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    Key? key,
    required this.doc,
  }) : super(key: key);

  final TransactionModel doc;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DocsDetails(
                      doc: widget.doc,
                    )));
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
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
                    Flexible(
                      child: Text(
                          textDirection: TextDirection.rtl,
                          widget.doc.description.isEmpty
                              ? 'لا يوجد'
                              : widget.doc.description,

                           style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                          ),
                      overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                     Padding(
                       padding:const EdgeInsets.only(right: 10) ,
                       child: Text(widget.doc.transactionType == TransactionType.incoming
                          ? 'وارد'
                          : 'صادر'),
                     ),
                  ],

                ),
                Text(widget.doc.date),
                Wrap(
                    children: widget.doc.units
                        .map(
                          (e) => Row(
                            children: [
                              const SizedBox(
                                width: 10,
                                height: 20,
                              ),
                              Text(
                                "${e.name} : ${e.quantity}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 10),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ])),
    );
  }
}

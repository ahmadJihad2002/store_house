import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_house/src/features/goods/data/models/transaction_model.dart';

Future<void> exportToExcel({
  required BuildContext context,
  required TransactionModel transaction,
}) async {
  // Show loading popup with icon
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.downloading, size: 48, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'Exporting to Excel...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    ),
  );

  try {
    // Perform export in background
    final filePath = await _exportToExcel(transaction);

    // Close loading popup
    if (context.mounted) Navigator.of(context).pop();

    // Show share dialog
    await Share.shareXFiles([XFile(filePath)], text: 'Exported Transactions');
  } catch (e) {
    // Close loading popup on error
    if (context.mounted) Navigator.of(context).pop();

    // Show error message
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: ${e.toString()}')),
      );
    }
  }
}

Future<String> _exportToExcel(TransactionModel transaction) async {
  final excel = Excel.createExcel();
  final sheet = excel['Transactions'];

  // Add headers
  sheet.appendRow([
    'Transaction ID',
    'Date',
    'Type',
    'Description',
    'Item Name',
    'Item Description',
    'Price',
    'Quantity'
  ]);

  // Add data rows
  for (final unit in transaction.units) {
    sheet.appendRow([
      transaction.id,
      transaction.timestampToFormattedDate(transaction.timeStamp),
      transaction.transactionType.name.toString(),
      transaction.description,
      unit.name,
      unit.description,
      unit.price,
      unit.quantity
    ]);
  }

  // Generate filename
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final fileName = 'transaction_${transaction.id}_$timestamp.xlsx';

  // Get storage directory
  Directory directory;
  if (Platform.isAndroid) {
    await Permission.storage.request();
    directory = (await getExternalStorageDirectory())!;
  } else if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    throw UnsupportedError('Unsupported platform');
  }

  // Save file
  final filePath = '${directory.path}/$fileName';
  await File(filePath).writeAsBytes(excel.save()!);

  return filePath;
}

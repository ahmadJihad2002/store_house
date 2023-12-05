import 'package:flutter/material.dart';

class QuantityDialog extends StatelessWidget {
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Quantity'),
      content: TextFormField(
        controller: _quantityController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Quantity'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final quantity = int.tryParse(_quantityController.text);
            if (quantity != null) {
              print(quantity);
              // widget.onQuantitySelected(quantity);
              Navigator.of(context).pop();
            }
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTX;

  NewTransaction({required this.addTX});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime date = DateTime.now();

  final titleController = TextEditingController();
  final priceController = TextEditingController();

  void submitData(BuildContext context) {
    final title = titleController.text;
    final price = double.parse(priceController.text);

    if (title.isEmpty || price <= 0) {
      return;
    }

    widget.addTX(title, price, date);
    Navigator.pop(context);
  }

  void presentDatePicker() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now());
    date = newDate ?? date;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) {
                submitData(context);
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: priceController,
              onSubmitted: (_) {
                submitData(context);
              },
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Text(
                    DateFormat.yMMMMEEEEd().format(date),
                    style: const TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: presentDatePicker,
                      child: const Text(
                        'Change Date',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  submitData(context);
                },
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // طرق الدفع القديمة
    final List<String> paymentMethods = [
      'Credit Card',
      'PayPal',
      'Bank Transfer',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // قائمة طرق الدفع القديمة
            Expanded(
              child: ListView.builder(
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(paymentMethods[index]),
                    onTap: () {
                      // عند اختيار طريقة دفع قديمة، عرض نافذة التأكيد
                      _showPaymentConfirmationDialog(context);
                    },
                  );
                },
              ),
            ),
            // زر لإضافة طريقة دفع جديدة
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // يمكنك إضافة عملية إضافة طريقة دفع جديدة هنا
                  print("Add new payment method");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Add New Payment Method'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // نافذة تأكيد الدفع
  void _showPaymentConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Payment'),
          content: const Text('Do you want to confirm the payment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // تنفيذ عملية الدفع هنا
                print("Payment confirmed");
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
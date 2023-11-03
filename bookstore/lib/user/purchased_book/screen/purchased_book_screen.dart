import 'package:flutter/material.dart';

class PurchasedBookScreen extends StatefulWidget {
  const PurchasedBookScreen({super.key});

  @override
  State<PurchasedBookScreen> createState() => _PurchasedBookScreenState();
}

class _PurchasedBookScreenState extends State<PurchasedBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sách đã mua'),
      ),
    );
  }
}

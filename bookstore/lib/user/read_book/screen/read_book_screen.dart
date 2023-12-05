import 'package:bookstore/base/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class ReadBookScreen extends StatefulWidget {
  const ReadBookScreen({super.key, required this.linkBook, required this.titleBook});
  final String titleBook;
  final String linkBook;

  @override
  State<ReadBookScreen> createState() => _ReadBookScreenState();
}

class _ReadBookScreenState extends State<ReadBookScreen> {

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      tittle: Text(widget.titleBook),
        haveBackButton: true,
        child: Center(
              child: SfPdfViewer.network(
                widget.linkBook,
                canShowScrollHead: true,
              ),
            ),
    );
  }
}

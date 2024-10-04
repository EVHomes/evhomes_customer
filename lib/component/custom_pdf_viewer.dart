import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class CustomPdfViewer extends StatelessWidget {
  final String link;
  const CustomPdfViewer({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
      ),
      body: SfPdfViewer.network(link),
    );
  }
}

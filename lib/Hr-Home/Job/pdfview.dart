import 'package:flutter/material.dart';
import 'package:hrm_final_project/uri.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomePage extends StatelessWidget {
  final String documentPath;

  const HomePage({required this.documentPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Applicant CV'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              // You can add any additional functionality here
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        documentPath,
      ),
    );
  }
}

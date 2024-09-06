import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HimnosScreen extends StatefulWidget {
  @override
  State<HimnosScreen> createState() => _HimnosScreenState();
}

class _HimnosScreenState extends State<HimnosScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final TextEditingController _searchController = TextEditingController();
  Future<void>? _loadPdfFuture;

  @override
  void initState() {
    super.initState();
    _loadPdfFuture = _loadPdf();
    _searchController.addListener(() {
      setState(() {
        // No need to update searchQuery here, as we handle it directly in onChanged and onSubmitted
      });
      if (_searchController.text.isNotEmpty) {
        _pdfViewerController.searchText(_searchController.text.toLowerCase());
      } else {
        _pdfViewerController.clearSelection();
      }
    });
  }

  Future<void> _loadPdf() async {
    // Simulate a delay to load the PDF
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Himnos'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _pdfViewerController.searchText(value.toLowerCase());
                } else {
                  _pdfViewerController.clearSelection();
                }
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _pdfViewerController.clearSelection();
                  _pdfViewerController.searchText(value.toLowerCase());
                }
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _loadPdfFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el PDF'));
          } else {
            return SfPdfViewer.asset(
              'assets/himnario.pdf',
              controller: _pdfViewerController,
              initialPageNumber: 2,
              canShowPaginationDialog: true,
            );
          }
        },
      ),
    );
  }
}
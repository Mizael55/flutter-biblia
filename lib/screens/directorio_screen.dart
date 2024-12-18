import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../widgets/widgets.dart';

class DirectorioScreen extends StatefulWidget {
  @override
  State<DirectorioScreen> createState() => _DirectorioScreenState();
}

class _DirectorioScreenState extends State<DirectorioScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  late AdmobInterstitial interstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-7568006196201830/3482519473",
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.loaded) {
          if (!_isAdLoaded) {
            interstitialAd.show();
            setState(() {
              _isAdLoaded = true;
            });
          }
        }
      },
    );

    interstitialAd.load();

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.toLowerCase();
      });
      if (searchQuery.isNotEmpty) {
        _pdfViewerController.searchText(searchQuery);
      } else {
        _pdfViewerController.clearSelection();
      }
    });
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
        title: const Text('Direcciones y Teléfonos'),
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
      drawer: const DrawerMenu(),
      body: SfPdfViewer.asset(
        'assets/directorio.pdf',
        controller: _pdfViewerController,
        initialPageNumber: 2,
        canShowPaginationDialog: true,
      ),
    );
  }
}

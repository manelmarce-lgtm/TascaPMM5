import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () {
        String barcodeScanRes = "geo:39.64928,2.7623424";
        //String barcodeScanRes = "https://paucasesnovescifp.cat/";
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        ScanModel nouScan = ScanModel( valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes);
        launchURL(context,nouScan);
        
      },
    );
  }
}

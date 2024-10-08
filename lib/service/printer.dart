import 'dart:async';

import 'package:cloud_pos/service/shared_pref.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
import 'package:image/image.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class Printer {
  Printer._internal();
  static final Printer _instance = Printer._internal();
  factory Printer() => _instance;

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    await SunmiPrinter.initPrinter();
    return result;
  }

  Future printReceipt(Uint8List image8List) async {
    String type = await SharedPref().getPrinterType();
    // String model = await SharedPref().getPrinterModel();
    switch (type) {
      case 'Wifi':
        printerNetwork(image8List);
        break;
      case 'SunmiV2':
        sunmiPrinterFunc(image8List);
        break;
      case 'USB':
        printerUSB(image8List);
        break;
    }
  }

  Future printerUSB(Uint8List image8List) async {
    var printerManager = PrinterManager.instance;
    String namePrinterUSB = await SharedPref().getPrinterNameUSB();
    String prodIdPrinterUSB = await SharedPref().getPrinterProdIdUSB();
    String vendorIdPrinterUSB = await SharedPref().getPrinterVendorIdUSB();
    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    // bytes += generator.setGlobalCodeTable('CP1252');
    // bytes += generator.text('Test Print',
    //     styles: const PosStyles(align: PosAlign.center));
    // bytes += generator.text('Product 1');
    // bytes += generator.text('Product 2');
    final Image? imageResult = decodeImage(image8List);
    bytes += generator.image(imageResult!);

    bytes += generator.feed(2);
    bytes += generator.cut();
    await printerManager.connect(
        type: PrinterType.usb,
        model: UsbPrinterInput(
            name: namePrinterUSB,
            productId: prodIdPrinterUSB,
            vendorId: vendorIdPrinterUSB));
    await printerManager.send(type: PrinterType.usb, bytes: bytes);
    await printerManager.disconnect(type: PrinterType.usb);
  }

  Future printerNetwork(Uint8List image8List) async {
    String address = await SharedPref().getPrinterAddress();

    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    // final PosPrintResult res =
    //     await printer.connect('192.168.1.137', port: 9100);
    final PosPrintResult res = await printer.connect(address, port: 9100);
    // Image image = await getImage();
    final Image? imageResult = decodeImage(image8List);

    if (res == PosPrintResult.success) {
      await receipt(printer, imageResult);
      printer.disconnect();
    }
    print('Print result: ${res.msg}');
  }

  Future sunmiPrinterFunc(Uint8List image8List) async {
    _bindingPrinter();

    // await SunmiPrinter.printText('Payment receipt');
    // await SunmiPrinter.printText('Using the old way to bold!');
    // await SunmiPrinter.line();
    // await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(text: 'Name', width: 12, align: SunmiPrintAlign.LEFT),
    //   ColumnMaker(text: 'Qty', width: 6, align: SunmiPrintAlign.CENTER),
    //   ColumnMaker(text: 'UN', width: 6, align: SunmiPrintAlign.RIGHT),
    //   ColumnMaker(text: 'TOT', width: 6, align: SunmiPrintAlign.RIGHT),
    // ]);

    // await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printImage(image8List);
    await SunmiPrinter.lineWrap(5);
    await SunmiPrinter.exitTransactionPrint(true);
  }

  Future<void> receipt(NetworkPrinter printer, Image? image) async {
//     printer.text(
//         'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//     printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
//         styles: const PosStyles(codeTable: 'CP1252'));
//     printer.text('Special 2: blåbærgrød',
//         styles: const PosStyles(codeTable: 'CP1252'));
//
    // printer.text('Bold text', styles: const PosStyles(bold: true));
//     printer.text('Reverse text', styles: const PosStyles(reverse: true));
//     printer.text('Underlined text', styles: const PosStyles(underline: true));
//     printer.text('Align left', styles: const PosStyles(align: PosAlign.left));
//     printer.text('Align center',
//         styles: const PosStyles(align: PosAlign.center));
//     printer.text('Align right',
//         styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
//
    // printer.text('Text size 200%',
    //     styles: const PosStyles(
    //       height: PosTextSize.size2,
    //       width: PosTextSize.size2,
    //     ));

    // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    // printer.barcode(Barcode.upcA(barData));
    // printer.feed(2);

    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 200;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());
    //   printer.image(img!);
    // } catch (e) {
    //   print(e);
    // }

    printer.image(image!);
    printer.feed(1);
    printer.cut();
  }

  Future testPrinter() async {
    String type = await SharedPref().getPrinterType();
    // String model = await SharedPref().getPrinterModel();
    String address = await SharedPref().getPrinterAddress();
    String namePrinterUSB = await SharedPref().getPrinterNameUSB();
    String prodIdPrinterUSB = await SharedPref().getPrinterProdIdUSB();
    String vendorIdPrinterUSB = await SharedPref().getPrinterVendorIdUSB();

    Constants().printError(address);
    switch (type) {
      case 'Wifi':
        const PaperSize paper = PaperSize.mm80;
        final profile = await CapabilityProfile.load();
        final printer = NetworkPrinter(paper, profile);
        final PosPrintResult res = await printer.connect(address, port: 9100);

        if (res == PosPrintResult.success) {
          printer.text('Hello World', styles: const PosStyles(bold: true));
          printer.feed(1);
          printer.cut();
          printer.disconnect();
        }
        Constants().printError(type);
        break;
      case 'SunmiV2':
        _bindingPrinter();
        await SunmiPrinter.printText('Hello World');
        await SunmiPrinter.lineWrap(8);
        await SunmiPrinter.exitTransactionPrint(true);
        break;
      case 'USB':
        var printerManager = PrinterManager.instance;
        List<int> bytes = [];
        final profile = await CapabilityProfile.load();
        final generator = Generator(PaperSize.mm80, profile);
        // bytes += generator.setGlobalCodeTable('CP1252');
        bytes += generator.text('Hello World',
            styles: const PosStyles(align: PosAlign.center));
        bytes += generator.text('Product 1');
        bytes += generator.text('Product 2');
        bytes += generator.feed(2);
        bytes += generator.cut();

        await printerManager.connect(
            type: PrinterType.usb,
            model: UsbPrinterInput(
                name: namePrinterUSB,
                productId: prodIdPrinterUSB,
                vendorId: vendorIdPrinterUSB));
        printerManager.send(type: PrinterType.usb, bytes: bytes);
        await printerManager.disconnect(type: PrinterType.usb);
        break;
    }
  }

  Future<Image> getImage() async {
    final ByteData data =
        await rootBundle.load('assets/images/rabbit_black.jpg');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image? image = decodeImage(bytes);
    return image!;
  }

  String htmlTest =
      '<html><header><META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\"><META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\"><style type=\"text/css\"> body, td, th { font-family: Tahoma, Verdana, Arial; font-weight: normal; font-size: 12px;} .htext { font-family: Tahoma, Verdana, Arial; font-weight: bold; font-size: 20px; } .h1text { font-family: Tahoma, Verdana, Arial; font-weight: bold; font-size: 16px; } .h0text { font-family: Tahoma, Verdana, Arial; font-weight: bold; font-size: 12px; } </style></header><body><table border=\"0\" cellpadding=\"2\" cellspacing=\"0\" style=\"border-collapse:collapse; width:70mm;\"><tr><td align=\"center\" colspan=\"3\" class=\"htext\">001</td></tr><tr><td align=\"center\" colspan=\"3\" style=\"height:2mm;\"></td></tr><tr><td align=\"center\" colspan=\"3\"></td></tr><tr><td align=\"center\" colspan=\"3\" style=\"height:2mm;\"></td></tr><tr><td align=\"left\" colspan=\"3\">Date: 13/02/2024 10:20:11</td></tr><tr><td align=\"left\" colspan=\"3\">Tax Invoice No.RC022567/000001</td></tr><tr><td align=\"left\" colspan=\"3\">Cashier:Nipon Akarapimand</td></tr><tr><td align=\"left\">No Customer:1</td><td align=\"right\" colspan=\"2\">Eat In</td></tr><tr><td align=\"left\" colspan=\"3\"><hr/></td></tr><tr><td align=\"left\" style=\"width:200px;overflow:hidden;\">(DI) A75_แครกเกอร์สัปปะรด</td><td valign=\"top\" align=\"center\" style=\"width:5mm;overflow:hidden;\">1</td><td valign=\"top\" align=\"right\" style=\"width:20mm;overflow:hidden;\">55.00</td></tr><tr><td align=\"left\" colspan=\"3\"><hr/></td></tr><tr><td class=\"h0text\" align=\"left\" colspan=\"2\">Total Baht:1</td><td class=\"h0text\" align=\"right\">55.00</td></tr><tr><td class=\"h0text\" align=\"left\">Cash</td><td class=\"h0text\" valign=\"top\" align=\"right\" colspan=\"2\">55.00</td></tr><tr><td class=\"h0text\" align=\"left\">Change</td><td class=\"h0text\" align=\"right\" colspan=\"2\">65.00</td></tr><tr><td align=\"left\" colspan=\"3\"><hr/></td></tr><tr><td align=\"center\" colspan=\"3\"></td></tr><tr><td align=\"center\" colspan=\"3\" style=\"height:6mm;\"></td></tr><tr><td align=\"center\" class=\"h1text\" colspan=\"3\"><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAZAAAABUCAYAAACssWHaAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAABFbSURBVHhe7ZjRiuZMlsTm/V96llosyFWXfh/n4ukBpyAujiLqxiRfQ//r34f/5V//+tf/CfiGdbvGVF8epr0pD/S12/UVKA+7fXnjfrr3zp6YO+/+qTe1Kw9v9eXBvWOmntveeEegbvuvc77ERT0Q37Bu15jqy8O0N+WBvna7vgLlYbcvb9xP997ZE3Pn3T/1pnbl4a2+PLh3zNRz2xvvCNRt/3XOl7ioB+Ib1u0aU315mPamPNDXbtdXoDzs9uWN++neO3ti7rz7p97Urjy81ZcH946Zem574x2Buu2/zvkSF/VAfMO6XWOqLw/T3pQH+trt+gqUh92+vHE/3XtnT8ydd//Um9qVh7f68uDeMVPPbW+8I1C3/dc5X+KiHohvWLdrTPXlYdqb8kBfu11fgfKw25c37qd77+yJufPun3pTu/LwVl8e3Dtm6rntjXcE6rb/OudLXNQD8Q3rdo2pvjxMe1Me6Gu36ytQHnb78sb9dO+dPTF33v1Tb2pXHt7qy4N7x0w9t73xjkDd9l/nfImLeiC+Yd2uMdWXh2lvygN97XZ9BcrDbl/euJ/uvbMn5s67f+pN7crDW315cO+Yqee2N94RqNv+65wvcVEPxDes2zWm+vIw7U15oK/drq9Aedjtyxv307139sTcefdPvaldeXirLw/uHTP13PbGOwJ123+d8yUu6oH4hnW7xlRfHqa9KQ/0tdv1FSgPu3154366986emDvv/qk3tSsPb/Xlwb1jpp7b3nhHoG77r3O+xEU9EN+wbteY6svDtDflgb52u74C5WG3L2/cT/fe2RNz590/9aZ25eGtvjy4d8zUc9sb7wjUbf91zpe4qAfiG9btGlN9eZj2pjzQ127XV6A87Pbljfvp3jt7Yu68+6fe1K48vNWXB/eOmXpue+Mdgbrtv875Ehf1QHzDul1jqi8P096UB/ra7foKlIfdvrxxP917Z0/MnXf/1JvalYe3+vLg3jFTz21vvCNQt/3XOV/ioh6Ib1i3a0z15WHam/JAX7tdX4HysNuXN+6ne+/sibnz7p96U7vy8FZfHtw7Zuq57Y13BOq2/zrnS1zUA/EN63aNqb48THtTHuhrt+srUB52+/LG/XTvnT0xd979U29qVx7e6suDe8dMPbe98Y5A3fZf53yJi3ogvmHdrjHVl4dpb8oDfe12fQXKw25f3rif7r2zJ+bOu3/qTe3Kw1t9eXDvmKnntjfeEajb/uucL3FRD8Q3rNs1pvryMO1NeaCv3a6vQHnY7csb99O9d/bE3Hn3T72pXXl4qy8P7h0z9dz2xjsCddt/nfMlLuqB+IZ1u8ZUXx6mvSkP9LXb9RUoD7t9eeN+uvfOnpg77/6pN7UrD2/15cG9Y6ae2954R6Bu+69zvsRFPRDfsG7XmOrLw7Q35YG+dru+AuVhty9v3E/33tkTc+fdP/WmduXhrb48uHfM1HPbG+8I1G3/dc6XuKgH4hvW7RpTfXmY9qY80Ndu11egPOz25Y376d47e2LuvPun3tSuPLzVlwf3jpl6bnvjHYG67b/O+RIX9UB8w7pdY6ovD9PelAf62u36CpSH3b68cT/de2dPzJ13/9Sb2pWHt/ry4N4xU89tb7wjULf91zlf4qIeiG9Yt2tM9eVh2pvyQF+7XV+B8rDblzfup3vv7Im58+6felO78vBWXx7cO2bque2NdwTqtv8650tc1APxDet2jam+PEx7Ux7oa7frK1Aedvvyxv107509MXfe/VNvalce3urLg3vHTD23vfGOQN32X+d8iYt6IL5h3a4x1ZeHaW/KA33tdn0FysNuX964n+69syfmzrt/6k3tysNbfXlw75ip57Y33hGo2/7rnC9xUQ/EN6zbNab68jDtTXmgr92ur0B52O3LG/fTvXf2xNx590+9qV15eKsvD+4dM/Xc9sY7AnXbf53zJS7qgfiGdbvGVF8epr0pD/S12/UVKA+7fXnjfrr3zp6YO+/+qTe1Kw9v9eXBvWOmntveeEegbvuvc77ERT0Q37Bu15jqy8O0N+WBvna7vgLlYbcvb9xP997ZE3Pn3T/1pnbl4a2+PLh3zNRz2xvvCNRt/3XOl7ioB+Ib1u0aU315mPamPNDXbtdXoDzs9uWN++neO3ti7rz7p97Urjy81ZcH946Zem574x2Buu2/zvkSF/VAfMO6XWOqLw/T3pQH+trt+gqUh92+vHE/3XtnT8ydd//Um9qVh7f68uDeMVPPbW+8I1C3/dc5X+KiHohvWLdrTPXlYdqb8kBfu11fgfKw25c37qd77+yJufPun3pTu/LwVl8e3Dtm6rntjXcE6rb/OudLXNQD8Q3rdo2pvjxMe1Me6Gu36ytQHnb78sb9dO+dPTF33v1Tb2pXHt7qy4N7x0w9t73xjkDd9l/nfImLeiC+Yd2uMdWXh2lvygN97XZ9BcrDbl/euJ/uvbMn5s67f+pN7crDW315cO+Yqee2N94RqNv+65wvcVEPxDes2zWm+vIw7U15oK/drq9Aedjtyxv307139sTcefdPvaldeXirLw/uHTP13PbGOwJ123+d8yUu6oH4hnW7xlRfHqa9KQ/0tdv1FSgPu3154366986emDvv/qk3tSsPb/Xlwb1jpp7b3nhHoG77r3O+xEU9EN+wbteY6svDtDflgb52u74C5WG3L2/cT/fe2RNz590/9aZ25eGtvjy4d8zUc9sb7wjUbf91zpe4qAfiG9btGlN9eZj2pjzQ127XV6A87Pbljfvp3jt7Yu68+6fe1K48vNWXB/eOmXpue+Mdgbrtv875Ehf1QHzDul1jqi8P096UB/ra7foKlIfdvrxxP917Z0/MnXf/1JvalYe3+vLg3jFTz21vvCNQt/3XOV/ioh6Ib1i3a0z15WHam/JAX7tdX4HysNuXN+6ne+/sibnz7p96U7vy8FZfHtw7Zuq57Y13BOq2/zrnS1zUA/EN63aNqb48THtTHuhrt+srUB52+/LG/XTvnT0xd979U29qVx7e6suDe8dMPbe98Y5A3fZf53yJi3ogvmHdrjHVl4dpb8oDfe12fQXKw25f3rif7r2zJ+bOu3/qTe3Kw1t9eXDvmKnntjfeEajb/uucL3FRD8Q3rNs1pvryMO1NeaCv3a6vQHnY7csb99O9d/bE3Hn3T72pXXl4qy8P7h0z9dz2xjsCddt/nfMlLuqB+IZ1u8ZUXx6mvSkP9LXb9RUoD7t9eeN+uvfOnpg77/6pN7UrD2/15cG9Y6ae2954R6Bu+69zvsRFPRDfsG7XmOrLw7Q35YG+dru+AuVhty9v3E/33tkTc+fdP/WmduXhrb48uHfM1HPbG+8I1G3/dc6XuKgH4hvW7RpTfXmY9qY80Ndu11egPOz25Y376d47e2LuvPun3tSuPLzVlwf3jpl6bnvjHYG67b/O+RIX9UB8w7pdY6ovD9PelAf62u36CpSH3b68cT/de2dPzJ13/9Sb2pWHt/ry4N4xU89tb7wjULf91zlf4qIeiG9Yt2tM9eVh2pvyQF+7XV+B8rDblzfup3vv7Im58+6felO78vBWXx7cO2bque2NdwTqtv8650tc1APxDet2jam+PEx7Ux7oa7frK1Aedvvyxv107509MXfe/VNvalce3urLg3vHTD23vfGOQN32X+d8iYt6IL5h3a4x1ZeHaW/KA33tdn0FysNuX964n+69syfmzrt/6k3tysNbfXlw75ip57Y33hGo2/7rnC9xUQ/EN6zbNab68jDtTXmgr92ur0B52O3LG/fTvXf2xNx590+9qV15eKsvD+4dM/Xc9sY7AnXbf53zJS7qgfiGdbvGVF8epr0pD/S12/UVKA+7fXnjfrr3zp6YO+/+qTe1Kw9v9eXBvWOmntveeEegbvuvc77ERT0Q37Bu15jqy8O0N+WBvna7vgLlYbcvb9xP997ZE3Pn3T/1pnbl4a2+PLh3zNRz2xvvCNRt/3XOl7ioB+Ib1u0aU315mPamPNDXbtdXoDzs9uWN++neO3ti7rz7p97Urjy81ZcH946Zem574x2Buu2/zvkSF/VAfMO6XWOqLw/T3pQH+trt+gqUh92+vHE/3XtnT8ydd//Um9qVh7f68uDeMVPPbW+8I1C3/dc5X+KiHohvWLdrTPXlYdqb8kBfu11fgfKw25c37qd77+yJufPun3pTu/LwVl8e3Dtm6rntjXcE6rb/OudLXNQD8Q3rdo2pvjxMe1Me6Gu36ytQHnb78sb9dO+dPTF33v1Tb2pXHt7qy4N7x0w9t73xjkDd9l/nfImLeiC+Yd2uMdWXh2lvygN97XZ9BcrDbl/euJ/uvbMn5s67f+pN7crDW315cO+Yqee2N94RqNv+65wvcVEPxDes2zWm+vIw7U15oK/drq9Aedjtyxv307139sTcefdPvaldeXirLw/uHTP13PbGOwJ123+d8yUu6oH4hnW7xlRfHqa9KQ/0tdv1FSgPu3154366986emDvv/qk3tSsPb/Xlwb1jpp7b3nhHoG77r3O+xEU9EN+wbteY6svDtDflgb52u74C5WG3L2/cT/fe2RNz590/9aZ25eGtvjy4d8zUc9sb7wjUbf91zpe4qAfiG9btGlN9eZj2pjzQ127XV6A87Pbljfvp3jt7Yu68+6fe1K48vNWXB/eOmXpue+Mdgbrtv875Ehf1QHzDul1jqi8P096UB/ra7foKlIfdvrxxP917Z0/MnXf/1JvalYe3+vLg3jFTz21vvCNQt/3XOV/ioh6Ib1i3a0z15WHam/JAX7tdX4HysNuXN+6ne+/sibnz7p96U7vy8FZfHtw7Zuq57Y13BOq2/zrnS1zUA/EN63aNqb48THtTHuhrt+srUB52+/LG/XTvnT0xd979U29qVx7e6suDe8dMPbe98Y5A3fZf53yJi3ogvmHdrjHVl4dpb8oDfe12fQXKw25f3rif7r2zJ+bOu3/qTe3Kw1t9eXDvmKnntjfeEajb/uucL3FRD8Q3rNs1pvryMO1NeaCv3a6vQHnY7csb99O9d/bE3Hn3T72pXXl4qy8P7h0z9dz2xjsCddt/nfMlLuqB+IZ1u8ZUXx6mvSkP9LXb9RUoD7t9eeN+uvfOnpg77/6pN7UrD2/15cG9Y6ae2954R6Bu+69zvsRFPRDfsG7XmOrLw7Q35YG+dru+AuVhty9v3E/33tkTc+fdP/WmduXhrb48uHfM1HPbG+8I1G3/dc6XuKgH4hvW7RpTfXmY9qY80Ndu11egPOz25Y376d47e2LuvPun3tSuPLzVlwf3jpl6bnvjHYG67b/O+RIX9UB8w7pdY6ovD9PelAf62u36CpSH3b68cT/de2dPzJ13/9Sb2pWHt/ry4N4xU89tb7wjULf91zlf4nA4HA5bnH9ADofD4bDF+QfkcDgcDlucf0AOv3L3f753/cpvm/Vv3f3wdr/y22b9W3c/3PU/TLra/O3+h3/qDocfzus4/IF/OJ7eK3T/tP9P3yt0/7Tfve3B/r/1tj8czHkdhz/wD8fTG/Du//YNePf/3xvKG+/+9g3lDwc4r+PwB/7heHoD3v3dbe72vk31ePd3t6n+7u/Au799Q/nDAc7rOPyBfzie3j+s7p/637qV33q73zZQ3eq9ubtXdrsf6L2x+0/fUP5wgPM6Dn/gH47/9A1TP92B/dMbysNdD9797RvKHw5wXsfhD/zDsXs7cHf/8JsDd79tf3NA58Dd/cNvzkw2P3j3t28ofzjAeR2HP/APx9Pb3O3vbnO3933H3d/f3cXu7m/fUP5wgPM6Dn/gH46nt7nb393mbu/7jru/v7uL2tn/t91Q/nCA8zoOv8KPR/2I3PUrv23Wv73ryMqTjhS/9evf3XXElP9h/bvfNn+7/+GfusPhh/M6DofD4bDF+QfkcDgcDlucf0AOh8PhsMG///0/wugKM5096zgAAAAASUVORK5CYII=\"></td></tr><tr><td align=\"center\" colspan=\"3\" style=\"height:6mm;\"></td></tr><tr><td align=\"left\" colspan=\"3\"><hr/></td></tr><tr><td align=\"center\" colspan=\"3\" style=\"height:6mm;\"></td></tr><tr><td align=\"center\" colspan=\"3\"><img src=\"data:image/png;base64,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3fFvYB+dddmZLLENS2zDTmd3vqnENiyxzcoS27DENiyxTaXENux2x7+BfXTWZWeyxDYssQ07nd35phLbsMQ2K0tswxLbsMQ2lRLbsNsd/wb20VmXnckS27DENux0duebSmzDEtusLLENS2zDEttUSmzDbnf8G9hHZ112JktswxLbsNPZnW8qsQ1LbLOyxDYssQ1LbFMpsQ273fFvYB+dddmZLLENS2zDTmd3vqnENiyxzcoS27DENiyxTaXENux2x7+BfXTWZWeyxDYssQ07nd35phLbsMQ2K0tswxLbsMQ2lRLbsNsd/wb20VmXnckS27DENux0duebSmzDEtusLLENS2zDEttUSmzDbnf/GzTZH5XtZs9kiW1YYhuW2IYltrmpxDasy848qcQ2K7vd/W/QZH9Utps9kyW2YYltWGIbltjmphLbsC4786QS26zsdve/QZP9Udlu9kyW2IYltmGJbVhim5tKbMO67MyTSmyzstvd/wZN9kdlu9kzWWIbltiGJbZhiW1uKrEN67IzTyqxzcpud/8bNNkfle1mz2SJbVhiG5bYhiW2uanENqzLzjypxDYru939b9Bkf1S2mz2TJbZhiW1YYhuW2OamEtuwLjvzpBLbrOx2979Bk/1R2W72TJbYhiW2YYltWGKbm0psw7rszJNKbLOy293/Bk32R2W72TNZYhuW2IYltmGJbW4qsQ3rsjNPKrHNym43/gb2UVliG5bY5qQS27Dd7Jkr67IzWWIbltjmpBLbsC47kyW2YbcbfwP7qCyxDUtsc1KJbdhu9syVddmZLLENS2xzUoltWJedyRLbsNuNv4F9VJbYhiW2OanENmw3e+bKuuxMltiGJbY5qcQ2rMvOZIlt2O3G38A+KktswxLbnFRiG7abPXNlXXYmS2zDEtucVGIb1mVnssQ27Hbjb2AflSW2YYltTiqxDdvNnrmyLjuTJbZhiW1OKrEN67IzWWIbdrvxN7CPyhLbsMQ2J5XYhu1mz1xZl53JEtuwxDYnldiGddmZLLENu934G9hHZYltWGKbk0psw3azZ66sy85kiW1YYpuTSmzDuuxMltiG3W78DeyjssQ2LLHNSSW2YbvZM1fWZWeyxDYssc1JJbZhXXYmS2zDbnf/GxzO/tGwLjuTJbap1GVnfqnENiyxDeuyM1liG9ZlZ7LENmza/A0+zv7orMvO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\" scale=\"0\" /></td></tr><tr><td align=\"center\" colspan=\"3\" style=\"height:6mm;\"></td></tr></table></body></html>';
}

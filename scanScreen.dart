import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:prac/main.dart';
import 'package:prac/res/appColor.dart';
import 'package:prac/util/allText.dart';
import 'package:prac/util/marginPadding.dart';
import 'package:prac/widget/roundedIconButton.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_slide/we_slide.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var qrText = "";
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  WeSlideController? weSlideController;
  @override
  void initState() {
    super.initState();
    weSlideController = WeSlideController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: WeSlide(
          controller: weSlideController,
          bodyBorderRadiusBegin: 10,
          panelBorderRadiusBegin: 10,
          bodyBorderRadiusEnd: 10,
          panelBorderRadiusEnd: 10,
          backgroundColor: AppColor.transparentColor,
          panelMinSize: screenHeight * 0.13,
          panelMaxSize: screenHeight,
          body: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  QRView(
                    cameraFacing: CameraFacing.back,
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: AppColor.primaryColor,
                      borderRadius: 10,
                      borderLength: 130,
                      borderWidth: 10,
                      overlayColor: AppColor.primaryColor.withOpacity(0.4),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Column(
                      children: [
                        RoundedIconButton(
                          icon: Icons.flashlight_on_rounded,
                          onTap: () {},
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        RoundedIconButton(
                          icon: Icons.image_outlined,
                          title: 'Scan home\nGallery',
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: screenHeight * 0.01,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: screenHeight * 0.15,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            normalText('Scan Any QR Code'),
                            Positioned(
                              right: 0,
                              child: RoundedIconButton(
                                icon: Icons.close,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: screenHeight * 0.05,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          margin: AllMargin.customTop(),
                          padding: AllMargin.customMarginCardItemSame(),
                          decoration: BoxDecoration(
                              color: AppColor.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100)),
                          child: extraSmallText('Show Payment Code',
                              center: true, color: AppColor.primaryColor),
                        ),
                      ))
                ],
              ),
            ),
          ),
          panel: panel(),
          panelHeader: panelHeader()),
    );
  }

  panel() {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Container(
          color: AppColor.white,
          child: Column(
            children: [
              Container(
                padding: AllMargin.customHorizontal(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: AllMargin.customTop(),
                      margin: AllMargin.customTop(),
                      child: Container(
                        padding: AllMargin.customTop(),
                        margin: AllMargin.customVerticalLarge(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  weSlideController!.hide();
                                },
                                child: Icon(Icons.arrow_back)),
                            Row(
                              children: [
                                Container(
                                  margin: AllMargin.customRight(),
                                  child: normalText('Help',
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryColor),
                                ),
                                Container(
                                  child: normalText('Setting',
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryColor),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: AllMargin.customVertical(),
                      child: normal2Text('Enter Mobile Number to Pay',
                          fontWeight: FontWeight.bold, color: AppColor.black),
                    ),
                    Container(
                      child: smallText(
                          'Send Money Directly to Bank Account or Wallet',
                          fontWeight: FontWeight.normal,
                          color: AppColor.black),
                    ),
                    Container(
                        width: screenWidth,
                        margin: AllMargin.customVertical(),
                        padding: AllMargin.customVerticalLarge(),
                        child: inputBox(true)),
                    SizedBox(
                        width: screenWidth,
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth * 0.1,
                              height: screenWidth * 0.1,
                              padding:
                                  AllMargin.customMarginCardItemSameSmall(),
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(1000)),
                              child: Icon(
                                Icons.contact_page_outlined,
                                color: AppColor.black,
                              ),
                            ),
                            Container(
                              margin: AllMargin.customLeftLarge(),
                              child: smallText('Search Contacts',
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.primaryColor),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                color: AppColor.lightGrey,
                alignment: Alignment.centerLeft,
                margin: AllMargin.customVerticalLarge(),
                height: screenHeight * 0.025,
                padding: AllMargin.customHorizontal(),
                child: normalText('Contacts',
                    color: AppColor.black, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (contet, index) => customContactCard(index),
                ),
              )
            ],
          ),
        ));
  }

  Widget customContactCard(int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(0.3),
        child: normalText('A', color: AppColor.black),
      ),
      title: normalText('ABC Contact', color: AppColor.black),
      subtitle: extraSmallText('+91 9876543211', color: AppColor.greyColor),
    );
  }

  panelHeader() {
    return Container(
        height: screenHeight * 0.25,
        color: AppColor.white,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: screenWidth * 0.15,
                height: 6,
                decoration: BoxDecoration(
                    color: AppColor.lightGrey,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                  width: screenWidth,
                  margin: AllMargin.customMarginCardItemSame(),
                  child: inputBox(false)),
              SizedBox(
                height: screenHeight * 0.13,
              )
            ],
          ),
        ));
  }

  Widget inputBox(bool panel) {
    return Container(
        width: screenWidth,
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryColor)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryColor)),
              hintText: 'Enter Mobile Number or Name',
              labelText: 'Enter Mobile Number or Name',
              suffixIcon: Icon(
                  panel ? Icons.abc_rounded : Icons.contacts_outlined,
                  color: AppColor.primaryColor)),
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // qrText = scanData;
        controller.resumeCamera();
      });
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

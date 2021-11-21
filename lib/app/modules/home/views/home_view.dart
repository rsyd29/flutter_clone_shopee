import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_shopee/model_promo.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scroll_indicator/scroll_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final CarouselController _carouselController = CarouselController();
    final ScrollController scrollController = ScrollController();
    DateTime timeBackPressed = DateTime.now();
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);
          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            final message = 'Tekan lagi untuk keluar';
            Fluttertoast.showToast(
              msg: message,
              fontSize: 12,
              backgroundColor: Colors.black.withOpacity(0.7),
              gravity: ToastGravity.CENTER,
            );
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                pinned: true,
                title: Container(
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  // NOTE: Search Bar
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      suffixIcon:
                          Icon(MdiIcons.cameraOutline, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 11),
                      hintStyle: TextStyle(
                        color: Color(0xfff0664b),
                        fontSize: 14,
                      ),
                      hintText: 'Shopee Cloning',
                    ),
                  ),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Icon(MdiIcons.cartOutline),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4, right: 8),
                    child: Icon(MdiIcons.chatProcessingOutline),
                  ),
                ],
                backgroundColor: Color(0xffed4d2b),
                expandedHeight: Get.height * 0.33,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: Get.height * 0.33,
                          color: Colors.white,
                          // color: Colors.transparent,
                        ),
                      ),
                      // NOTE: Create Carousel Slider
                      CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: Get.height * 0.28,
                          autoPlay: true,
                          onPageChanged: (index, reason) =>
                              controller.currentSlider = index,
                        ),
                        items: promoCarousell.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.asset(
                                '$image',
                                fit: BoxFit.cover,
                                width: Get.width,
                              );
                            },
                          );
                        }).toList(),
                      ),
                      // NOTE: Point Carousel Promo
                      Positioned(
                        top: Get.height * 0.23,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: promoCarousell.asMap().entries.map<Widget>(
                            (entry) {
                              return GestureDetector(
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.currentSlider == entry.key
                                        ? Color(0xffed4d2b)
                                        : Colors.grey[300],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      // NOTE: QR Code, Saldo, Koin
                      Positioned(
                        top: Get.height * 0.26,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.scanQR();
                                  print('Buka QR Scan');
                                },
                                child: Container(
                                  child: Icon(
                                    MdiIcons.qrcodeScan,
                                    color: Color(0xffb2b2b2),
                                    size: 20,
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                width: 1,
                                color: Colors.grey[300],
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          MdiIcons.walletOutline,
                                          size: 16,
                                          color: Color(0xffff5722),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Rp27.000',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Isi Saldo ShopeePay',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 24,
                                width: 1,
                                color: Colors.grey[300],
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          MdiIcons.bitcoin,
                                          size: 16,
                                          color: Color(0xffe4b641),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '70 Koin',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Klaim koin di sini',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // TODO: Create All Body Content
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // NOTE: Create sub menu
                      subMenu(scrollController),
                      // NOTE: Create Flash Sale
                      flashSaleMenu(),
                      // NOTE: PRODUK TERLARIS
                      produkTerlarisMenu(),
                      // NOTE: Create REKOMENDASI
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 10,
                            color: Colors.grey[100],
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 8.0, right: 8.0, bottom: 16.0),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Text(
                                  'REKOMENDASI',
                                  style: TextStyle(
                                    color: Color(0xffed4d2b),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // NOTE: Rekomendasi Menu for Category
              SliverAppBar(
                elevation: 0,
                pinned: true,
                backgroundColor: Colors.grey[100],
                flexibleSpace: FlexibleSpaceBar(
                  background: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      width: Get.width * 0.18,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color:
                              (index == 0) ? Color(0xffed4d2b) : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                        left: 4,
                        top: 4,
                        bottom: 4,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            MdiIcons.thumbUp,
                            color: Color(0xffed4d2b),
                          ),
                          Text(
                            'Semua',
                            style: TextStyle(
                              color: (index == 0)
                                  ? Color(0xffed4d2b)
                                  : Colors.grey[500],
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // NOTE: Rekomendasi Menu for Shopping Stuff
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/sandal.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Promo 11.11 TERMURAH!!!! Sendal slop JELLY wanita dan pria rebook...infore_bisa bayar di tempat. cod.',
                                style: TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rp",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffef5739),
                                      ),
                                    ),
                                    Text(
                                      "2.600",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffef5739),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '10RB+ Terjual',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff919191),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 20,
                ),
              )
            ],
          ),
          // NOTE: BottomNavigationBar
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xffe74b2f),
            unselectedItemColor: Colors.grey,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.homeOutline),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.checkboxMultipleBlankOutline),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.cctv),
                label: 'Shopee Live',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.bellBadgeOutline),
                label: 'Notifikasi',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.accountOutline),
                label: 'Saya',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subMenu(ScrollController scrollController) {
    return Stack(
      children: [
        Container(
          height: Get.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(20),
            //   bottomRight: Radius.circular(20),
            // ),
          ),
        ),
        Column(
          children: [
            Container(
              height: Get.height * 0.265,
              // color: Colors.blue,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 24,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xffe9e9eb),
                          ),
                        ),
                        child: Image.asset(
                          'assets/shopee-logo.png',
                          height: Get.height * 0.04,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Shopee Clone',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            ScrollIndicator(
              scrollController: scrollController,
              width: Get.width * 0.05,
              height: Get.height * 0.005,
              indicatorWidth: Get.width * 0.02,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
              indicatorDecoration: BoxDecoration(
                color: Color(0xffed4d2b),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget flashSaleMenu() {
    return Column(
      children: [
        Container(
          height: 10,
          color: Colors.grey[100],
        ),
        Container(
          height: Get.height * 0.35,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'FLASH SALE',
                            style: TextStyle(
                              color: Color(0xffed4d2b),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          buildTime(),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Lihat Lainnya',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[500],
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 16,
                    itemBuilder: (context, index) => (index == 16 - 1)
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xffed4d2b),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Lihat Semua',
                                    style: TextStyle(
                                      color: Color(0xffed4d2b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: Get.height * 0.16,
                                  child: Image.asset(
                                    'assets/earphone.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Rp5.400',
                                      style: TextStyle(
                                        color: Color(0xffed4d2b),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: Get.height * 0.135,
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Color(0xffe8e8e8),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '0 TERJUAL',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget produkTerlarisMenu() {
    return Column(
      children: [
        Container(
          height: 10,
          color: Colors.grey[100],
        ),
        Container(
          height: Get.height * 0.4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'PRODUK TERLARIS',
                            style: TextStyle(
                              color: Color(0xffed4d2b),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Lihat Lainnya',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[500],
                            size: 12,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 9,
                    itemBuilder: (context, index) => (index == 9 - 1)
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xffed4d2b),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Lihat Semua',
                                    style: TextStyle(
                                      color: Color(0xffed4d2b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffe9e9eb),
                              ),
                            ),
                            margin: EdgeInsets.only(
                              left: 8,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: Get.height * 0.2,
                                  child: Image.asset(
                                    'assets/teflon.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    width: Get.height * 0.2,
                                    color: Colors.grey[100],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Teflon Mini Karakter'),
                                        SizedBox(height: 8),
                                        Text(
                                          '6RB+ terjual',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(controller.duration.value.inHours);
    final minutes =
        twoDigits(controller.duration.value.inMinutes.remainder(60));
    final seconds =
        twoDigits(controller.duration.value.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours),
        Text(
          ':',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        buildTimeCard(time: minutes),
        Text(
          ':',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        buildTimeCard(time: seconds),
      ],
    );
  }

  Widget buildTimeCard({required String time}) => Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
}

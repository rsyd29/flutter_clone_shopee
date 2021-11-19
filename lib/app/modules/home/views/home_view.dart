import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_shopee/model_promo.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final CarouselController _carouselController = CarouselController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              // NOTE: Search Bar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0xfff0664b),
                          fontSize: 14,
                        ),
                        hintText: 'Shopee Cloning',
                      ),
                    ),
                  ),
                  Icon(MdiIcons.cameraOutline, color: Colors.grey),
                ],
              ),
            ),
            // actions: [
            //   Container(
            //     margin: EdgeInsets.only(right: 4),
            //     child: Icon(MdiIcons.cartOutline),
            //   ),
            //   Container(
            //     margin: EdgeInsets.only(left: 4, right: 8),
            //     child: Icon(MdiIcons.chatProcessingOutline),
            //   ),
            // ],
            backgroundColor: Color(0xffed4d2b),
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // NOTE: Create Carousel Slider
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      viewportFraction: 1.5,
                      height: 165,
                      autoPlay: true,
                      onPageChanged: (index, reason) =>
                          controller.currentSlider = index,
                    ),
                    items: promoCarousell.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            child: Image.network(
                              '$i',
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  // NOTE: Point Carousel Promo
                  Align(
                    alignment: Alignment.bottomCenter,
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
                ],
              ),
            ),
          ),
          // TODO: Create All Body Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: Get.height * 0.48,
                      decoration: BoxDecoration(
                        color: Color(0xff1d58b2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    // NOTE: Create QR Code, Saldo, and Koin
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.all(8),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(5),
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
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  height: 10,
                  color: Colors.grey[200],
                ),
                // NOTE: Create Flash Sale
                Obx(
                  () => Container(
                    height: 200,
                    // color: Colors.green,
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                    ),
                    child: Column(
                      children: [
                        Row(
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
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 15,
                            itemBuilder: (context, index) => (index == 15 - 1)
                                ? Center(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 24, right: 24),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      children: [
                                        Container(
                                          height: 130,
                                          width: 130,
                                          child: Image.network(
                                            'https://cf.shopee.co.id/file/639ae14a456a915a007295a9d08873e6',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
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
                                          width: 100,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(0xffe8e8e8),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
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
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  height: 10,
                  color: Colors.grey[200],
                ),
                // NOTE: PRODUK TERLARIS
                Container(
                  height: 196,
                  // color: Colors.amber,
                  margin: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                  ),
                  child: Column(
                    children: [
                      Row(
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
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 15,
                          itemBuilder: (context, index) => (index == 15 - 1)
                              ? Center(
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 24, right: 24),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    top: 8,
                                    left: (index == 0) ? 0 : 8,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 110,
                                        child: Image.network(
                                          'https://cf.shopee.co.id/file/639ae14a456a915a007295a9d08873e6',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          width: 110,
                                          color: Colors.grey[200],
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
                // NOTE: Create REKOMENDASI
                Container(
                  margin: EdgeInsets.only(top: 8),
                  height: 10,
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
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

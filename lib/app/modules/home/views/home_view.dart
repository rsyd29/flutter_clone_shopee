import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone_shopee/model_promo.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final CarouselController _carouselController = CarouselController();
    return Obx(
      () {
        return Scaffold(
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
                    )
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
      },
    );
  }
}

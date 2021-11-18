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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      title: Text('Element $index'),
                    );
                  },
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
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
                backgroundColor: Colors.transparent,
                expandedHeight: 200,
                flexibleSpace: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: Get.height * 0.25 + 16,
                        viewportFraction: 1.5,
                        autoPlay: true,
                      ),
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(color: Colors.red),
                                child: Center(
                                  child: Text(
                                    'text $i',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

import 'package:flutter/material.dart';

import 'package:netflix_clone/screens/homescreen.dart';
import 'package:netflix_clone/screens/morescreen.dart';
import 'package:netflix_clone/screens/searchscreen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
            color: Colors.black,
            height: 60,
            child: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: "Home"),
                Tab(icon: Icon(Icons.search), text: "Search"),
                Tab(icon: Icon(Icons.photo_album_outlined), text: "New & Hot")
              ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
            )),
        body: const TabBarView(
            children: [Homescreen(), SearchScreen(), Morescreen()]),
      ),
    );
  }
}

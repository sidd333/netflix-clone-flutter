import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/upcoming_model.dart';
import 'package:netflix_clone/screens/searchscreen.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/custom_carousel.dart';
import 'package:netflix_clone/widgets/movie_card_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<UpcomingMovieModel> series;

  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    series = apiServices.getSeries();
    upcomingFuture = apiServices.getUpcomingMovies();
    nowPlayingFuture = apiServices.getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Image.asset(
          "assets/logo.png",
          height: 60,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(), // Adjust to the actual screen you want to navigate to
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(color: Colors.blue, height: 30, width: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: series,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the future is still loading
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If the future completed with an error
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  // If the future completed successfully with data

                  return CustomCarouselSlider(data: snapshot.data!);
                } else {
                  // If the future completed with no data
                  return const Center(child: Text('No upcoming movies found'));
                }
              },
            ),
            SizedBox(
              height: 250,
              child: MovieCardWidget(
                future: upcomingFuture,
                headLineText: "Upcoming Movies",
              ),
            ),
            SizedBox(
              height: 250,
              child: MovieCardWidget(
                future: nowPlayingFuture,
                headLineText: "Now Playing Movies",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

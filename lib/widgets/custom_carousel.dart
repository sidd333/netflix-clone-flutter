import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/upcoming_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  final UpcomingMovieModel data;
  const CustomCarouselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height * 0.33 < 300 ? 300 : size.height,
        child: CarouselSlider.builder(
            itemCount: data.search.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              var url = data.search[index].poster;

              return GestureDetector(
                  child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
              ));
            },
            options: CarouselOptions(autoPlay: true, aspectRatio: 16 / 9)));
  }
}

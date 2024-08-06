import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/upcoming_model.dart';

class MovieCardWidget extends StatelessWidget {
  final Future<UpcomingMovieModel> future;
  final String headLineText;

  const MovieCardWidget({
    super.key,
    required this.future,
    required this.headLineText,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UpcomingMovieModel>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data?.search == null ||
            snapshot.data!.search!.isEmpty) {
          return const Center(child: Text('No upcoming movies found'));
        } else {
          var data = snapshot.data!.search!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headLineText,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200, // Fixed height for the ListView
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var movie = data[index];
                    var posterUrl = movie.poster ?? '';
                    if (posterUrl.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey, // Fallback color if no poster
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'No Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(posterUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 120, // Fixed width for each item
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

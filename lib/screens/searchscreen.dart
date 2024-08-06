import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/upcoming_model.dart';
import 'package:netflix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  Future<UpcomingMovieModel>? searchResultsFuture;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void search(String s) {
    setState(() {
      searchResultsFuture = apiServices.getSearchResults(s);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CupertinoSearchTextField(
              padding: const EdgeInsets.all(10),
              controller: searchController,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
              style: TextStyle(color: Colors.white),
              backgroundColor: Colors.grey.shade300.withOpacity(0.3),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  search(searchController.text);
                }
              },
            ),
            Expanded(
              child: FutureBuilder<UpcomingMovieModel>(
                future: searchResultsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('No results found'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.search.isEmpty) {
                    return Center(child: Text('No results found'));
                  } else {
                    return GridView.builder(
                      itemCount: snapshot.data!.search.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10, // Adjust crossAxisSpacing to fit items
                        childAspectRatio: 0.75, // Adjust aspect ratio for better fit
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0), // Add padding around each item
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.search[index].poster,
                                  fit: BoxFit.cover, // Ensures image covers its area
                                ),
                              ),
                              SizedBox(height: 8), // Space between image and text
                              Container(
                                width: double.infinity, // Ensure text container takes full width
                                child: Text(
                                  snapshot.data!.search[index].title,
                                  overflow: TextOverflow.ellipsis, // Handle text overflow
                                  maxLines: 2, // Limit text to 2 lines
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12, // Adjust font size as needed
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_app/screens/detail_screen/detail_model.dart';

class DetailView extends StatelessWidget {
  final int moviesId;
  const DetailView({super.key, required this.moviesId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailModel>.reactive(
      viewModelBuilder: () => DetailModel(),

      onViewModelReady: (viewModel) {
        viewModel.getDetailScreenMovies(moviesId);
        
      },
      builder: (context, viewModel, child) {
        final movie = viewModel.detailScreenData;

        if (movie.isEmpty) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final posterPath = movie['poster_path'];
        final imgurl = "https://image.tmdb.org/t/p/w500$posterPath";

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none, // Allow Positioned widgets to overflow
                children: [
                  Container(
                    height: 300, // Height of the Stack
                    width: double.infinity,
                    child: Image.network(
                      imgurl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text("Image not available"),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: -50, // Adjust this value to move the child within view
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Optional styling
                      child: Container(
                        height: 160,
                        width: 120, // Adjusted size for better visibility
                        color: Colors.grey.shade200, // Background color
                        child: Image.network(
                          imgurl,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text("Image not available"),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 56,),
             Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                               
                      viewModel.detailScreenData["original_title"],
                      style: TextStyle(
                          color: const Color.fromARGB(255, 97, 76, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                      ),
                   ),
                   
                 ),
                 Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                        viewModel.detailScreenData['overview'],
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                            fontSize: 15,
                        
                    ),
                    ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),
                    child: Text(
                        "Reales Date: ${viewModel.detailScreenData["release_date"]}",style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                        ),
                    ),)
               ],
             ),
              
            ],
          ),
        );
      },
    );
  }
}

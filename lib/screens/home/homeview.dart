import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_app/screens/detail_screen/detail_view.dart';
import 'package:stacked_app/screens/login/login_view.dart';
import 'package:stacked_app/screens/sign/sign_view.dart';
import 'home_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeModel>.reactive(
      onViewModelReady: (viewModel) {
        viewModel.getUserData();
        viewModel.moviesGet();
        viewModel.pop_moviesGet();
        viewModel.filterMovies(viewModel.search_controller.text);
      },
      viewModelBuilder: () => HomeModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 45, 44, 44),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 45, 44, 44),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Use the context from Builder
                  },
                );
              },
            ),
            title: Center(
    child: SizedBox(
      height: 70, // Adjust height as needed
      width: 80,  // Adjust width as needed
      child: Lottie.asset("assets/animation/Animation - 1734778504656.json",repeat: true,animate: true),
    ),
  
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return LoginView();
                  }));
                },
                icon: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
          drawer: NavigationDrawer(viewModel: viewModel),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  width: 500.0, // Set the desired width
                  height: 50.0, // Set the desired height
                  child: TextField(
                    controller: viewModel.search_controller,
                    decoration: InputDecoration(
                      hintText: "Search Here", // Placeholder text
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                      // Search icon at the start
                      border: OutlineInputBorder( // Border style
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Padding inside the text field
                    ),
                    onChanged: (text) {
                      viewModel.filterMovies(viewModel.search_controller.text); // Update search results    
                    }
                  ),
                ),
              
                // Other widgets such as ListView, Trending Movies, etc.    
SizedBox(
  child: Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: viewModel.filteredMovies.length,
      itemBuilder: (context, index) {
        final movie = viewModel.allMovies[index];
        final posterPath = movie['poster_path'];
        final imgurl = "https://image.tmdb.org/t/p/w500$posterPath";
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => DetailView(moviesId: movie["id"]),
            ));
          },
          child: Container(
            color: Colors.white,
            height: 60,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
 Padding(
   padding: const EdgeInsets.all(8.0),
   child: Row(
     children: [
       Container(
        width: 30,
        height: 30,
         child: Image.network(
           imgurl,
            fit: BoxFit.fill,
         ),
       ),
   SizedBox(
    width: 9,
   ),
       Text(
         movie['title'] ?? '',
         style: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)),
       ),
     ],
   ),
 ),
              ],
            ),
          ),
        );
      },
    ),
  ),
),
const SizedBox(height: 20),
 Padding(
   padding: const EdgeInsets.all(8.0),
   child: Text(
     "Trending Movies🔥",
     style: TextStyle(
       fontWeight: FontWeight.w800,
       fontSize: 20, // Slightly larger text size for city name
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
   ),
 ),
 SizedBox(height: 20,),
      
 SizedBox(
   height: 210,
   child:viewModel.isTrendingLoading?
   Center(child: CircularProgressIndicator(),)
   : ListView.builder(
     scrollDirection: Axis.horizontal,
     itemCount: viewModel.allMovies.length,
     itemBuilder: (context, index) {
       // Access the movie data
       final movie = viewModel.allMovies[index];
       // Correct the typo in poster path
       final posterPath = movie['poster_path'];
       // Create the full image URL
       final imgurl = "https://image.tmdb.org/t/p/w500$posterPath";
       return Padding(
         padding: const EdgeInsets.only(left: 8.0),
         child: Column(
           children: [
             GestureDetector(
onTap:(){ Navigator.push(context,MaterialPageRoute(
  builder: (context)=>DetailView(moviesId: movie["id"],)));},
child: Container(
  width: 120,
  child: Image.network(
    imgurl,
    fit: BoxFit.cover,
  ),
),
             ),
             SizedBox(height: 10,),
             Expanded(child: Text(
                      movie["original_title"].length > 12
                          ? movie["original_title"].substring(0, 12) + "..."
                          : movie["original_title"], 
                      style: TextStyle(color: Colors.white,
                      fontSize: 13, // Slightly larger text size for city name
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
                      overflow: TextOverflow.ellipsis, // handles overflow
                      maxLines: 1, // ensures that it only takes one line
                    ),
                  )
           ],
         ),
       );
     },
   ),
 ),
 SizedBox(height: 20,),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
     "Popular Movies ❤️",
     style: TextStyle(
       fontWeight: FontWeight.w800,
       fontSize: 20, // Slightly larger text size for city name
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
     ),
     ),
  
 SizedBox(height: 20,),
 SizedBox(
   height: 230,
   child:viewModel.isTrendingLoading?
   Center(child: CircularProgressIndicator(),)
   : ListView.builder(
     scrollDirection: Axis.horizontal,
     itemCount: viewModel.popularMovies.length,
     itemBuilder: (context, index) {
       // Access the movie data
       final movie = viewModel.popularMovies[index];
       // Correct the typo in poster path
       final posterPath = movie['poster_path'];
       // Create the full image URL
       final imgurl = "https://image.tmdb.org/t/p/w500$posterPath";
       return Padding(
         padding: const EdgeInsets.only(left: 8.0),
         child: Column(
           children: [
             GestureDetector(
onTap:(){ Navigator.push(context,MaterialPageRoute(
  builder: (context)=>DetailView(moviesId: movie["id"],)));},
child: Container(
  width: 120,
  child: Image.network(
    imgurl,
    fit: BoxFit.cover,
  ),
),
             ),
             SizedBox(height: 10,),
             Expanded(child:
              Text(
                      movie["original_title"].length > 12
                          ? movie["original_title"].substring(0, 12) + "..."
                          : movie["original_title"], 
                      style: TextStyle(color: Colors.white,
                      fontSize: 13, // Slightly larger text size for city name
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
                      overflow: TextOverflow.ellipsis, // handles overflow
                      maxLines: 1, // ensures that it only takes one line
                    ),  ),
           SizedBox(height: 20,),
           
           ],
         ),
       );
     },
   ),
 ),
SizedBox(height: 20,),
Center(
  child: Text(
    "ALL MOVIES",
    style: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w800,
    ),
  ),
),
SizedBox(height: 15),

Container(
  padding: const EdgeInsets.symmetric(horizontal: 8.0), 
  margin: EdgeInsets.only(top: 20),// Add padding for better alignment
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 0.9,
      crossAxisCount: 2, // Number of columns
      crossAxisSpacing: 10, // Space between columns
      mainAxisSpacing: 10, // Space between rows
    ),
    shrinkWrap: true, // Ensures it does not take unnecessary space
    physics: NeverScrollableScrollPhysics(), // Prevents scrolling inside the grid
    itemCount: viewModel.allMovies.length,
    itemBuilder: (context, index) {
      final movie = viewModel.allMovies[index];
      final posterPath = movie['poster_path'];
      final imgurl = "https://image.tmdb.org/t/p/w500$posterPath";

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailView(moviesId: movie["id"]),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width, // Make the image fill the column width
              height: 140, // Define a consistent height for images
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                image: DecorationImage(
                  image: NetworkImage(imgurl),
                  fit: BoxFit.contain
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between image and title
            Text(
                      movie["original_title"].length > 9
                          ? movie["original_title"].substring(0, 9) + "..."
                          : movie["original_title"], 
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Center-align the title
              maxLines: 2, // Restrict title to 2 lines
              overflow: TextOverflow.ellipsis, // Ellipsis for long titles
            ),
          ],
        ),
      );
    },
  ),
),
              ] 
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.white), // Set icon color to white
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, color: Colors.white), // Set icon color to white
      label: "Profile",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite, color: Colors.white), // Set icon color to white
      label: "Favorites",
    ),
  ],
  backgroundColor: const Color.fromARGB(255, 90, 7, 1), // Set the background color to red
  selectedItemColor: Colors.white, // Set the selected item label color to white
  unselectedItemColor: Colors.grey, // Set the unselected item label color to white
),
          );
        
      },
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final HomeModel viewModel;

  const NavigationDrawer({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context), // No need for HomeModel
              buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    color: const Color.fromARGB(255, 74, 0, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          backgroundImage: AssetImage("assets/img/profile1 (1).jpeg"),

          radius: 60,
        ),
        const SizedBox(height: 20),
        // Check for username key and provide fallback
       Text(
          '${viewModel.userData['username']}', 
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
),
        const SizedBox(height: 8),
        // Check for email key and provide fallback
        Text(
          viewModel.userData['email'] ?? 'example@mail.com', // Fallback to 'example@mail.com' if email is missing
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        const SizedBox(height: 19),
      ],
    ),
  );

  Widget buildMenuItems(BuildContext context) => Column(
    children: [
      SizedBox(height: 19),
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text("Home"),
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomeView(); // Ensure HomeView is imported correctly
          }));
        },
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text("Profile"),
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomeView(); // Ensure HomeView is imported correctly
          }));
        },
      ),
      ListTile(
        leading: const Icon(Icons.favorite),
        title: const Text("Favourite"),
        onTap: () {
          Navigator.pop(context); // Close the drawer
        },
      ),
      ListTile(
        leading: const Icon(Icons.contact_mail),
        title: const Text("Contact"),
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomeView(); // Ensure HomeView is imported correctly
          }));
        },
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text("Logout"),
        onTap: () {
          viewModel.FireBase_logout();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return SignView(); // Ensure SignView is imported correctly
          }
          ),
          );
        },
      ),
    ],
  );
}


import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as https;
class HomeModel extends ChangeNotifier{
  int count=0;
  bool isTrendingLoading=true;
  List allMovies=[];
  List filteredMovies = []; // List for search results
  List upcomingMovies=[];
  List trendingMovies=[];
  List popularMovies=[];
  TextEditingController search_controller=TextEditingController();
  Map <String,String> userData={'email':'abc@gmail.com','username':'ABC'};

  final FirebaseFirestore firestore=FirebaseFirestore.instance;
late PersistentTabController bottomNavController;

  HomeModel() {
    bottomNavController = PersistentTabController(initialIndex: 0); // Start with first tab
  }
  void getUserData()async {
    // This can be from Firebase Authentication or Firestore
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDataSnapshot=await firestore.collection('users').doc(user.uid).get();
      userData={
        'email':userDataSnapshot['email']??'abc@gmail.com',
        'username':userDataSnapshot['username']??'ABC',
      };
    }
    notifyListeners();
  }

FireBase_logout() async {
  await FirebaseAuth.instance.signOut();
  userData = {'email': '', 'username': ''}; // Reset user data
  notifyListeners();
}

  moviesGet()async{
    var url=Uri.parse("https://api.themoviedb.org/3/trending/movie/week?api_key=3ac1e61a226df273e868dd0dd0c56dcb");
    var response =await https.get(url);
     var responseBody = jsonDecode(response.body);
     allMovies=responseBody["results"];
     notifyListeners();
     isTrendingLoading=false;
    // isTrendingLoading=false; 
//print(allMovies);
  }
  void filterMovies(String query) {
    
    if (query.isEmpty) {
      filteredMovies = []; // Reset to all movies
    } else {
      filteredMovies = allMovies.where((movie) {
        final title = movie['original_title']?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
  pop_moviesGet()async{
    var url=Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=3ac1e61a226df273e868dd0dd0c56dcb");
    var response =await https.get(url);
     var responseBody = jsonDecode(response.body);
     popularMovies=responseBody["results"];
     notifyListeners();
     isTrendingLoading=false;
    // isTrendingLoading=false; 
print(allMovies);
  }
  tre_moviesGet()async{
    var url=Uri.parse("https://api.themoviedb.org/3/trending/movie/week?api_key=3ac1e61a226df273e868dd0dd0c56dcb");
    var response =await https.get(url);
     var responseBody = jsonDecode(response.body);
     trendingMovies=responseBody["results"];
     notifyListeners();
     isTrendingLoading=false;
    // isTrendingLoading=false; 
//print(allMovies);
  }
  upcoming_movies()async{
     var url=Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=3ac1e61a226df273e868dd0dd0c56dcb");
    var response =await https.get(url);
     var responseBody = jsonDecode(response.body);
     upcomingMovies=responseBody["results"];
     notifyListeners();
     isTrendingLoading=false;
    // isTrendingLoading=false; 
//print(allMovies);
  }
}


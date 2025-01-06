import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_app/screens/home/homeview.dart';
import 'package:stacked_app/screens/login/login_view.dart';
import 'package:stacked_app/screens/splash_screen/splash_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashModel>.reactive(
      viewModelBuilder: () => SplashModel(),
      onViewModelReady: (viewModel) {
        viewModel.initialize(); // Initialize Firebase and check user status
      },
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          // Show a loading indicator while the ViewModel is processing
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 71, 7, 2),
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }

        // Navigate to the appropriate screen based on the ViewModel state
        return AnimatedSplashScreen(
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/logo (2).png",
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'THE_MOVIES\'',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 71, 7, 2),
          nextScreen: viewModel.isUserLoggedIn
              ? const HomeView() // Navigate to HomeView if the user is logged in
              : const LoginView(), // Navigate to LoginView otherwise
          splashIconSize: 250,
          duration: 500,
          splashTransition: SplashTransition.slideTransition,
        );
      },
    );
  }
}

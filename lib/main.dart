import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/features/splash/ui/splash_screen.dart';
import 'package:movieapp/resources/movie_details_repository.dart';
import 'package:movieapp/resources/movie_repository.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => MovieRepository(),
        ),
        RepositoryProvider(
          create: (context) => MovieDetailsRepository(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(412, 868),
        child: MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen()),
      ),
    );
  }
}

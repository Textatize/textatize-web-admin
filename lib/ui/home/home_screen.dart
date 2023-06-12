import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:textatize_admin/bloc/home/home_bloc.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Loading...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text(
              "Home Screen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ),
        );
      },
    );
  }
}

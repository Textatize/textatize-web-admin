import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:textatize_admin/bloc/auth/auth_bloc.dart";
import "package:textatize_admin/bloc/home/home_bloc.dart";
import "package:textatize_admin/ui/auth/login_screen.dart";
import "package:textatize_admin/ui/home/home_screen.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.read<HomeBloc>().add(GetHome(context: context));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (state is UnAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Textatize Admin",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

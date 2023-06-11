import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:textatize_admin/bloc/auth/auth_bloc.dart";

import "../../bloc/home/home_bloc.dart";
import "../home/home_screen.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Text("Register Screen"),
          ),
        );
      },
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:textatize_admin/bloc/auth/auth_bloc.dart";
import "package:textatize_admin/bloc/home/home_bloc.dart";
import "package:textatize_admin/ui/home/home_screen.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final double contentPadding = 16.0;
  bool hidePassword = true;
  bool remember = false;

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
        return Scaffold(
          body: Center(
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: contentPadding),
                        child: Image.asset(
                          "logo_large.png",
                          width: 300,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: contentPadding),
                        child: TextFormField(
                          onFieldSubmitted: (_) => submitForm(state),
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            hintText: "admin@textatizeapp.com",
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: contentPadding),
                        child: TextFormField(
                          onFieldSubmitted: (_) => submitForm(state),
                          controller: passwordController,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "SuP3rSecureP&ssw0rd123",
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => setState(() {
                                hidePassword = !hidePassword;
                              }),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: contentPadding),
                        child: Row(
                          children: [
                            const Text("Remember me?"),
                            Checkbox(
                              value: remember,
                              onChanged: (_) => setState(() {
                                remember = !remember;
                              }),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () => submitForm(state),
                              child: const Text("Login"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void submitForm(AuthState state) {
    if (state is! Authenticating) {
      context.read<AuthBloc>().add(
            LoginRequested(
              email: emailController.text,
              password: passwordController.text,
              remember: remember,
              context: context,
            ),
          );
    }
  }
}

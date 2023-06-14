import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:textatize_admin/bloc/auth/auth_bloc.dart";
import "package:textatize_admin/bloc/home/home_bloc.dart";
import "package:textatize_admin/ui/auth/login_screen.dart";
import "package:textatize_admin/ui/home/home_screen.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyController = TextEditingController();

  final double contentPadding = 16.0;
  bool hidePassword = true;
  bool hideVerify = true;
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
          appBar: AppBar(
            title: const Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
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
                          validator: (_) {
                            if (!EmailValidator.validate(
                              emailController.text,
                            )) {
                              return "Not a valid email!";
                            }
                            return null;
                          },
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
                          validator: (_) {
                            if (passwordController.text ==
                                verifyController.text) {
                              return "At least 6 characters please!";
                            }
                            return null;
                          },
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
                        child: TextFormField(
                          validator: (_) {
                            if (passwordController.text ==
                                verifyController.text) {
                              return "Passwords do not Match!";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => submitForm(state),
                          controller: verifyController,
                          obscureText: hideVerify,
                          decoration: InputDecoration(
                            labelText: "Verify Password",
                            hintText: "SuP3rSecureP&ssw0rd123",
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hideVerify
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => setState(() {
                                hideVerify = !hideVerify;
                              }),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: contentPadding),
                        child: Row(
                          children: [
                            Checkbox(
                              value: remember,
                              onChanged: (_) => setState(() {
                                remember = !remember;
                              }),
                            ),
                            const Text("Remember Me"),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () => submitForm(state),
                              child: state is Authenticating
                                  ? const CircularProgressIndicator()
                                  : const Text("Register"),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: .5,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(contentPadding),
                            child: const Text("OR"),
                          ),
                          Expanded(
                            child: Container(
                              height: .5,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: contentPadding),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text("Login"),
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            ),
                          ),
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
    if (state is! Authenticating && _formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            RegisterRequested(
              email: emailController.text,
              password: passwordController.text,
              remember: remember,
              context: context,
            ),
          );
    }
  }
}

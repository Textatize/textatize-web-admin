import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:textatize_admin/bloc/auth/auth_bloc.dart";
import "package:textatize_admin/bloc/home/home_bloc.dart";
import "package:textatize_admin/ui/auth/register_screen.dart";
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                                  ? const SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text("Login"),
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
                            child: const Text("Register"),
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
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

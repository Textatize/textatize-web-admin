import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:textatize_admin/bloc/auth/auth_bloc.dart";
import "package:textatize_admin/bloc/home/home_bloc.dart";
import "package:textatize_admin/ui/auth/login_screen.dart";
import "package:textatize_admin/ui/home/helpers/user_tile.dart";

import "../../models/user_model.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

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
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Textatize Admin",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  tooltip: "Logout",
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOut());
                    context.read<HomeBloc>().add(ResetHome());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                });
                              },
                              icon: const Icon(Icons.clear),),
                          labelText: "Search",
                          hintText: "Your Query Here",
                          border: const OutlineInputBorder(borderSide: BorderSide()),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                      tooltip: "Refresh",
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: context.read<HomeBloc>().users.length,
                  itemBuilder: (context, index) {
                    User user = context.read<HomeBloc>().users[index];
                    return UserTile(user);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
  final ScrollController scrollController = ScrollController();
  double scrollPosition = 0.0;
  int previousItemCount = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      previousItemCount = context.read<HomeBloc>().users.length;
      scrollPosition =
          scrollController.position.pixels; // capture the position here
      context.read<HomeBloc>().add(
            GetUsers(
              query: searchController.text,
              context: context,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomeLoaded) {
          if (previousItemCount < context.read<HomeBloc>().users.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.jumpTo(scrollPosition);
            });
          }
          previousItemCount = context.read<HomeBloc>().users.length;
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
                        onFieldSubmitted: (_) => context.read<HomeBloc>().add(
                              GetUsers(
                                query: searchController.text.trim(),
                                context: context,
                              ),
                            ),
                        textInputAction: TextInputAction.search,
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                              });
                              context.read<HomeBloc>().add(ResetQuery());
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          labelText: "Search",
                          hintText: "Your Query Here",
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                        });
                        context.read<HomeBloc>().add(ResetQuery());
                      },
                      icon: const Icon(Icons.refresh),
                      tooltip: "Refresh",
                    ),
                  )
                ],
              ),
              Expanded(
                child: state is! HomeLoaded
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Loading...",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      )
                    : context.read<HomeBloc>().users.isEmpty
                        ? const Center(
                            child: Text(
                              "No Users!",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: scrollController,
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

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'utils/text.dart';
import 'widgets/trending.dart';
import 'widgets/toprated.dart';
import 'widgets/tvToprated.dart';
import 'package:mob_bestmovieapp/widgets/secret.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob_bestmovieapp/auth_fb.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(MyApp());
}

TMDB apiCall() {
  final String apikey = '6c1cc2ae77b7b9cd5fc2490f81c2b2c1';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YzFjYzJhZTc3YjdiOWNkNWZjMjQ5MGY4MWMyYjJjMSIsInN1YiI6IjYzMzU5NzE2YmJkMGIwMDA5MTBiZTQ4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9qdaldxu0APypgbdu5IYZGPZsijw2_4QrDZ3wW0ktUM';
  return TMDB(ApiKeys(apikey, readaccesstoken),
      defaultLanguage: 'de-EU',
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
      home: const WidgetTree(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = AuthFb().currentUser;
  Future<void> signOut() async {
    await AuthFb().signOut();
  }

  List topratedmovies = [];
  List genreIds = [];
  List topratedTv = [];

  // List trendingseries = [];
  List tv = [];
  final String apikey = '6c1cc2ae77b7b9cd5fc2490f81c2b2c1';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YzFjYzJhZTc3YjdiOWNkNWZjMjQ5MGY4MWMyYjJjMSIsInN1YiI6IjYzMzU5NzE2YmJkMGIwMDA5MTBiZTQ4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9qdaldxu0APypgbdu5IYZGPZsijw2_4QrDZ3wW0ktUM';

  Future<List> loadmovie() async {
    TMDB tmdbWithCustomLogs = apiCall();

    Map trendingresult = await apiCall().v3.trending.getTrending();
    Map topratedresult = await apiCall().v3.movies.getTopRated();
    Map genreIdsresult = await apiCall().v3.genres.getMovieList();
    Map topratedTvresult = await apiCall().v3.tv.getTopRated();

    // Map tvresult = await tmdbWithCustomLogs.v3.tv.getTopRated();
    topratedTv = topratedTvresult['results'];
    topratedmovies = topratedresult['results'];
    genreIds = genreIdsresult['genres'];

    print(topratedTv);
    return trendingresult['results'];

    // tv = tvresult['result'];
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadmovie(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black54,
            appBar: AppBar(
              //backgroundColor: Colors.transparent,
              title: modified_text(
                text: 'The Watcher 3',
                size: 30,
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () async {
                      final result = await showSearch(
                          context: context, delegate: MediaSearch());
                      print(result);
                    },
                    icon: Icon(EvaIcons.searchOutline))
              ],
            ),
            body: ListView(
              children: [
                TrendingMovies(trending: snapshot.data!),
                TopRatedMovies(toprated: topratedmovies),
                TopRatedTv(toprated: topratedTv),
              ],
            ),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 35, 22, 90),
                    ),
                    child: modified_text(text: 'Burger Menü'),
                  ),
                  ListTile(
                    title: modified_text(text: 'Logout'),
                    onTap: () {
                      signOut();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Platzhalter'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MediaSearch extends SearchDelegate<String> {
  final media = <String>[];
  final recentMedia = ["Bu", "Jo"];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, "okay"),
      );

  //@override
  //Widget buildResults(BuildContext context) => Center(
  //child: Column(
  //mainAxisAlignment:MainAxisAlignment.center,
  //children: [
  //Icon(Icons.location_city, size: 120),
  //const SizedBox(height: 48),
  //Text(
  //query,
  //style: TextStyle(
  //color: Colors.black45,
  //fontSize: 64,
  //fontWeight: FontWeight.bold,
  //),
  //)
  //],
  //),
  //);

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<Map>(
      future: apiCall().v3.search.queryMovies("John Wick 4"),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Container(
                color: Colors.black45,
                alignment: Alignment.center,
                child: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return buildResultsSuccess(snapshot.data!);
            }
        }
      });

  //@override
  //Widget buildSuggestions(BuildContext context) {
  //  final suggestions = query.isEmpty
  //    ? recentMedia : media.where((med) {
  //      final mediaLower = med.toLowerCase();
  //      final queryLower = query.toLowerCase();
  //      return mediaLower.startsWith(queryLower);
  //  }).toList();
  //  return buildSuggestionsSuccess(suggestions);
  //}

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.black45,
        child: FutureBuilder<Map>(
          future: apiCall().v3.search.queryMovies("Jo"),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data!);
                }
            }
          },
        ),
      );

  Widget buildSuggestionsSuccess(Map<dynamic, dynamic> suggestions) =>
      ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
              //MaterialPageRoute(
              //  builder: (BuildContext context) => details(suggestion),
              //),
            },
            leading: Icon(Icons.play_arrow_outlined),
            title: Text(suggestion),
          );
        },
      );

  Widget buildNoSuggestions() => Center(
        child: Text("Nothing", style: TextStyle(color: Colors.white)),
      );
  Widget buildResultsSuccess(Map media) => ListView(
    
      //TrendingMovies(trending: media);
  );
}

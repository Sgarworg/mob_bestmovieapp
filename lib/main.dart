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

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(MyApp());
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
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      defaultLanguage: 'de-EU',
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true),
    );
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map genreIdsresult = await tmdbWithCustomLogs.v3.genres.getMovieList();
    Map topratedTvresult = await tmdbWithCustomLogs.v3.tv.getTopRated();


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
              title: modified_text(text: 'The Watcher 3',size: 30,),
              actions: <Widget>[IconButton(onPressed: null, icon: Icon(EvaIcons.searchOutline))],
            ),
            body: ListView(
              children: [
                TrendingMovies(trending: snapshot.data!),
                         TopRatedMovies(toprated:topratedmovies),
                          TopRatedTv(toprated: topratedTv),],


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

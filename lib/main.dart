import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'utils/text.dart';

import 'package:mob_bestmovieapp/widgets/secret.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob_bestmovieapp/auth_fb.dart';
import 'widgets/database.dart';
import 'package:mob_bestmovieapp/widgets/details.dart';
import 'widgets/savedMovies.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mob_bestmovieapp/pages/mediaSearch.dart';
import 'package:mob_bestmovieapp/widgets/visualMedia.dart';

Future<void> main() async {
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

TMDB apiCall() {
  final String apikey = '6c1cc2ae77b7b9cd5fc2490f81c2b2c1';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YzFjYzJhZTc3YjdiOWNkNWZjMjQ5MGY4MWMyYjJjMSIsInN1YiI6IjYzMzU5NzE2YmJkMGIwMDA5MTBiZTQ4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9qdaldxu0APypgbdu5IYZGPZsijw2_4QrDZ3wW0ktUM';
  return TMDB(ApiKeys(apikey, readaccesstoken),
      defaultLanguage: 'de-EU',
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
}

getResult(String toFind) async {
  var search = {};
  var movies = await apiCall().v3.search.queryMovies(toFind);
  search['movies'] = movies['results'];
  var series = await apiCall().v3.search.queryTvShows(toFind);
  search['series'] = series['results'];
  return search;
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
  List trending = [];
  List popular = [];
  List popularTv = [];
  List topratedTv = [];

  Future<List> loadmovie() async {
    Map trendingresult = await apiCall().v3.trending.getTrending();
    Map topratedresult = await apiCall().v3.movies.getTopRated();
    Map popularResult = await apiCall().v3.movies.getPopular();

    Map topratedTvresult = await apiCall().v3.tv.getTopRated();
    Map popularTvResult = await apiCall().v3.tv.getPopular();


    topratedTv = topratedTvresult['results'];
    topratedmovies = topratedresult['results'];
    trending = trendingresult['results'];
    popular = popularResult['results'];
    popularTv = popularTvResult['results'];


    return trendingresult['results'];
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadmovie(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black87,
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color(0xFF272626),
                        const Color(0xFFC90909),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 3.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
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
            body: ListView(children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Details(movies: trending[7])));
                },
                child: Container(
                  height: 350,
                  child: Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  alignment: FractionalOffset.topCenter,
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[7]['poster_path'])))),
                    ],
                  ),
                ),
              ),

              VisualMedia(visualmedia: snapshot.data!, string: 'Trending Movies',),
              VisualMedia(visualmedia: popular, string: 'Popular Movies',),
              VisualMedia(visualmedia: topratedmovies,string: 'Top Rated Movies',),

              VisualMedia(visualmedia: topratedTv, string: 'Top Rated TV Series',),
              VisualMedia(visualmedia: popularTv, string: 'Popular TV Series',),


            ]),
            drawer: Drawer(
              width: 200,
              child: ListView(
                //Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 60,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFF272626),
                              const Color(0xFFC90909),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(0.0, 2.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: modified_text(text: 'Burger Menü'),
                    ),
                  ),
                  ListTile(
                    title: modified_text(text: 'Logout'),
                    onTap: () {
                      signOut();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Watcher 3 List'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SavedMovies()));
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

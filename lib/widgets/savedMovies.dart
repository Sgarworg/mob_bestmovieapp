import 'package:flutter/material.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/widgets/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob_bestmovieapp/auth_fb.dart';
import 'package:mob_bestmovieapp/widgets/details.dart';
import 'package:mob_bestmovieapp/utils/text.dart';

class SavedMovies extends StatelessWidget {
  const SavedMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
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
                title: modified_text(
                  text: 'Watcher 3 List',
                  size: 30,
                ),
              ),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            childAspectRatio: (0.75),
                          ),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Details(
                                            movies: snapshot.data![index])));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              ('https://image.tmdb.org/t/p/w500' +
                                                  snapshot.data![index]
                                                      ['poster_path']),
                                            ))),
                                    Container(
                                      child: modified_text(
                                        text: snapshot.data![index]['title'] !=
                                                null
                                            ? snapshot.data![index]['title']
                                            : snapshot.data![index]['name'] !=
                                                    null
                                                ? snapshot.data![index]['name']
                                                : 'loading',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

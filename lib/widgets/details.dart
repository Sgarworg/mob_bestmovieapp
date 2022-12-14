import 'package:flutter/material.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/widgets/database.dart';
import 'package:mob_bestmovieapp/utils/replace.dart';

class Details extends StatelessWidget {
  final Map movies;

  const Details({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          text: 'Details',
          size: 30,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              updateUser(movies);
            },
          ),
          IconButton(
              onPressed: () {
                deleteEntry(movies);
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),

        child: SingleChildScrollView(
            //scrollDirection: Axis.vertical,
            child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                child: modified_text(
                  text: movies['title'] != null
                      ? movies['title']
                      : movies['name'] != null
                          ? movies['name']
                          : 'No title found',
                  size: 30,
                )),
            Container(child: replaceClass.replace(movies['poster_path'])),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: modified_text(
                    text: movies['release_date'] != null
                        ? 'Release: ' + movies['release_date'].toString() + ' '
                        : '',
                    size: 18,
                  ),
                ),
                Container(
                    child: modified_text(
                  text: 'Votes: ' + movies['vote_average'].toString(),
                  size: 18,
                )),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border.all(
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: modified_text(
                    text: movies['overview'] != null && movies['overview'] != ''
                        ? movies['overview']
                        : 'keine Beschreibung verfügbar',
                    size: 24,
                  )),
            )
          ],
        )),
      ),

      // padding: EdgeInsets.all(30),
      // child: modified_text(text: movies['overview']!=null?movies['overview']:'nix da :('
    );
  }
}

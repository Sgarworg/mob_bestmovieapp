import 'package:flutter/material.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/utils/text.dart';

class Details extends StatelessWidget {
  final Map movies;

  const Details({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
          title: modified_text(
        text: 'Details',
        size: 30,
      )),
      body: Container(
        padding: const EdgeInsets.all(5),
       // color: Color.fromARGB(100, 1, 1, 1),
        child:SingleChildScrollView(
          //scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    child: modified_text(
                      text: movies['title'] != null ? movies['title'] : movies['name'] != null ? movies['name'] : 'loading' ,
                      size: 30,
                    )),
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                        //color: Colors.black54,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/w500' +
                              movies['poster_path']))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Container(

                        child: modified_text(
                          text:  movies['release_date'] != null ? 'Release: '+ movies['release_date'].toString()+ ' ' : '',
                          size: 18,
                        ),

                      ),
                        Container(
                            child: modified_text(
                              text: 'Votes: ' + movies['vote_average'].toString(),
                              size: 18,
                        )
                        ),
                        Container(
                          //child: modified_text(text: 'Cool Hier'),
                        )
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
                        text: movies['overview'] != null
                            ? movies['overview']
                            : 'keine Beschreibung verfügbar',
                        size: 24,
                      )
                  )
                  ,
                )

              ],
            )
        )
       ,
      ),

      // padding: EdgeInsets.all(30),
      // child: modified_text(text: movies['overview']!=null?movies['overview']:'nix da :('
    );
  }
}

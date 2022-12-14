import 'package:flutter/material.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/widgets/details.dart';
import 'package:mob_bestmovieapp/utils/replace.dart';

class VisualMedia extends StatelessWidget {
  final List visualmedia;
  final String string;

  const VisualMedia({Key? key, required this.visualmedia,required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: string,
            size: 26,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 270,
            child: ListView.builder(
              itemCount: visualmedia.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Details(movies: visualmedia[index])));
                  },
                  child: Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          width: 133,
                          height: 200,
                          child: replaceClass.replace(visualmedia[index]['poster_path']),),
                        Container(
                          child: modified_text(
                            text: visualmedia[index]['title'] != null
                                ? visualmedia[index]['title']
                                : visualmedia[index]['name'] != null
                                ? visualmedia[index]['name']
                                : 'No title found',
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class replaceClass {
  static Widget replace(String? path) {
    if (path == null) {
      return Container(
        width: 133,
        height: 200,
        child: Center(child: Icon(Icons.play_circle_filled_outlined),
        ),
      );
    } else {
      return Container(
        width: 133,
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(100, 100, 100, 100),
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            image: DecorationImage(
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500' + path
                )
            )
        ),
      );
    }
  }
}

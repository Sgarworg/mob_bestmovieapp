import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/widgets/trending.dart';

class Secret extends StatelessWidget {
  const Secret({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: modified_text(text:'Psssss')),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ElevatedButton(
          child: modified_text(text: 'back', color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

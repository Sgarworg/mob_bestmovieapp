import 'package:flutter/material.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/widgets/details.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  const TrendingMovies({Key? key,required this.trending}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(text: 'Trending Movies', size: 26,),
          SizedBox(height: 10),
          Container(height: 270,
          child: ListView.builder(itemCount: trending.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                print(trending[index]);
                Navigator.push(context, MaterialPageRoute(builder:(_)=> Details(movies: trending[index])));
              },
              child: Container(
                width: 140,
                child: Column(
                  children: [
                    Container(
                      width: 133,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(100, 100, 100, 100),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500'+trending[index]['poster_path']
                          )
                        )
                      ),
                    ),
                    Container(
                      child: modified_text(text: trending[index]['title']!=null?trending[index]['title']:'loading',),
                    )
                  ],
                ),
              ),
            );
          },),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mob_bestmovieapp/utils/text.dart';
import 'package:mob_bestmovieapp/widgets/details.dart';

class TopRatedTv extends StatelessWidget {
  final List toprated;
  const TopRatedTv({Key? key,required this.toprated}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(text: 'Top Rated Tv Series', size: 26,),
          SizedBox(height: 10,),
          Container(height: 270,
            child: ListView.builder(itemCount: toprated.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder:(_)=> Details(movies: toprated[index])));
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
                                      'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path']
                                  )
                              )
                          ),
                        ),
                        Container(
                          child: modified_text(text: toprated[index]['name']!=null?toprated[index]['name']:'loading',),
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

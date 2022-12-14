import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/text.dart';
import '../widgets/details.dart';
import 'package:mob_bestmovieapp/widgets/visualMedia.dart';

class MediaSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) =>
      [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, "okay"),
      );

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(

        future: getResult(query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  color: Colors.black45,
                  alignment: Alignment.center,
                  child: Text(
                    snapshot.error.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return buildResultsSuccess(snapshot.data!);
              }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Widget buildSuggestionsSuccess(suggestions) =>
      ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
            },
            leading: Icon(Icons.play_arrow_outlined),
            title: Text(suggestion),
          );
        },
      );

  Widget buildNoSuggestions() =>
      Center(
        child: Text("Nothing", style: TextStyle(color: Colors.white)),
      );

  Widget buildResultsSuccess(searchRes) {
    var movieRes = searchRes['movies'];
    var seriesRes = searchRes['series'];
    return SingleChildScrollView(child:
    Container(
        child: Column(
          children: [
            VisualMedia(visualmedia: movieRes, string: 'Movie Results',),
            VisualMedia(visualmedia: seriesRes, string: 'Serie Results',),
          ],
        )
    ));

  }

  Widget replace(String? path) {
    if (path == null) {
      return Container(
        width: 133,
        height: 200,
        child: Center(
          child: Icon(Icons.play_circle_filled_outlined),
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
                image: NetworkImage('https://image.tmdb.org/t/p/w500' + path))),
      );
    }
  }
}

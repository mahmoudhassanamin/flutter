import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List movies = [];

  Future<void> fetchMovies(String sort) async {
    var url = Uri.parse('http://image.tmdb.org/t/p/w500');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        movies = data['results'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovies('popular');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        itemCount: movies.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(movie: movies[index]),
                ),
              );
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      'http://image.tmdb.org/t/p/w500${movies[index]['poster_path']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(movies[index]['title']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

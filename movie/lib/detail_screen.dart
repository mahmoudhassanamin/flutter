import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
                'http://image.tmdb.org/t/p/w500${movie['poster_path']}'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(movie['overview']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('User Rating: ${movie['vote_average']}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Release Date: ${movie['release_date']}'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late String result;
  late HttpHelper helper;
  late int moviesCount = 0;
  late List movies = List.from([]);
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Movies');

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage? image;
    return Scaffold(
        appBar: AppBar(title: searchBar, actions: <Widget>[
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = const Icon(Icons.cancel);
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (String text) {
                      search(text);
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  );
                } else {
                  setState(() {
                    visibleIcon = const Icon(Icons.search);
                    searchBar = const Text('Movies');
                  });
                }
              });
            },
          ),
        ]),
        body: ListView.builder(
            itemCount: (moviesCount == null) ? 0 : moviesCount,
            itemBuilder: (BuildContext context, int position) {
              // if (movies[position].posterPath != null
              //     ? movies[position].posterPath!
              //     : '') {
              //   image = NetworkImage(iconBase + movies[position].posterPath);
              // } else {
              //   image = NetworkImage(defaultImage);
              // }
              if (position < movies.length) {
                final movie = movies[position];

                if (movie.posterPath != null) {
                  image = NetworkImage(iconBase + movie.posterPath);
                } else {
                  image = NetworkImage(defaultImage);
                }
              }
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => MovieDetail(movies[position]));
                      Navigator.push(context, route);
                    },
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(movies[position].title ?? 'No Title'),
                    subtitle: Text(
                        '${'Released: ' + movies[position].releaseDate} - Vote: ${movies[position].voteAverage}'),
                  ));
            }));
  }

  Future search(text) async {
    final fetchedMoviess = await helper.findMovies(text);
    setState(() {
      movies = fetchedMoviess ?? [];
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future initialize() async {
    final fetchedMovies = await helper.getUpcoming();
    if (mounted) {
      setState(() {
        movies = fetchedMovies ?? [];
        moviesCount = movies.length;
        movies = movies;
      });
    }
  }
}

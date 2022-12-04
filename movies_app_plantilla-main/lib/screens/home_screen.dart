import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies.provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    //print(moviesProvider.onDisplayMovies);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartellera'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate:
                        CustomSearchDelegate(moviesProvider.onDisplayMovies));
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              // Slider de pel·licules
              MovieSlider(populars: moviesProvider.onPopularMovies),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Movie> peliculas;
  CustomSearchDelegate(this.peliculas);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        print(value);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> busqueda = [];

    for (int i = 0; i < peliculas.length; i++) {
      busqueda.add(peliculas[i].title);
    }
    List<String> sugerencias = busqueda.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: sugerencias.length,
        itemBuilder: (context, index) {
          final sugerencia = sugerencias[index];

          return ListTile(
            title: Text(sugerencia),
            onTap: () {
              query = sugerencia;
              for (int i = 0; i < peliculas.length; i++) {
                if (peliculas[i].title == query) {
                  Movie peli = peliculas[i];
                  Navigator.pushNamed(context, 'details', arguments: peli);
                }
              }
              query = '';
            },
          );
        });
  }
}

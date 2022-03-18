import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';
import 'package:pokedex/routes/names_routes.dart';

class PokedexView extends StatelessWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonSimpleListLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonSimpleListLoadSuccess) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: "Buscar por nombre",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.black,
                          size: 24.0,
                        ),
                        tooltip: 'Filtar',
                        onPressed: () {
                          Navigator.pushNamed(context, NamesRoutes.filter);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridPokemons(
                    state: state,
                    context: context,
                  ),
                ),
              ],
            );
          } else if (state is PokemonSimpleListLoadFailed) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class GridPokemons extends StatelessWidget {
  const GridPokemons({
    Key? key,
    required this.context,
    required this.state,
  }) : super(key: key);

  final PokemonSimpleListLoadSuccess state;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: state.pokemonListings.length,
        itemBuilder: (context, index) {
          return Card(
            child: GridTile(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, NamesRoutes.description);
                  },
                  child: Column(
                    children: [
                      Image.network(state.pokemonListings[index].imageUrl),
                      Text(state.pokemonListings[index].name)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

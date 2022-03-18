import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';
import 'package:pokedex/routes/names_routes.dart';
import 'package:pokedex/utils/constants.dart';

class PokedexView extends HookWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<PokemonBloc>().add(PokemonSimpleListResquest(page: 0));
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          print({
            'pokemonSimpleListStatus': state.pokemonSimpleListStatus.toString()
          });

          print({
            'pokemonCompleteStatus': state.pokemonCompleteStatus.toString()
          });

          print({'pokemonComplete': state.pokemonComplete.toString()});

          print({'pokemonSimpleList': state.pokemonSimpleList.toString()});

          if (state.pokemonSimpleListStatus == RequestStatus.loadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.pokemonSimpleListStatus ==
              RequestStatus.loadSuccess) {
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
          } else if (state.pokemonSimpleListStatus ==
              RequestStatus.loadFailed) {
            return Center(
              child: Text(state.errorPokemonSimpleList.toString()),
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

  final PokemonState state;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: state.pokemonSimpleList!.length,
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
                      Image.network(state.pokemonSimpleList![index].imageUrl),
                      Text(state.pokemonSimpleList![index].name)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

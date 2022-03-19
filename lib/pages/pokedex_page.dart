import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';
import 'package:pokedex/models/pokemon/pokemon_simple_model.dart';
import 'package:pokedex/routes/names_routes.dart';
import 'package:pokedex/utils/constants.dart';

class PokedexPage extends HookWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController =
        useTextEditingController(text: "");

    useEffect(() {
      context.read<PokemonBloc>().add(PokemonSimpleListResquest(page: 0));
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state.pokemonSimpleListStatus == RequestStatus.loadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.pokemonSimpleListStatus ==
              RequestStatus.loadSuccess) {
            return HookBuilder(builder: (context) {
              final ValueNotifier<List<PokemonSimple>> pokemonList =
                  useState(state.pokemonSimpleList!);
              final ValueNotifier<bool> filterByFavorite = useState(false);

              filterPokemons() {
                pokemonList.value = state.pokemonSimpleList!.where((pokemon) {
                  if (searchController.value.text == "") {
                    if (filterByFavorite.value) {
                      return state.favoritePokemons!.contains(pokemon.id);
                    } else {
                      return true;
                    }
                  } else {
                    if (filterByFavorite.value) {
                      return state.favoritePokemons!.contains(pokemon.id) &&
                          pokemon.name.startsWith(searchController.value.text);
                    } else {
                      return pokemon.name
                          .startsWith(searchController.value.text);
                    }
                  }
                }).toList();
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            onChanged: (_) {
                              filterPokemons();
                            },
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
                          icon: Icon(
                            filterByFavorite.value
                                ? const IconData(0xecf3,
                                    fontFamily: 'MaterialIcons')
                                : const IconData(0xecf2,
                                    fontFamily: 'MaterialIcons'),
                            color: Colors.black,
                            size: 24.0,
                          ),
                          tooltip: 'Filtar',
                          onPressed: () {
                            filterByFavorite.value = !filterByFavorite.value;

                            filterPokemons();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridPokemons(
                      pokemonList: pokemonList.value,
                      favoritePokemons: state.favoritePokemons!,
                    ),
                  ),
                ],
              );
            });
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
    required this.pokemonList,
    required this.favoritePokemons,
  }) : super(key: key);

  final List<PokemonSimple> pokemonList;
  final List<int> favoritePokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          return Card(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NamesRoutes.description +
                      "/" +
                      pokemonList[index].id.toString(),
                );
              },
              child: GridTile(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (favoritePokemons
                                  .contains(pokemonList[index].id)) {
                                context.read<PokemonBloc>().add(
                                    RemoveFavoritePokemon(
                                        id: pokemonList[index].id));
                              } else {
                                context.read<PokemonBloc>().add(
                                    AddFavoritePokemon(
                                        id: pokemonList[index].id));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                favoritePokemons.contains(pokemonList[index].id)
                                    ? const IconData(0xecf3,
                                        fontFamily: 'MaterialIcons')
                                    : const IconData(0xecf2,
                                        fontFamily: 'MaterialIcons'),
                                color: Colors.black,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.network(pokemonList[index].imageUrl),
                      Text(pokemonList[index].name)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

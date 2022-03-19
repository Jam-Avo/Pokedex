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
                              if (searchController.value.text != "") {
                                pokemonList.value = state.pokemonSimpleList!
                                    .where((pokemon) => pokemon.name.startsWith(
                                        searchController.value.text))
                                    .toList();
                              } else {
                                pokemonList.value = state.pokemonSimpleList!;
                              }
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
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridPokemons(
                      pokemonList: pokemonList.value,
                      context: context,
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
    required this.context,
    required this.pokemonList,
  }) : super(key: key);

  final List<PokemonSimple> pokemonList;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          return Card(
            child: GridTile(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NamesRoutes.description +
                          "/" +
                          pokemonList[index].id.toString(),
                    );
                  },
                  child: Column(
                    children: [
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

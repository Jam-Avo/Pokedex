import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRespository = PokemonRepository();

  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonPageResquest>((event, emit) async {
      await _pokemonRespository
          .getPokemonSimpleList(event.page)
          .then((pokemonResponse) {
        emit(PokemonPageLoadSuccess(
            pokemonListings: pokemonResponse.pokemonSimpleList,
            canLoadNextPage: pokemonResponse.canLoadNexPage));
      }).catchError((e) {
        emit(PokemonPageLoadFailed(error: e));
      });
    });
  }
}

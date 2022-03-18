import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRespository = PokemonRepository();

  PokemonBloc() : super(PokemonSimpleListInitial()) {
    on<PokemonSimpleListResquest>((event, emit) async {
      await _pokemonRespository
          .getPokemonSimpleList(pageIndex: event.page)
          .then((pokemonSimpleListResponse) {
        emit(
          PokemonSimpleListLoadSuccess(
            pokemonListings: pokemonSimpleListResponse.pokemonSimpleList,
            canLoadNextPage: pokemonSimpleListResponse.canLoadNexPage,
          ),
        );
      }).catchError((e) {
        emit(PokemonSimpleListLoadFailed(error: e));
      });
    });
    on<PokemonCompleteResquest>((event, emit) async {
      await _pokemonRespository
          .getPokemonComplete(id: event.id)
          .then((pokemonCompleteResponse) {
        emit(
          PokemonCompleteLoadSuccess(
            pokemonComplete: pokemonCompleteResponse,
          ),
        );
      }).catchError((e) {
        emit(PokemonCompleteLoadFailed(error: e));
      });
    });
  }
}

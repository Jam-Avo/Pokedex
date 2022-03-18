import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon_state.dart';
import 'package:pokedex/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRespository = PokemonRepository();

  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonPageResquest>((event, emit) async {
      await _pokemonRespository
          .getPokemonPage(event.page)
          .then((pokemonResponse) {
        emit(PokemonPageLoadSuccess(
            pokemonListings: pokemonResponse.pokemonListing,
            canLoadNextPage: pokemonResponse.canLoadNexPage));
      }).catchError((e) {
        emit(PokemonPageLoadFailed(error: e));
      });
    });
  }
}

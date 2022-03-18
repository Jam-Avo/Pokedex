import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon/pokemon_simple_model.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final List<PokemonSimple> pokemonListings;
  final bool canLoadNextPage;

  PokemonPageLoadSuccess(
      {required this.pokemonListings, required this.canLoadNextPage});
}

class PokemonPageLoadFailed extends PokemonState {
  final DioError error;

  PokemonPageLoadFailed({required this.error});
}

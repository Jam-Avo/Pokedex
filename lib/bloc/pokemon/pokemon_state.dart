import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon/pokemon_complete_model.dart';
import 'package:pokedex/models/pokemon/pokemon_simple_model.dart';

abstract class PokemonState {}

class PokemonSimpleListInitial extends PokemonState {}

class PokemonSimpleListLoadInProgress extends PokemonState {}

class PokemonSimpleListLoadSuccess extends PokemonState {
  final List<PokemonSimple> pokemonListings;
  final bool canLoadNextPage;

  PokemonSimpleListLoadSuccess(
      {required this.pokemonListings, required this.canLoadNextPage});
}

class PokemonSimpleListLoadFailed extends PokemonState {
  final DioError error;

  PokemonSimpleListLoadFailed({required this.error});
}

class PokemonCompleteInitial extends PokemonState {}

class PokemonCompleteLoadInProgress extends PokemonState {}

class PokemonCompleteLoadSuccess extends PokemonState {
  final PokemonComplete pokemonComplete;

  PokemonCompleteLoadSuccess({required this.pokemonComplete});
}

class PokemonCompleteLoadFailed extends PokemonState {
  final DioError error;

  PokemonCompleteLoadFailed({required this.error});
}

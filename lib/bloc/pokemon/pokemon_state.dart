import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/models/pokemon/pokemon_complete_model.dart';
import 'package:pokedex/models/pokemon/pokemon_simple_model.dart';
import 'package:pokedex/utils/constants.dart';

class PokemonState extends Equatable {
  final List<PokemonSimple>? pokemonSimpleList;
  final bool? canLoadNextPage;
  final PokemonComplete? pokemonComplete;
  final RequestStatus pokemonSimpleListStatus;
  final RequestStatus pokemonCompleteStatus;
  final DioError? errorPokemonSimpleList;
  final DioError? errorPokemonComplete;

  const PokemonState({
    this.pokemonSimpleList,
    this.canLoadNextPage,
    this.pokemonComplete,
    this.pokemonSimpleListStatus = RequestStatus.initial,
    this.pokemonCompleteStatus = RequestStatus.initial,
    this.errorPokemonSimpleList,
    this.errorPokemonComplete,
  });

  PokemonState cleanState({
    bool pokemonSimpleList = false,
    bool canLoadNextPage = false,
    bool pokemonComplete = false,
    bool pokemonSimpleListStatus = false,
    bool pokemonCompleteStatus = false,
    bool errorPokemonSimpleList = false,
    bool errorPokemonComplete = false,
  }) {
    return PokemonState(
      pokemonSimpleList: pokemonSimpleList ? null : this.pokemonSimpleList,
      canLoadNextPage: canLoadNextPage ? null : this.canLoadNextPage,
      pokemonComplete: pokemonComplete ? null : this.pokemonComplete,
      pokemonSimpleListStatus: pokemonSimpleListStatus
          ? RequestStatus.initial
          : this.pokemonSimpleListStatus,
      pokemonCompleteStatus: pokemonCompleteStatus
          ? RequestStatus.initial
          : this.pokemonCompleteStatus,
      errorPokemonSimpleList:
          errorPokemonSimpleList ? null : this.errorPokemonSimpleList,
      errorPokemonComplete:
          errorPokemonComplete ? null : this.errorPokemonComplete,
    );
  }

  PokemonState copyWith({
    List<PokemonSimple>? pokemonSimpleList,
    bool? canLoadNextPage,
    PokemonComplete? pokemonComplete,
    RequestStatus? pokemonSimpleListStatus,
    RequestStatus? pokemonCompleteStatus,
    DioError? errorPokemonSimpleList,
    DioError? errorPokemonComplete,
  }) {
    return PokemonState(
      pokemonSimpleList: pokemonSimpleList ?? this.pokemonSimpleList,
      canLoadNextPage: canLoadNextPage ?? this.canLoadNextPage,
      pokemonComplete: pokemonComplete ?? this.pokemonComplete,
      pokemonSimpleListStatus:
          pokemonSimpleListStatus ?? this.pokemonSimpleListStatus,
      pokemonCompleteStatus:
          pokemonCompleteStatus ?? this.pokemonCompleteStatus,
      errorPokemonSimpleList:
          errorPokemonSimpleList ?? this.errorPokemonSimpleList,
      errorPokemonComplete: errorPokemonComplete ?? this.errorPokemonComplete,
    );
  }

  @override
  List<Object?> get props => [
        pokemonSimpleList,
        canLoadNextPage,
        pokemonComplete,
        pokemonSimpleListStatus,
        pokemonCompleteStatus,
        errorPokemonSimpleList,
        errorPokemonComplete
      ];
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon_state.dart';
import 'package:pokedex/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRespository = PokemonRepository();

  PokemonBloc() : super(PokemonInitial());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
   if (event is PokemonPageResquest) {
     yield PokemonLoadInProgress();

     try {
      final pokemonPageResponse = 
          await _pokemonRespository.getPokemonPage(event.page);
      yield PokemonPageLoadSuccess(
        pokemonListings: pokemonPageResponse.pokemonListing, 
        canLoadNextPage: pokemonPageResponse.canLoadNexPage);
     } catch(e) {
       yield PokemonPageLoadFailed(error: e);
     } 

   }
  }
}
  
  
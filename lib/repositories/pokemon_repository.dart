import 'package:pokedex/api/pokemon_api.dart';
import 'package:pokedex/models/pokemon/pokemon_simple_list_model.dart';

class PokemonRepository {
  Future<PokemonSimpleList> getPokemonSimpleList(int pageIndex) async {
    return PokemonApi().getPokemonSimpleList(pageIndex: pageIndex);
  }
}

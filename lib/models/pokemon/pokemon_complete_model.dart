import 'package:pokedex/models/pokemon/pokemon_model.dart';

class PokemonComplete extends Pokemon {
  PokemonComplete({required int id, required String name})
      : super(id: id, name: name);

  factory PokemonComplete.fromJson(Map<String, dynamic> json) {
    return PokemonComplete(id: json['id'], name: json['name']);
  }
}

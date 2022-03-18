abstract class PokemonEvent {}

class PokemonSimpleListResquest extends PokemonEvent {
  final int page;

  PokemonSimpleListResquest({required this.page});
}

class PokemonCompleteResquest extends PokemonEvent {
  final int id;

  PokemonCompleteResquest({required this.id});
}

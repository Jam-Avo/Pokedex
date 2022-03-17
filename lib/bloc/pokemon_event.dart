abstract class PokemonEvent {}

class PokemonPageResquest extends PokemonEvent {
  final int page;

  PokemonPageResquest({required this.page});
}

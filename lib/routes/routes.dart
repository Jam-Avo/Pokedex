import 'package:flutter/material.dart';
import 'package:pokedex/pages/description_pokemon_page.dart';
import 'package:pokedex/pages/filter_page.dart';
import 'package:pokedex/pages/no_found_page.dart';
import 'package:pokedex/pages/pokedex_page.dart';
import 'package:pokedex/routes/names_routes.dart';

MaterialPageRoute onGenerateRoute(settings) {
  late Widget page;

  page = const NoFoundPage();

  switch (settings.name) {
    case NamesRoutes.home:
      page = const PokedexPage();
      break;
    case NamesRoutes.filter:
      page = const FilterPage();
      break;
  }

  if (settings.name!.startsWith(NamesRoutes.description)) {
    final subRoute =
        settings.name!.substring(NamesRoutes.description.length + 1);
    page = DescriptionPokemonPage(
      pokemonId: int.parse(subRoute),
    );
  }

  return MaterialPageRoute(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}

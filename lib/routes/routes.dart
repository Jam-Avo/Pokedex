import 'package:flutter/material.dart';
import 'package:pokedex/pages/description_pokemon_page.dart';
import 'package:pokedex/pages/filter_page.dart';
import 'package:pokedex/pages/pokedex_view.dart';
import 'package:pokedex/routes/names_routes.dart';

var routes = <String, WidgetBuilder>{
  NamesRoutes.description: (context) => const DescriptionPokemonPage(),
  NamesRoutes.filter: (context) => const FilterPage(),
  NamesRoutes.home: (context) => const PokedexView(),
};

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/pages/pokedex_view.dart';
import 'package:pokedex/routes/routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _pokemonBloc = PokemonBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonBloc>(
          create: (BuildContext context) => _pokemonBloc,
        )
      ],
      child: MaterialApp(
        theme: Theme.of(context).copyWith(
          primaryColor: Colors.red,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.redAccent),
        ),
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: const PokedexView(),
      ),
    );
  }
}

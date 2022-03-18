import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/pages/pokedex_view.dart';
import 'package:pokedex/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        primaryColor: Colors.red,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.redAccent),
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PokemonBloc>(
            create: (context) =>
                //TODO: No se debe hacer aca la request
                PokemonBloc()..add(PokemonSimpleListResquest(page: 0)),
          )
        ],
        child: const PokedexView(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';

// class DescriptionPokemonPage extends HookWidget {
//   const DescriptionPokemonPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     PokemonBloc _pokemonBloc = BlocProvider.of<PokemonBloc>(context);
//     useEffect(() {
//       _pokemonBloc.add(PokemonCompleteResquest(id: 201));
//       return null;
//     }, []);

//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocBuilder<PokemonBloc, PokemonState>(
//         builder: (context, state) {
//           if (state is PokemonCompleteLoadSuccess) {
//             return Column(
//               children: [
//                 Text(state.pokemonComplete.name.toString()),
//               ],
//             );
//           }
//           return Column(
//             children: const [
//               Text('state'),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

class DescriptionPokemonPage extends StatelessWidget {
  const DescriptionPokemonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text("Description"),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';
import 'package:pokedex/utils/constants.dart';

class DescriptionPokemonPage extends HookWidget {
  const DescriptionPokemonPage({Key? key, required this.pokemonId})
      : super(key: key);

  final int pokemonId;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    useEffect(() {
      context.read<PokemonBloc>().add(PokemonCompleteResquest(id: pokemonId));
      return null;
    });

    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state.pokemonCompleteStatus == RequestStatus.loadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.pokemonCompleteStatus == RequestStatus.loadSuccess) {
            var typesPokemon =
                state.pokemonComplete!.types.map((type) => type.type.name);
            return Stack(
              alignment: Alignment.center,
              children: [
                const Positioned(
                  top: 20,
                  left: 10,
                  child: BackButton(),
                ),
                Positioned(
                  top: 70,
                  left: 20,
                  right: 20,
                  child: NamePokemon(name: state.pokemonComplete!.name),
                ),
                Positioned(
                  top: 110,
                  left: 22,
                  child: TypesPokemon(typesPokemon: typesPokemon),
                ),
                Positioned(
                  top: height * 0.18,
                  right: -30,
                  child: const ImagePokeballBackground(),
                ),
                Positioned(
                  bottom: 0,
                  child: InfoPokemon(
                    weightPokemon: state.pokemonComplete!.weight,
                    heightPokemon: state.pokemonComplete!.height,
                  ),
                ),
                Positioned(
                  top: (height * 0.2),
                  left: (width / 2) - 100,
                  child: Hero(
                    tag: 1,
                    child: ImagePokemon(
                      imageUrlPokemon:
                          state.pokemonComplete!.sprite.frontDefault,
                    ),
                  ),
                )
              ],
            );
          } else if (state.pokemonCompleteStatus == RequestStatus.loadFailed) {
            return Center(
              child: Text(state.errorPokemonSimpleList.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

//Widgets DescriptionPokemonPage
class ImagePokemon extends StatelessWidget {
  const ImagePokemon({
    Key? key,
    required this.imageUrlPokemon,
  }) : super(key: key);

  final String imageUrlPokemon;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 200,
      width: 200,
      imageUrl: imageUrlPokemon,
      fit: BoxFit.cover,
    );
  }
}

class InfoPokemon extends StatelessWidget {
  const InfoPokemon({
    Key? key,
    required this.weightPokemon,
    required this.heightPokemon,
  }) : super(key: key);

  final int weightPokemon;
  final int heightPokemon;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.6,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            RowDescription(
              textLeft: 'Height',
              textRigth: (heightPokemon / 10).toString() + " m",
            ),
            RowDescription(
              textLeft: 'Weight',
              textRigth: (weightPokemon / 10).toString() + " kg",
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePokeballBackground extends StatelessWidget {
  const ImagePokeballBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pokeball.png',
      height: 200,
      fit: BoxFit.fitHeight,
    );
  }
}

class TypesPokemon extends StatelessWidget {
  const TypesPokemon({
    Key? key,
    required this.typesPokemon,
  }) : super(key: key);

  final Iterable<String> typesPokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          typesPokemon.join(", "),
          style: const TextStyle(color: Colors.white, fontSize: 15),
          textAlign: TextAlign.left,
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    );
  }
}

class NamePokemon extends StatelessWidget {
  const NamePokemon({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}

class RowDescription extends StatelessWidget {
  const RowDescription(
      {Key? key, required this.textLeft, required this.textRigth})
      : super(key: key);

  final String textLeft;
  final String textRigth;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              textLeft,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 17),
            ),
          ),
          Text(
            textRigth,
            style: const TextStyle(color: Colors.black, fontSize: 17),
          ),
        ],
      ),
    );
  }
}



//   Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       children: [
//         SizedBox(
//           width: width * 0.3,
//           child: const Text('Pre Evolution', style: TextStyle(color: Colors.blueGrey, fontSize: 17),),
//         ),
//         Container(
//             child: widget.pokemonDescription['prev_evolution'] != null ?
//             SizedBox(
//               height: 20,
//               width: width * 0.55,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: widget.pokemonDescription['prev_evolution'].length,
//                 itemBuilder: (context, index){
//                   return Padding(
//                     padding: const EdgeInsets.only(left:8.0),
//                     child: Text(widget.pokemonDescription['prev_evolution'][index]['name'], style: const TextStyle(color: Colors.black, fontSize: 17),),
//                   );
//                 },
//               ),
//             ): const Text("Just Hatched", style: TextStyle(color: Colors.black, fontSize: 17),)
//         ),

//       ],
//     ),
//   ),

//   Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       children: [
//         SizedBox(
//           width: width * 0.3,
//           child: const Text('Next Evolution', style: TextStyle(color: Colors.blueGrey, fontSize: 17),),
//         ),
//         Container(
//           child: widget.pokemonDescription['next_evolution'] != null ?
//               SizedBox(
//                 height: 20,
//                 width: width * 0.55,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: widget.pokemonDescription['next_evolution'].length,
//                   itemBuilder: (context, index){
//                     return Padding(
//                       padding: const EdgeInsets.only(right:8.0),
//                       child: Text(widget.pokemonDescription['next_evolution'][index]['name'], style: const TextStyle(color: Colors.black, fontSize: 17),),
//                     );
//                   },
//                 ),
//               ): const Text("Maxed Out", style: TextStyle(color: Colors.black, fontSize: 17),)
//         ),

//       ],
//     ),
//   ),
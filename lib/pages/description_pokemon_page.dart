import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokedex/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon/pokemon_state.dart';
import 'package:pokedex/components/row_description.dart';

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

class DescriptionPokemonPage extends StatefulWidget {




  const DescriptionPokemonPage({Key? key}) : super(key: key);
 // const DescriptionPokemonPage({Key? key}) : super(key: key);

  @override
  _DescriptionPokemonPageState createState() => _DescriptionPokemonPageState();
}

class _DescriptionPokemonPageState extends State<DescriptionPokemonPage> {

 
  @override
  Widget build(BuildContext context) {



    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;



    return Scaffold(
      appBar: AppBar(),
     // body: const Text("Description"),



       backgroundColor: Colors.amber,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            left: 5,
            child: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20,), onPressed: (){
                Navigator.pop(context);
            }),
          ),

          Positioned(
            top: 70,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Nombre",style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                  Text("Description",style: TextStyle(color: Colors.white, fontSize: 20, ), textAlign: TextAlign.left,),


                ],
              )
          ),

          Positioned(
              top: 110,
              left: 22,
              child: Container(child: 
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("texto1",style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.left,),
              ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
              
              )
          ),

           Positioned(
            top: height * 0.18,
            right: -30,
            child: Image.asset('images/pokeball.png',
            height: 200,
            fit: BoxFit.fitHeight,

            ),

          ),

          Positioned(
            bottom: 0,
            child: Container(

              width: width,
              height: height * 0.6,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                color: Colors.white
              ),

              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(

                  children: const [
                    SizedBox(height: 50,),
                    
                    RowDescription(textLeft: 'Name', textRigth: 'texto2',),
                    RowDescription(textLeft: 'Height', textRigth: 'texto3',),
                    RowDescription(textLeft: 'Weight', textRigth: 'texto4',),
                    RowDescription(textLeft: 'SpawnTime', textRigth: 'texto5',),
                    RowDescription(textLeft: 'Weakness', textRigth: 'texto6',),

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
                   ],
                ),
              ),
            ),
          ),

          Positioned(
            top: (height * 0.2),
            left: (width / 2) - 100,
            child: Hero(
              tag: 1,
              child: CachedNetworkImage(
                height: 200,
                width: 200,
                imageUrl: 'https://assets.stickpng.com/images/580b57fcd9996e24bc43c325.png',
                fit: BoxFit.cover,

              ),
            ),
          )
        ],
      ),



      
  
  
    );
  }
}

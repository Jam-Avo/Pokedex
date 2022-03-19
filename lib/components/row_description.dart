import 'package:flutter/material.dart';

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

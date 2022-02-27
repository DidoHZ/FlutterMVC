import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.filter_drama_outlined,size: 50,color: ThemeData.light().primaryColor,),
        const Text(
          "No Connection",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        )
      ],
    );
  }
}
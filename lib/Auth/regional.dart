import 'package:flutter/material.dart';

class Regiuonal extends StatefulWidget {
  const Regiuonal({super.key});

  @override
  State<Regiuonal> createState() => _RegiuonalState();
}

class _RegiuonalState extends State<Regiuonal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("rewgionalnsn",style: TextStyle(
          fontSize: 30,
          color: Colors.black
        ),)
      ],),
    );
  }
}

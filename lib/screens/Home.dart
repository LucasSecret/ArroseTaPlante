import 'package:arrose_ta_plante/builder/CardBuilder.dart';
import 'package:arrose_ta_plante/screens/SearchPlant.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Arrose ta plante"),
          centerTitle: true,
          backgroundColor: Colors.grey.shade200,
        ),
        body: FlowersGridList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const SearchPlantScreen())
            );
          },
          child: Icon(Icons.add, color: Colors.white,),
          shape: CircleBorder(),
        ),
      )
    );
  }
}

class FlowersGridList extends StatefulWidget {
  final List<String> imagesNames = [
    "assets/images/53.jpg",
    "assets/images/Untitled.jpg",
    "assets/images/anemone.jpg"
  ];
  
  FlowersGridList ({super.key});
  

  @override
  State<FlowersGridList> createState() => _FlowersGridListState();
}

class _FlowersGridListState extends State<FlowersGridList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: widget.imagesNames.length,
      itemBuilder: (BuildContext context, int index) => BuildImageCard(context, index, widget.imagesNames[index])
    );
  }
}



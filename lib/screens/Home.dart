import 'package:arrose_ta_plante/screens/SearchFlowers.dart';
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
              MaterialPageRoute(builder: (context) => const SearchFlowerScreen())
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

Widget BuildImageCard(BuildContext context, int index, String imageName) => Card(
  margin: EdgeInsets.all(4),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Expanded(
        child: Container(
          margin : EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage(imageName),
                  fit: BoxFit.cover
                )
              ),
            )
          )
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        alignment: Alignment.center,
        child: Text("Nom de la plante"),
      )
    ]
  )
);

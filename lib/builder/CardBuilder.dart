import 'package:arrose_ta_plante/Plant.dart';
import 'package:flutter/material.dart';


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








Widget BuildPlantCard(BuildContext context, int index, Plant plant) => Card(
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
                  image: plant.imageUrl == null ? NetworkImage("")  : NetworkImage(plant.imageUrl.toString()),
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
        child: Text(plant.scientificName == null ? "No name found" : plant.scientificName.toString()),
      )
    ]
  )
);
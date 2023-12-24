import 'package:arrose_ta_plante/Plant.dart';
import 'package:arrose_ta_plante/builder/CardBuilder.dart';
import 'package:arrose_ta_plante/utility/ApiProvider.dart';
import 'package:arrose_ta_plante/utility/Debouncer.dart';
import 'package:flutter/material.dart';

class SearchPlantScreen extends StatefulWidget {
  const SearchPlantScreen({super.key});

  @override
  State<SearchPlantScreen> createState() => _SearchPlantScreenState();
}

class _SearchPlantScreenState extends State<SearchPlantScreen> {
  List allPlants = [];
  List queryPlants = [];
  var plantsToDisplay = [];
  var searchHistory = [];
  var trefleToken = "";
  var apiProvider = ApiProvider();
  late Future<List> searchPlantResponse;
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  final TextEditingController searchController = TextEditingController();

  void search(String query)
  {
    if(query.isEmpty){
      setState(() {
        plantsToDisplay = allPlants;
      }); 
    }
    else{
      searchPlantsFromApi(query);
      setState(() {
        plantsToDisplay = [];
      });
    }
  }


  void fetchAllPlantsFromApi() async {
    searchPlantResponse = apiProvider.fetchPlants(1);
    searchPlantResponse.then((value) => (allPlants = plantsToDisplay = value));
  }

  void searchPlantsFromApi(String query) async {
    searchPlantResponse = apiProvider.searchPlants(1, query);
    searchPlantResponse.then((value) => (queryPlants = plantsToDisplay = value));
  }

  @override
  void initState() {
    super.initState();
    apiProvider.Init();
    fetchAllPlantsFromApi();
  }



  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search plant...",
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  search(searchController.text);
                },
              ),
            ),
            onFieldSubmitted: (value) {
              search(value);
            },
            onChanged: (value) {
              _debouncer.run(() {
                search(value);
              });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: FutureBuilder<List>(
            future: searchPlantResponse,
            builder: (context, snapshot) {
              var isReady = snapshot.hasData && snapshot.connectionState == ConnectionState.done;
              if(isReady){
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: plantsToDisplay.length,
                        itemBuilder: (BuildContext context, int index) => BuildPlantCard(context, index, plantsToDisplay[index])
                      ),
                    )
                  ],
                );
              }

              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error?.toString()}", style: const TextStyle(color: Colors.red));
              }

              return const CircularProgressIndicator();
            },
          ) 
        ),
      ),
    );
  }
}





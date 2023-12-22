import 'package:flutter/material.dart';


class SearchFlowerScreen extends StatefulWidget {
  const SearchFlowerScreen({super.key});

  @override
  State<SearchFlowerScreen> createState() => _SearchFlowerScreenState();
}

class _SearchFlowerScreenState extends State<SearchFlowerScreen> {
  var allItems = List.generate(50, (index) => 'Item$index');
  var items = [];
  var searchHistory = [];

  final TextEditingController searchController = TextEditingController();

  void search(String query)
  {
    if(query.isEmpty){
      setState(() {
        items = allItems;
      }); 
    }
    else{
      setState(() {
        items = allItems.where((element) => element.toLowerCase() == query.toLowerCase()).toList();
      });
    }
  }

  void queryListener(){
    search(searchController.text);
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trouve ta plante !'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16,),
              SearchBar(
                controller: searchController,
                hintText: 'Nom de ta plante...',
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){},
                ),
                trailing: [IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: (){},
                )],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.isEmpty ? allItems.length : items.length,
                  itemBuilder: (context, index){
                    final item = items.isEmpty ? allItems[index] : items[index];
                    return Card(
                      child: Column(
                        children: [
                          Text('Name : $item'),
                          const SizedBox(height: 8),
                          Text(item),
                        ],
                      )
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
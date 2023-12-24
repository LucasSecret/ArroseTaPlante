

class Plant{
  int id;
  String? commonName;
  String? scientificName;
  String? imageUrl;

  Plant({
    required this.id,
    this.commonName,
    this.scientificName,
    this.imageUrl
  });

  factory Plant.fromJson(Map<String, dynamic> json){
    return Plant(
      id: json["id"],
      commonName: json["common_name"],
      scientificName: json["scientific_name"],
      imageUrl: json["image_url"]
    );
  }

}
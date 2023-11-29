class DataModel {
  String name;
  String img;
  int price;
  int people;
  int stars;
  String description;
  String location;
  
  DataModel({
    required this.name,
    required this.img,
    required this.price,
    required this.people, 
    required this.stars,
    required this.description,
    required this.location
  });

  factory DataModel.toMap(Map<String,dynamic> data) {
    return DataModel(
      description: data["description"],
      img: data["img"],
      location: data["location"],
      name: data["name"],
      people: data["people"],
      price: data["price"],
      stars: data["stars"],
    );
  }
}
class Events{
  final int? id;
  final String? event_name;
  final String? description;
  final String? event_date;
  final String? image;
  Events({
    this.id,
    this.event_name,
    this.description,
    this.event_date,
    this.image,

  });
  factory Events.fromJson(Map<String,dynamic>json){
    return Events(
      id: json['id'],
      event_name: json["event_name"],
      description: json["description"],
      event_date: json['event_date'],
      image: json["image"],

    );
  }
  Map<String,dynamic>toJson()=>{
    "id":id,
    "event_name":event_name,
    "description":description,
    "event_date":event_date,
    "image":image,

  };
}
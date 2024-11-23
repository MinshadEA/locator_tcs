
import 'dart:convert';

TcsLocationModel tcsLocationModelFromJson(String str) => TcsLocationModel.fromJson(json.decode(str));

String tcsLocationModelToJson(TcsLocationModel data) => json.encode(data.toJson());

class TcsLocationModel {
  final Constants? constants;
  final List<Bound>? bounds;
  final List<Location>? locations;

  TcsLocationModel({
    this.constants,
    this.bounds,
    this.locations,
  });

  factory TcsLocationModel.fromJson(Map<String, dynamic> json) => TcsLocationModel(
    constants: json["constants"] == null ? null : Constants.fromJson(json["constants"]),
    bounds: json["bounds"] == null ? [] : List<Bound>.from(json["bounds"]!.map((x) => Bound.fromJson(x))),
    locations: json["locations"] == null ? [] : List<Location>.from(json["locations"]!.map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "constants": constants?.toJson(),
    "bounds": bounds == null ? [] : List<dynamic>.from(bounds!.map((x) => x.toJson())),
    "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x.toJson())),
  };
}

class Bound {
  final int? breakPoint;
  final int? zoom;
  final Bounds? bounds;
  final String? id;

  Bound({
    this.breakPoint,
    this.zoom,
    this.bounds,
    this.id,
  });

  factory Bound.fromJson(Map<String, dynamic> json) => Bound(
    breakPoint: json["breakPoint"],
    zoom: json["zoom"],
    bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "breakPoint": breakPoint,
    "zoom": zoom,
    "bounds": bounds?.toJson(),
    "id": id,
  };
}

class Bounds {
  final double? south;
  final double? west;
  final double? north;
  final double? east;

  Bounds({
    this.south,
    this.west,
    this.north,
    this.east,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    south: json["south"]?.toDouble(),
    west: json["west"]?.toDouble(),
    north: json["north"]?.toDouble(),
    east: json["east"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "south": south,
    "west": west,
    "north": north,
    "east": east,
  };
}

class Constants {
  final String? getDirection;
  final String? findOutMore;
  final String? contactUs;
  final String? mailUs;
  final String? defaultDropdownValue;

  Constants({
    this.getDirection,
    this.findOutMore,
    this.contactUs,
    this.mailUs,
    this.defaultDropdownValue,
  });

  factory Constants.fromJson(Map<String, dynamic> json) => Constants(
    getDirection: json["getDirection"],
    findOutMore:json["findOutMore"],
    contactUs: json["contactUs"],
    mailUs: json["mailUs"],
    defaultDropdownValue: json["defaultDropdownValue"],
  );

  Map<String, dynamic> toJson() => {
    "getDirection": getDirection,
    "findOutMore": findOutMore,
    "contactUs": contactUs,
    "mailUs": mailUs,
    "defaultDropdownValue": defaultDropdownValue,
  };
}



class Location {
  final String? area;
  final String? geo;
  final String? location;
  final List<String>? officeType;
  final List<dynamic>? additionalInfo;
  String? address;
  final String? phone;
  final Geometry? geometry;
  final String? email;
  final List<dynamic>? keywords;
  final List<Website>? websites;
  final String? id;
  final String? fax;
  String get fulllocation => '$geo - $area';
  String get officetype => officeType?.first??"";

  Location({
    this.area,
    this.geo,
    this.location,
    this.officeType,
    this.additionalInfo,
    this.address,
    this.phone,
    this.geometry,
    this.email,
    this.keywords,
    this.websites,
    this.id,
    this.fax,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    area: json["area"],
    geo: json["geo"],
    location: json["location"],
    officeType: json["officeType"] == null ? [] : List<String>.from(json["officeType"]!.map((x) => x)),
    additionalInfo: json["additionalInfo"] == null ? [] : List<dynamic>.from(json["additionalInfo"]!.map((x) => x)),
    address: json["address"],
    phone: json["phone"],
    geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    email: json["email"],
    keywords: json["keywords"] == null ? [] : List<dynamic>.from(json["keywords"]!.map((x) => x)),
    websites: json["websites"] == null ? [] : List<Website>.from(json["websites"]!.map((x) => Website.fromJson(x))),
    id: json["id"],
    fax: json["fax"],
  );

  Map<String, dynamic> toJson() => {
    "area":area,
    "geo": geo,
    "location": location,
    "officeType": officeType == null ? [] : List<dynamic>.from(officeType!.map((x) => x)),
    "additionalInfo": additionalInfo == null ? [] : List<dynamic>.from(additionalInfo!.map((x) => x)),
    "address": address,
    "phone": phone,
    "geometry": geometry?.toJson(),
    "email": email,
    "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
    "websites": websites == null ? [] : List<dynamic>.from(websites!.map((x) => x.toJson())),
    "id": id,
    "fax": fax,
  };
}





class Geometry {
  final double? lat;
  final double? lng;

  Geometry({
    this.lat,
    this.lng,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Website {
  final String? name;
  final String? url;

  Website({
    this.name,
    this.url,
  });

  factory Website.fromJson(Map<String, dynamic> json) => Website(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}



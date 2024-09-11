class HomeModel {
  String? result;
  String? message;
  int? status;
  Data? data;

  HomeModel({
    this.result,
    this.message,
    this.status,
    this.data,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Categories>? categories;
  List<Apartments>? apartments;
  List<ApartmentTypes>? apartmentTypes;

  Data({
    this.categories,
    this.apartments,
    this.apartmentTypes,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['apartments'] != null) {
      apartments = <Apartments>[];
      json['apartments'].forEach((v) {
        apartments!.add(Apartments.fromJson(v));
      });
    }
    if (json['apartment_types'] != null) {
      apartmentTypes = <ApartmentTypes>[];
      json['apartment_types'].forEach((v) {
        apartmentTypes!.add(ApartmentTypes.fromJson(v));
      });
    }
  }
}

class Categories {
  int? id;
  String? name;

  Categories({
    this.id,
    this.name,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Apartments {
  int? id;
  String? name;
  String? mainImage;

  Apartments({
    this.id,
    this.name,
    this.mainImage,
  });

  Apartments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainImage = json['main_image'];
  }
}

class ApartmentTypes {
  int? id;
  String? name;

  ApartmentTypes({
    this.id,
    this.name,
  });

  ApartmentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class CabType {
  int? id;
  String? cabtype;

  CabType({this.id, this.cabtype});

  CabType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cabtype = json['cab_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cab_type'] = cabtype;
    return data;
  }
}

class VehicleMaker {
  int? id;
  String? maker;

  VehicleMaker({this.id, this.maker});

  VehicleMaker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maker = json['maker'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['maker'] = maker;
    return data;
  }
}

class CabClass {
  int? id;
  int? cabtype;
  String? cabclass;

  CabClass({this.id, this.cabtype, this.cabclass});

  CabClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cabtype = json['cab_type'];
    cabclass = json['cab_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cab_type'] = cabtype;
    data['cab_class'] = cabclass;
    return data;
  }
}

class VehicleModel {
  int? id;
  int? maker;
  String? model;

  VehicleModel({this.id, this.maker, this.model});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maker = json['maker'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['maker'] = maker;
    data['model'] = model;
    return data;
  }
}

class VehicleInfoo {
  bool? isactive;
  String? numberplate;
  String? insurancecertiifcate;
  String? registrationcertiifcate;
  String? motcertiifcate;
  String? addtionaldocument;
  String? lastlocation;
  int? driver;
  int? maker;
  int? model;
  int? cabtype;
  int? cabclass;

  VehicleInfoo(
      {this.isactive,
      this.numberplate,
      this.insurancecertiifcate,
      this.registrationcertiifcate,
      this.motcertiifcate,
      this.addtionaldocument,
      this.lastlocation,
      this.driver,
      this.maker,
      this.model,
      this.cabtype,
      this.cabclass});

  VehicleInfoo.fromJson(Map<String, dynamic> json) {
    isactive = json['is_active'];
    numberplate = json['number_plate'];
    insurancecertiifcate = json['insurance_certiifcate'];
    registrationcertiifcate = json['registration_certiifcate'];
    motcertiifcate = json['mot_certiifcate'];
    addtionaldocument = json['addtional_document'];
    lastlocation = json['last_location'];
    driver = json['driver'];
    maker = json['maker'];
    model = json['model'];
    cabtype = json['cab_type'];
    cabclass = json['cab_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_active'] = isactive;
    data['number_plate'] = numberplate;
    data['insurance_certiifcate'] = insurancecertiifcate;
    data['registration_certiifcate'] = registrationcertiifcate;
    data['mot_certiifcate'] = motcertiifcate;
    data['addtional_document'] = addtionaldocument;
    data['last_location'] = lastlocation;
    data['driver'] = driver;
    data['maker'] = maker;
    data['model'] = model;
    data['cab_type'] = cabtype;
    data['cab_class'] = cabclass;
    return data;
  }
}

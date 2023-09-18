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
  String? lastlocation;
  int? driver;
  int? maker;
  int? model;
  int? cabtype;
  int? cabclass;
  String? front;
  String? back;
  String? right;
  String? left;
  String? insideDriverSeat;
  String? frontHeadLight;
  String? backHeadLight;
  String? insidePassangerSeat;

  VehicleInfoo({
    this.isactive,
    this.numberplate,
    this.lastlocation,
    this.driver,
    this.maker,
    this.model,
    this.cabtype,
    this.cabclass,
    this.back,
    this.front,
    this.right,
    this.left,
    this.insideDriverSeat,
    this.frontHeadLight,
    this.backHeadLight,
    this.insidePassangerSeat,
  });

  VehicleInfoo.fromJson(Map<String, dynamic> json) {
    isactive = json['is_active'];
    numberplate = json['number_plate'];
    lastlocation = json['last_location'];
    driver = json['driver'];
    maker = json['maker'];
    model = json['model'];
    cabtype = json['cab_type'];
    cabclass = json['cab_class'];
    back = json["back"];
    front = json["front"];
    right = json["right"];
    left = json["left"];
    insideDriverSeat = json["inside_driver_seat"];
    frontHeadLight = json["front_head_light"];
    backHeadLight = json["back_head_light"];
    insidePassangerSeat = json["inside_passanger_seat"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_active'] = isactive;
    data['number_plate'] = numberplate;
    data['last_location'] = lastlocation;
    data['driver'] = driver;
    data['maker'] = maker;
    data['model'] = model;
    data['cab_type'] = cabtype;
    data['cab_class'] = cabclass;
    data['back'] = back;
    data['right'] = right;
    data['left'] = left;
    data['inside_driver_seat'] = insideDriverSeat;
    data['front_head_light'] = frontHeadLight;
    data['back_head_light'] = backHeadLight;
    data['inside_passanger_seat'] = insidePassangerSeat;
    data['front'] = front;
    return data;
  }
}

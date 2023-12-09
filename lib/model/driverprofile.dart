class DriverProfile {
  int? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? fulladdress;
  String? alternatenumber;
  String? aadharnumber;
  String? aadharuploadfront;
  String? aadharuploadback;
  String? pannumber;
  String? panupload;
  String? licensenumber;
  String? licenseuploadfront;
  String? licenseuploadback;
  String? photoupload;
  bool? termspolicy;
  bool? myrideinsurance;
  double? walletBalance;
  bool? driverDuty;
  double? totalTrip;
  double? totalDistanceKm;

  DriverProfile({
    this.id,
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.fulladdress,
    this.alternatenumber,
    this.aadharnumber,
    this.aadharuploadfront,
    this.aadharuploadback,
    this.pannumber,
    this.panupload,
    this.licensenumber,
    this.licenseuploadfront,
    this.licenseuploadback,
    this.photoupload,
    this.termspolicy,
    this.myrideinsurance,
    this.walletBalance,
    this.driverDuty,
    this.totalTrip,
    this.totalDistanceKm,
  });

  DriverProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['first_name'];
    lastname = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    fulladdress = json['full_address'];
    alternatenumber = json['alternate_number'];
    aadharnumber = json['aadhar_number'];
    aadharuploadfront = json['aadhar_upload_front'];
    aadharuploadback = json['aadhar_upload_back'];
    pannumber = json['pan_number'];
    panupload = json['pan_upload'];
    licensenumber = json['license_number'];
    licenseuploadfront = json['license_upload_front'];
    licenseuploadback = json['license_upload_back'];
    photoupload = json['photo_upload'];
    termspolicy = json['terms_policy'];
    myrideinsurance = json['myride_insurance'];
    walletBalance = json['wallet_balance'] / 100 ?? 0.0;
    driverDuty = json['driver_duty'] ?? false;
    totalTrip = json['total_trip'] ?? 0.0;
    totalDistanceKm = json['total_distance_km'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstname;
    data['last_name'] = lastname;
    data['phone'] = phone;
    data['email'] = email;
    data['full_address'] = fulladdress;
    data['alternate_number'] = alternatenumber;
    data['aadhar_number'] = aadharnumber;
    data['aadhar_upload_front'] = aadharuploadfront;
    data['aadhar_upload_back'] = aadharuploadback;
    data['pan_number'] = pannumber;
    data['pan_upload'] = panupload;
    data['license_number'] = licensenumber;
    data['license_upload_front'] = licenseuploadfront;
    data['license_upload_back'] = licenseuploadback;
    data['photo_upload'] = photoupload;
    data['terms_policy'] = termspolicy;
    data['myride_insurance'] = myrideinsurance;
    data['driver_duty'] = driverDuty;
    return data;
  }
}

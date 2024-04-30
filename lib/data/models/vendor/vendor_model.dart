class VendorModel {
  String? sId;
  String? role;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;
  String? city;
  String? shopName;
  String? formStatus;
  int? profileProgress;
  String? id;
  String? updatedOn;
  String? createdOn;

  VendorModel(
      {this.sId,
      this.role,
      this.fullName,
      this.email,
      this.password,
      this.phoneNumber,
      this.address,
      this.city,
      this.shopName,
      this.formStatus,
      this.profileProgress,
      this.id,
      this.updatedOn,
      this.createdOn});

  VendorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    city = json['city'];
    shopName = json['shopName'];
    formStatus = json['formStatus'];
    profileProgress = json['profileProgress'];
    id = json['id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['shopName'] = this.shopName;
    data['formStatus'] = this.formStatus;
    data['profileProgress'] = this.profileProgress;
    data['id'] = this.id;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}

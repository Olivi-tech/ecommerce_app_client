class ProfileModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;

  ProfileModel(
      {
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['firstName'],
      address: json['address'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address' : address,
      'phoneNumber': phoneNumber
    };
  }
}

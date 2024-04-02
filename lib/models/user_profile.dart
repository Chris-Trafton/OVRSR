class UserProfile {
  String id = '';
  String _userName = '';
  String _email = '';
  String _password = '';
  String _links = '';

  UserProfile(
    this._userName,
    this._email,
    this._password,
    this._links,
  );

  UserProfile.empty() {
    _userName = '';
    _email = '';
    _password = '';
    _links = '';
  }

  UserProfile.fromJsonDbObject(
      Map<String, dynamic> data, String fbAuthenticatedEmail) {
    _userName = data['userName'] ?? '';
    _email = fbAuthenticatedEmail;
    _password = data['password'] ?? '';
    _links = data['links'] ?? '';
  }

  set userName(String value) {
    _userName = value;
  }

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set links(String value) {
    _links = value;
  }

  String get userName => _userName;
  String get email => _email;
  String get password => _password;
  String get links => _links;

  bool isMissingKeyData() {
    return (email.isEmpty || password.isEmpty);
  }

  Map<String, dynamic> toJsonForDb() {
    // Create empty map
    Map<String, dynamic> jsonObject = {};

    // Add all fields to the json map
    jsonObject['userName'] = userName;
    jsonObject['email'] = email;
    jsonObject['password'] = password;
    jsonObject['links'] = links;

    return jsonObject;
  }
}

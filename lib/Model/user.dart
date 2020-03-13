class User {
  String firebaseId,
      cardToken,
      label,
      notes,
      unit,
      phoneno,
      state,
      city,
      location,
      profileName,
      email;

  User();

  User.fromMap(Map map) {
    profileName =
        map["firstN"] ?? "Not given" + " " + map["lastN"] ?? ", Not given";
    location = map["location"] ?? "Not given";
    city = map["city"] ?? "Not given";
    state = map["state"] ?? "Not given";
    phoneno = map["phoneno"] ?? "Not given";
    unit = map["unit"] ?? "Not given";
    notes = map["notes"] ?? "Not given";
    label = map["label"] ?? "Not given";
    cardToken = map["cardToken"] ?? null;
    email = map["email"] ?? "Not given";
  }
}

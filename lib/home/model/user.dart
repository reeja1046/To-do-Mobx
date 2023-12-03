class User {
  String name;
  String profileImage;
  bool isUpi;
  bool isCash;
  bool isLater;

  User({
    required this.name,
    required this.profileImage,
    this.isUpi=false,
    this.isCash=false,
    this.isLater=false,
  });
}

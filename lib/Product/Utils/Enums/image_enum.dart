enum ProjectImages {
  icImageNotFound("im_not_found");

  const ProjectImages(this.value);
  final String value;
  String get imagePath => "assets/Images/$value.png";
}

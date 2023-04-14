enum ProjectLotties {
  icFarm("lo_farm"),
  icImageLoader("lo_image_loader");

  const ProjectLotties(this.value);
  final String value;
  String get lottiePath => "assets/LottieItems/$value.json";
}

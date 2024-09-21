class ProjectItem {
  final String title;
  final String location;
  final String imageUrl;
  final List<String> imageUrls;
  // final List<String> amenitiesUrls;
  final List<String> amenities;
  final List<String> amenitiesicon;

  final String description;

  ProjectItem({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.imageUrls,
    // required this.amenitiesUrls,
    required this.amenities,
    required this.amenitiesicon,
    required this.description,
  });
}

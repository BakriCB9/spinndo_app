class Categories {
  final int id;
  final String name;
  final List<Categories> children;
  Categories({required this.name, required this.id, required this.children});
}

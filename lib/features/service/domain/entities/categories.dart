import 'package:app/features/service/domain/entities/child_category.dart';

class Categories {
  final int id;
  final String name;
 final List<ChildCategory>children;
  Categories({required this.name, required this.id,required this.children});
}

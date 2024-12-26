import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_parent.dart';

class ProviderProfileCategory {
  int? id;
  String? name;
  ProviderProfileCategory? parent;

  ProviderProfileCategory({this.id, this.name, this.parent});
}

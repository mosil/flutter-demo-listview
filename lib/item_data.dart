import 'package:json_annotation/json_annotation.dart';

part 'item_data.g.dart';

@JsonSerializable()
class ItemData {
  ItemData({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory ItemData.fromJson(Map<String, dynamic> json) =>
      _$ItemDataFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDataToJson(this);
}

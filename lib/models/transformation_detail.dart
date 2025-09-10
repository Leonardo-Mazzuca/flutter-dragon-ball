class TransformationDetail {
  final int id;
  final String name;
  final String image;
  final String ki;
  TransformationDetail({required this.id, required this.name, required this.image, required this.ki});

  factory TransformationDetail.fromJson(Map<String, dynamic> json) {
    return TransformationDetail(id: json['id'], name: json['name'], image: json['image'], ki: json['ki']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'ki': ki};
  }
}
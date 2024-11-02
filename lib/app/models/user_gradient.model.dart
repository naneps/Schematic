import 'package:schematic/app/commons/utils/date_formatter.dart';
import 'package:schematic/app/models/builder_models/gradient.model.dart';

class UserGradientModel {
  final String? id;
  String? userId;
  String? name;
  GradientModel? gradient;
  bool? published = false;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  Map<String, bool>? likedBy = {}; // Key-value pairs for liked users
  Map<String, bool>? savedBy = {}; // Key-value pairs for saved users

  UserGradientModel({
    this.id,
    this.userId,
    this.gradient,
    this.name,
    this.published,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.likedBy,
    this.savedBy,
  });

  factory UserGradientModel.fromJson(String id, Map<String, dynamic> json) {
    return UserGradientModel(
      id: id,
      userId: json['userId'],
      gradient: GradientModel.fromJson(Map.from(json['gradient'])),
      name: json['name'],
      published: json['published'] ?? false,
      publishedAt: json['published_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      likedBy: Map<String, bool>.from(json['likedBy'] ?? {}),
      savedBy: Map<String, bool>.from(json['savedBy'] ?? {}),
    );
  }

  String get formattedDate {
    return DateFormatter().dateFromNow(createdAt!);
  }

  @override
  int get hashCode {
    return name.hashCode ^ gradient.hashCode;
  }

  // Calculate like count and save count based on likedBy and savedBy maps
  int get likeCount => likedBy?.length ?? 0;

  String get publishedDate {
    return DateFormatter().dateFromNow(publishedAt!);
  }

  int get saveCount => savedBy?.length ?? 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserGradientModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  UserGradientModel copyWith({
    String? id,
    String? userId,
    String? name,
    GradientModel? gradient,
    Map<String, bool>? likedBy,
    Map<String, bool>? savedBy,
  }) {
    return UserGradientModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      gradient: gradient ?? this.gradient,
      likedBy: likedBy ?? this.likedBy,
      savedBy: savedBy ?? this.savedBy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'gradient': gradient?.toJson(),
      'name': name ?? 'New Gradient',
      'colors': gradient!.colors.map((color) => color.value).toList(),
      'gradient_code': gradient?.toCode(),
      'gradient_type': gradient?.type.name,
      'published': published,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'likedBy': likedBy,
      'savedBy': savedBy,
    };
  }

  @override
  String toString() {
    return 'UserGradientModel{id: $id, userId: $userId, name: $name, gradient: $gradient, published: $published, publishedAt: $publishedAt, createdAt: $createdAt, updatedAt: $updatedAt, likeCount: $likeCount, saveCount: $saveCount}';
  }
}

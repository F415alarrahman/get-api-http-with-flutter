import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class Recipe {

  const Recipe({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.cookingMethod,
    required this.ingredients,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.user,
  });

  final int id;
  final int userId;
  final String title;
  final String description;
  final String cookingMethod;
  final String ingredients;
  final String photoUrl;
  final String createdAt;
  final String updatedAt;
  final int likesCount;
  final int commentsCount;
  final User user;

  factory Recipe.fromJson(Map<String,dynamic> json) => Recipe(
    id: json['id'] as int,
    userId: json['user_id'] as int,
    title: json['title'].toString(),
    description: json['description'].toString(),
    cookingMethod: json['cooking_method'].toString(),
    ingredients: json['ingredients'].toString(),
    photoUrl: json['photo_url'].toString(),
    createdAt: json['created_at'].toString(),
    updatedAt: json['updated_at'].toString(),
    likesCount: json['likes_count'] as int,
    commentsCount: json['comments_count'] as int,
    user: User.fromJson(json['user'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'title': title,
    'description': description,
    'cooking_method': cookingMethod,
    'ingredients': ingredients,
    'photo_url': photoUrl,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'likes_count': likesCount,
    'comments_count': commentsCount,
    'user': user.toJson()
  };

  Recipe clone() => Recipe(
    id: id,
    userId: userId,
    title: title,
    description: description,
    cookingMethod: cookingMethod,
    ingredients: ingredients,
    photoUrl: photoUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    likesCount: likesCount,
    commentsCount: commentsCount,
    user: user.clone()
  );


  Recipe copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? cookingMethod,
    String? ingredients,
    String? photoUrl,
    String? createdAt,
    String? updatedAt,
    int? likesCount,
    int? commentsCount,
    User? user
  }) => Recipe(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    description: description ?? this.description,
    cookingMethod: cookingMethod ?? this.cookingMethod,
    ingredients: ingredients ?? this.ingredients,
    photoUrl: photoUrl ?? this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    likesCount: likesCount ?? this.likesCount,
    commentsCount: commentsCount ?? this.commentsCount,
    user: user ?? this.user,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Recipe && id == other.id && userId == other.userId && title == other.title && description == other.description && cookingMethod == other.cookingMethod && ingredients == other.ingredients && photoUrl == other.photoUrl && createdAt == other.createdAt && updatedAt == other.updatedAt && likesCount == other.likesCount && commentsCount == other.commentsCount && user == other.user;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ title.hashCode ^ description.hashCode ^ cookingMethod.hashCode ^ ingredients.hashCode ^ photoUrl.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ likesCount.hashCode ^ commentsCount.hashCode ^ user.hashCode;
}

@immutable
class User {

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final String createdAt;
  final String updatedAt;

  factory User.fromJson(Map<String,dynamic> json) => User(
    id: json['id'] as int,
    name: json['name'].toString(),
    email: json['email'].toString(),
    emailVerifiedAt: json['email_verified_at'] as dynamic,
    createdAt: json['created_at'].toString(),
    updatedAt: json['updated_at'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'email_verified_at': emailVerifiedAt,
    'created_at': createdAt,
    'updated_at': updatedAt
  };

  User clone() => User(
    id: id,
    name: name,
    email: email,
    emailVerifiedAt: emailVerifiedAt,
    createdAt: createdAt,
    updatedAt: updatedAt
  );


  User copyWith({
    int? id,
    String? name,
    String? email,
    dynamic? emailVerifiedAt,
    String? createdAt,
    String? updatedAt
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is User && id == other.id && name == other.name && email == other.email && emailVerifiedAt == other.emailVerifiedAt && createdAt == other.createdAt && updatedAt == other.updatedAt;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode ^ emailVerifiedAt.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
}

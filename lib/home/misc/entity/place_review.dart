import 'package:equatable/equatable.dart';

class PlaceReview extends Equatable {
  const PlaceReview({
    required this.author,
    required this.content,
    required this.createdAt,
  });

  final String author;
  final String content;
  final DateTime createdAt;

  @override
  List<Object> get props => [
        author,
        content,
        createdAt,
      ];
}

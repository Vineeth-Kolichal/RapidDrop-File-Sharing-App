import '../../domain/entities/trivia_entity.dart';

class TriviaModel extends TriviaEntity {
  TriviaModel({
    required super.text,
    required super.number,
    required super.found,
    required super.type,
  });

  factory TriviaModel.fromJson(Map<String, dynamic> json) => TriviaModel(
        text: json["text"],
        number: json["number"],
        found: json["found"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "number": number,
        "found": found,
        "type": type,
      };
}


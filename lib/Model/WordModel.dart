// To parse this JSON data, do
//
//     final wordModel = wordModelFromJson(jsonString);

import 'dart:convert';

List<WordModel> wordModelFromJson(String str) => new List<WordModel>.from(json.decode(str).map((x) => WordModel.fromMap(x)));

String wordModelToJson(List<WordModel> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toMap())));

class WordModel {
    String latter;
    String image;
    List<Word> words;

    WordModel({
        this.latter,
        this.image,
        this.words,
    });

    factory WordModel.fromMap(Map<String, dynamic> json) => new WordModel(
        latter: json["latter"] == null ? null : json["latter"],
        image: json["image"] == null ? null : json["image"],
        words: json["words"] == null ? null : new List<Word>.from(json["words"].map((x) => Word.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "latter": latter == null ? null : latter,
        "words": words == null ? null : new List<dynamic>.from(words.map((x) => x.toMap())),
    };
}

class Word {
    String word;
    String desc;
    String picture;

    Word({
        this.word,
        this.desc,
        this.picture,
    });

    factory Word.fromMap(Map<String, dynamic> json) => new Word(
        word: json["word"] == null ? null : json["word"],
        desc: json["desc"] == null ? null : json["desc"],
        picture: json["picture"] == null ? null : json["picture"],
    );

    Map<String, dynamic> toMap() => {
        "word": word == null ? null : word,
        "desc": desc == null ? null : desc,
        "picture": picture == null ? null : picture,
    };
}

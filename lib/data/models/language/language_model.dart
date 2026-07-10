class LanguageModel {
  final String name;
  final String locale;

  LanguageModel({required this.name, required this.locale});

  // Convert a LanguageModel into a Map
  Map<String, dynamic> toJson() => {
        'name': name,
        'locale': locale,
      };

  // Convert a Map into a LanguageModel
  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      name: json['name'],
      locale: json['locale'],
    );
  }
}

final List<LanguageModel> languages = [
  LanguageModel(name: 'English', locale: 'en'),
  LanguageModel(name: 'Spanish', locale: 'es'),
  LanguageModel(name: 'Chinese', locale: 'zh'),
  LanguageModel(name: 'Dutch', locale: 'nl'),
  LanguageModel(name: 'French', locale: 'fr'),
  LanguageModel(name: 'German', locale: 'de'),
  LanguageModel(name: 'Italian', locale: 'it'),
  LanguageModel(name: 'Korean', locale: 'ko'),
  LanguageModel(name: 'Portuguese', locale: 'pt'),
  LanguageModel(name: 'Russian', locale: 'ru'),
];

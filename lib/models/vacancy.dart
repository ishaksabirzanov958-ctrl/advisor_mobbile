// Бул класс backend'тен келген VacancyView JSON'ун Dart объектисине айландырат.
// Java'дагы record'дун Dart аналогу сыяктуу — жөн эле маалымат ташуучу класс.
class Vacancy {
  final String title; // вакансиянын аталышы
  final String employer; // иш берүүчүнүн аты
  final String description; // кыскача сүрөттөлүшү
  final String url; // толук вакансияга шилтеме

  Vacancy({
    required this.title,
    required this.employer,
    required this.description,
    required this.url,
  });

  // fromJson — сервердин JSON жообун (Map түрүндө) Vacancy объектисине айландырат.
  // factory дегени "бул конструктор эмес, жаңы объект жасаган жөнөкөй метод" дегенди билдирет.
  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      title: json['title'] ?? '',
      employer: json['employer'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

// Backend'тен RoadmapResponse JSON'ун Dart'ка алып келүүчү класс.
class RoadmapResponse {
  final String targetRole;
  final List<String> missingSkills;
  final String roadmapText;

  RoadmapResponse({
    required this.targetRole,
    required this.missingSkills,
    required this.roadmapText,
  });

  factory RoadmapResponse.fromJson(Map<String, dynamic> json) {
    return RoadmapResponse(
      targetRole: json['targetRole'] ?? '',
      // missingSkills сервердеп List<String> катары келет, аны Dart'тагы
      // List<dynamic>'тен List<String>'ке коопсуз айландырабыз.
      missingSkills: List<String>.from(json['missingSkills'] ?? []),
      roadmapText: json['roadmapText'] ?? '',
    );
  }
}

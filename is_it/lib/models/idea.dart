class Idea {
  final String title;
  final String briefSummary;
  final String detailSummary;
  final double similarityScore;

  Idea({
    required this.title,
    required this.briefSummary,
    required this.detailSummary,
    required this.similarityScore,
  });

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
      title: json['title'],
      briefSummary: json['briefSummary'],
      detailSummary: json['detailSummary'],
      similarityScore: json['similarity_score'],
    );
  }
}

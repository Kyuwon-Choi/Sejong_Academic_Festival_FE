import 'package:flutter/material.dart';
import 'package:is_it/models/idea.dart';

class DetailSimilarityScreen extends StatelessWidget {
  final String title;
  final String details;
  final List<Idea> similarityData;

  const DetailSimilarityScreen({
    Key? key,
    required this.title,
    required this.details,
    required this.similarityData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IS IT?', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(60),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xfff5f5f5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '유사도 비율 TOP5',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Is It 은 상위 5개까지의 유사도 비율과 세부 내역을 보여줍니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: similarityData.length,
                    itemBuilder: (context, index) {
                      final item = similarityData[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            '${item.title} (${item.similarityScore.toStringAsFixed(1)}%)',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Brief Summary: ${item.briefSummary}'),
                              Text('Detail Summary: ${item.detailSummary}'),
                            ],
                          ),
                          tileColor: Colors.transparent,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:is_it/models/idea.dart';
import 'detail_similarity_screen.dart';

class CheckSimilarityScreen extends StatefulWidget {
  final String title;
  final String details;
  final List<Idea> similarityData;

  const CheckSimilarityScreen({
    Key? key,
    required this.title,
    required this.details,
    required this.similarityData,
  }) : super(key: key);

  @override
  State<CheckSimilarityScreen> createState() => _CheckSimilarityScreenState();
}

class _CheckSimilarityScreenState extends State<CheckSimilarityScreen> {
  double percentage = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    simulateFetchPercentage();
  }

  void simulateFetchPercentage() async {
    // 실제 데이터를 불러오는 시간을 시뮬레이션
    await Future.delayed(const Duration(seconds: 2));
    calculateAverageSimilarity();
  }

  void calculateAverageSimilarity() {
    if (widget.similarityData.isNotEmpty) {
      double total = widget.similarityData
          .fold(0.0, (sum, item) => sum + item.similarityScore);
      setState(() {
        percentage = double.parse(
            (total / widget.similarityData.length).toStringAsFixed(1));
        isLoading = false; // 데이터 로딩 완료
      });
    } else {
      setState(() {
        isLoading = false; // 데이터 로딩 완료
      });
    }
  }

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
          child: isLoading
              ? Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('검사중입니다 기다려주세요'),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(60),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  '  의',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                ),
                              ],
                            ),
                            Text(
                              '아이디어 유사도는',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                            Text(
                              '$percentage%',
                              style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                            Text(
                              '입니다!',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                              child: PieChart(
                                PieChartData(
                                  startDegreeOffset: 270,
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '$percentage%',
                              style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff51626f)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailSimilarityScreen(
                                      title: widget.title,
                                      details: widget.details,
                                      similarityData: widget.similarityData,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.background,
                                backgroundColor: Colors.white,
                              ),
                              child: const Text('상세 유사 항목'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Theme.of(context).colorScheme.background,
        value: percentage,
        title: '',
        radius: 70,
        titleStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: const Color(0xffdde1e6),
        value: 100 - percentage,
        title: '',
        radius: 70,
        titleStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    ];
  }
}

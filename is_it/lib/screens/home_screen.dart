import 'package:flutter/material.dart';
import 'package:is_it/models/idea.dart';
import '../services/api_service.dart';
import 'check_similarity_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final ApiService apiService = ApiService();
  bool isLoading = false;

  void _checkSimilarity() async {
    if (_titleController.text.isNotEmpty &&
        _detailsController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {
        List<Idea> similarityData = await apiService.findSimilarIdeas(
          _titleController.text,
          _detailsController.text,
        );
        setState(() {
          isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckSimilarityScreen(
              title: _titleController.text,
              details: _detailsController.text,
              similarityData: similarityData,
            ),
          ),
        );
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        // 오류 처리
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to get similarity data.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/sejong_logo.png'),
              ),
            ],
          ),
          title: const Text('IS IT?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
        body: Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('CHECK YOUR IDEA',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 16),
                  const Text(
                    '당신이 구현하고 싶은 아이디어를 입력하세요!\n당신의 아이디어 유사도를 퍼센트로 알려드립니다.',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: '아이디어 제목을 입력해주세요! 예) is it',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.8)),
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _detailsController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          '아이디어의 구체적인 내용을 입력해주세요!\n예) 아이디어의 유사도를 이미 나와있는 아이디어들과 비교하여 검사',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.8)),
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _checkSimilarity,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Text(
                      '검사',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Center(
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
              ),
          ],
        ),
      ),
    );
  }
}

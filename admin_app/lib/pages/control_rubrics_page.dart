import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ControlRubricsPage extends StatefulWidget {
  const ControlRubricsPage({super.key});

  @override
  State<ControlRubricsPage> createState() => _ControlRubricsPageState();
}

class _ControlRubricsPageState extends State<ControlRubricsPage> {
  final Dio dio = Dio();
  List rubrics = [];
  final TextEditingController _controller = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRubrics();
  }

  Future<void> fetchRubrics() async {
    final response = await dio.get('http://45.12.136.148:8080/rubrics');
    setState(() {
      rubrics = response.data;
      isLoading = false;
    });
  }

  Future<void> createRubric(String name) async {
    if (name.trim().isEmpty) return;
    await dio.post('http://45.12.136.148:8080/rubrics', data: {"name": name});
    _controller.clear();
    fetchRubrics();
  }

  Future<void> deleteRubric(String id) async {
    await dio.delete('http://45.12.136.148:8080/rubrics/$id');
    fetchRubrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Управление рубриками")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: "Название рубрики",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => createRubric(_controller.text),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: rubrics.length,
                    itemBuilder: (context, index) {
                      final rubric = rubrics[index];
                      return ListTile(
                        title: Text(rubric['name'] ?? 'Без названия'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteRubric(rubric['id']),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/rubric_service.dart';
import '../widgets/category_card.dart';
import 'package:dio/dio.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late RubricService rubricService;
  List<dynamic> rubrics = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    rubricService = RubricService(Dio(BaseOptions(baseUrl: "http://45.12.136.148:8080")));
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await rubricService.getRubricsWithCompanies();
    setState(() {
      rubrics = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Рубрики")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: rubrics.length,
              itemBuilder: (context, index) {
                final rubric = rubrics[index];
                return CategoryCard(
                  title: rubric['name'] ?? 'Без названия',
                  rubricId: rubric['id'],
                  imageUrl: rubric['imageUrl'] ?? 'https://via.placeholder.com/150',
                );
              },
            ),
    );
  }
}

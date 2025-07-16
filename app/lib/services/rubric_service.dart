import 'package:dio/dio.dart';

class RubricService {
  final Dio dio;

  RubricService(this.dio);

  Future<List<dynamic>> getRubricsWithCompanies() async {
    final response = await dio.get("/rubrics/with-companies");
    return response.data;
  }
}

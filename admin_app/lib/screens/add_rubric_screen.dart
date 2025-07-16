// lib/screens/add_rubric_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class AddRubricScreen extends StatefulWidget {
  const AddRubricScreen({super.key});

  @override
  State<AddRubricScreen> createState() => _AddRubricScreenState();
}

class _AddRubricScreenState extends State<AddRubricScreen> {
  final TextEditingController _nameController = TextEditingController();
  File? _image;
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://45.12.136.148:8080'));

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty || _image == null) return;

    final formData = FormData.fromMap({
      'name': name,
      'image': await MultipartFile.fromFile(_image!.path)
    });

    try {
      final response = await _dio.post('/rubrics', data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Рубрика добавлена')));
        Navigator.pop(context);
      }
    } catch (e) {
      print('Ошибка: \$e');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка при добавлении')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить рубрику')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            const SizedBox(height: 20),
            _image != null
                ? Image.file(_image!, height: 150)
                : const Text('Изображение не выбрано'),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Выбрать изображение'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Сохранить'),
            )
          ],
        ),
      ),
    );
  }
}

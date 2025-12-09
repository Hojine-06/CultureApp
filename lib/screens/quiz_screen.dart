// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:culture_app/models/quiz_question_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Ici viendra la logique pour gérer la progression du quiz et le score

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Culturel')),
      body: Center(
        child: Text('Écran Quiz en cours de construction...'),
      ),
    );
  }
}
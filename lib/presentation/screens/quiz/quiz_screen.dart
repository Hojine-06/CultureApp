// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:benin_culture_app/data/models/quiz_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  String? _selectedOption;
  int _score = 0;
  bool _showExplanation = false;

  void _selectOption(String option) {
    if (_showExplanation) return;
    setState(() {
      _selectedOption = option;
      _showExplanation = true;
      if (option == sampleQuizQuestions[_currentIndex].correctAnswer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex++;
      _selectedOption = null;
      _showExplanation = false;
    });
  }

  void _restart() {
    setState(() {
      _currentIndex = 0;
      _selectedOption = null;
      _score = 0;
      _showExplanation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = sampleQuizQuestions.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Culturel - Bénin')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentIndex >= total
            ? _buildResult()
            : _buildQuestionCard(context),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    final question = sampleQuizQuestions[_currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Question ${_currentIndex + 1} / ${sampleQuizQuestions.length}',
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 8),
        Text(question.question, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ...question.options.map((opt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showExplanation
                      ? (opt == question.correctAnswer
                          ? Colors.green
                          : (opt == _selectedOption ? Colors.red : null))
                      : null,
                ),
                onPressed: () => _selectOption(opt),
                child: Align(alignment: Alignment.centerLeft, child: Text(opt)),
              ),
            )),
        const SizedBox(height: 12),
        if (_showExplanation) ...[
          Text(
            _selectedOption == question.correctAnswer
                ? 'Bonne réponse !'
                : 'Mauvaise réponse',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _selectedOption == question.correctAnswer
                    ? Colors.green
                    : Colors.red),
          ),
          const SizedBox(height: 8),
          Text(question.explanation,
              style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          ElevatedButton(
            onPressed: _currentIndex + 1 < sampleQuizQuestions.length
                ? _nextQuestion
                : () =>
                    setState(() => _currentIndex = sampleQuizQuestions.length),
            child: Text(_currentIndex + 1 < sampleQuizQuestions.length
                ? 'Suivant'
                : 'Voir le score'),
          ),
        ]
      ],
    );
  }

  Widget _buildResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Quiz terminé',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text('Score: $_score / ${sampleQuizQuestions.length}',
            style: TextStyle(fontSize: 20)),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _restart, child: const Text('Recommencer')),
      ],
    );
  }
}

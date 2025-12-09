// lib/models/quiz_question_model.dart
class QuizQuestionModel {
  final String question;
  final List<String> options; // Les choix possibles
  final String correctAnswer; // La bonne réponse

  QuizQuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  // Vous pouvez ajouter ici la méthode fromJson() plus tard
}
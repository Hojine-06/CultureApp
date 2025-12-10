import '../models/quiz_question_model.dart';

final List<QuizQuestion> sampleQuizQuestions = [
  QuizQuestion(
    question: 'Quelle est la capitale du Bénin ?',
    options: ['Cotonou', 'Porto-Novo', 'Parakou', 'Abomey'],
    correctAnswer: 'Porto-Novo',
    explanation: 'Porto-Novo est la capitale constitutionnelle du Bénin, tandis que Cotonou est la plus grande ville et le centre économique.',
  ),
  QuizQuestion(
    question: 'Quel riche héritage culturel est célébré au Bénin ?',
    options: ['Vodun', 'Carnaval', 'Flamenco', 'Mardi Gras'],
    correctAnswer: 'Vodun',
    explanation: 'Le culte Vodun (ou vaudou) est originaire de la région et reste une part importante du patrimoine culturel béninois.',
  ),
  QuizQuestion(
    question: 'Quel est l\'instrument de musique traditionnel très utilisé en Afrique de l\'Ouest ?',
    options: ['Kora', 'Piano', 'Violon', 'Sitar'],
    correctAnswer: 'Kora',
    explanation: 'La kora est une harpe-luth d\'Afrique de l\'Ouest, souvent utilisée dans la musique traditionnelle.',
  ),
];

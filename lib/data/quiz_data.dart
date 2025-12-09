import '../models/quiz_question_model.dart';

const List<QuizQuestionModel> sampleQuizQuestions = [
  QuizQuestionModel(
    question: 'Quelle est la capitale officielle du Bénin ?',
    options: ['Cotonou', 'Porto-Novo', 'Abomey', 'Parakou'],
    correctAnswer: 'Porto-Novo',
  ),
  QuizQuestionModel(
    question: 'Quelle langue nationale est largement parlée au Bénin en plus du français ?',
    options: ['Fon', 'Yoruba', 'Wolof', 'Lingala'],
    correctAnswer: 'Fon',
  ),
  QuizQuestionModel(
    question: 'Quelle religion traditionnelle est profondément ancrée dans la culture béninoise ?',
    options: ['Vodoun', 'Bouddhisme', 'Shinto', 'Zoroastrisme'],
    correctAnswer: 'Vodoun',
  ),
  QuizQuestionModel(
    question: 'Quel site historique lié aux royaumes dahoméens est classé patrimoine culturel ?',
    options: ['Palais des Rois d\'Abomey', "Île de Gorée", 'Timbuktu', 'Grand-Pont de Ouidah'],
    correctAnswer: "Palais des Rois d'Abomey",
  ),
  QuizQuestionModel(
    question: 'Quelle monnaie est utilisée au Bénin ?',
    options: ['Franc CFA', 'Euro', 'Dollar', 'Naira'],
    correctAnswer: 'Franc CFA',
  ),
];
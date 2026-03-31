import 'package:flutter/material.dart';
import '../app_theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static final _questions = [
    // ── Fondamentaux ─────────────────────────────────────────────────────
    _Question(
      question: 'Quelle entreprise a développé Grok ?',
      options: ['OpenAI', 'Google DeepMind', 'xAI (Elon Musk)', 'Meta AI'],
      correct: 2,
      explanation: 'Grok est développé par xAI, l\'entreprise d\'IA fondée par Elon Musk en 2023. '
          'xAI est distinct de X Corp (anciennement Twitter), même si les deux sont liés.',
    ),
    _Question(
      question: 'Quel est l\'avantage unique de Grok par rapport aux autres LLMs grand public ?',
      options: [
        'Il génère du code plus rapidement',
        'Il a accès aux données X (Twitter) en temps réel',
        'Il est entièrement open source',
        'Il n\'a aucune restriction de contenu',
      ],
      correct: 1,
      explanation: 'Grok est le seul LLM grand public avec un accès direct '
          'et en temps réel aux données de X (anciennement Twitter), '
          'permettant d\'analyser les tendances, posts et discussions actuelles.',
    ),
    _Question(
      question: 'Comment s\'appelle le modèle de génération d\'images de xAI ?',
      options: ['Imagine', 'Aurora', 'Flux', 'Prism'],
      correct: 1,
      explanation: 'Aurora est le modèle de génération d\'images de xAI, '
          'intégré dans Grok. Il est accessible via grok.com, '
          'l\'app mobile et l\'API xAI (model="grok-2-image").',
    ),
    _Question(
      question: 'Quelle est la fenêtre de contexte de Grok 3 ?',
      options: ['32 000 tokens', '64 000 tokens', '131 000 tokens', '1 000 000 tokens'],
      correct: 2,
      explanation: 'Grok 3 dispose d\'une fenêtre de contexte de 131 072 tokens (~131K), '
          'soit environ 300 pages de texte. Suffisant pour analyser '
          'des documents longs ou des bases de code.',
    ),
    _Question(
      question: 'Qu\'est-ce que le mode "Think" de Grok ?',
      options: [
        'Un mode de recherche sur X uniquement',
        'Le mode de génération d\'images Aurora',
        'Le mode de raisonnement étape par étape de Grok 3',
        'Une interface de débogage de code',
      ],
      correct: 2,
      explanation: 'Le mode Think active le raisonnement étendu (Chain-of-Thought) de Grok 3. '
          'Le modèle décompose le problème et raisonne avant de répondre. '
          'Via l\'API : reasoning_effort: "high" avec grok-3-mini.',
    ),
    // ── API & Technique ──────────────────────────────────────────────────
    _Question(
      question: 'Quel est le base URL de l\'API xAI ?',
      options: [
        'https://api.xai.com/v1',
        'https://api.grok.ai',
        'https://api.x.ai/v1',
        'https://xai.openai.com/v1',
      ],
      correct: 2,
      explanation: 'Le base URL officiel de l\'API xAI est https://api.x.ai/v1. '
          'L\'API est compatible OpenAI — utilisez le SDK openai '
          'avec base_url="https://api.x.ai/v1".',
    ),
    _Question(
      question: 'Par quelle séquence commence une clé API xAI ?',
      options: ['sk-', 'grok-', 'xai-', 'x-api-'],
      correct: 2,
      explanation: 'Les clés API xAI commencent par "xai-". '
          'Elles sont générées depuis console.x.ai → API Keys.',
    ),
    _Question(
      question: 'Quel paramètre API active le raisonnement étendu de Grok 3 Mini ?',
      options: [
        'think_mode: true',
        'reasoning_effort: "high"',
        'chain_of_thought: true',
        'extended_thinking: "enabled"',
      ],
      correct: 1,
      explanation: 'Le paramètre reasoning_effort (valeurs: "low" ou "high") '
          'active le mode de raisonnement de grok-3-mini. '
          'Il est passé dans extra_body lors de l\'appel API.',
    ),
    _Question(
      question: 'Quel modèle xAI est le plus rapide ?',
      options: ['grok-3', 'grok-3-mini', 'grok-3-fast', 'grok-2-image'],
      correct: 2,
      explanation: 'grok-3-fast est la variante ultra-rapide de Grok 3, '
          'optimisée pour la latence. Elle est aussi la plus chère '
          '(5\$/1M tokens en entrée, 25\$/1M en sortie).',
    ),
    _Question(
      question: 'Qu\'est-ce que DeepSearch dans Grok ?',
      options: [
        'Un moteur de recherche d\'images',
        'Une recherche approfondie multi-passes avec raisonnement',
        'La recherche dans les archives X',
        'Un plugin de recherche de code',
      ],
      correct: 1,
      explanation: 'DeepSearch est la fonctionnalité de recherche avancée de Grok : '
          'plusieurs passes de recherche et de raisonnement avant une réponse complète. '
          'Similaire à Deep Research de Perplexity ou OpenAI.',
    ),
    // ── Bonnes pratiques prompts ─────────────────────────────────────────
    _Question(
      question: 'Comment obtenir une réponse basée sur les données X récentes ?',
      options: [
        'Écrire "cherche sur Twitter" dans le prompt',
        'Utiliser model="grok-3" — la recherche X est activée par défaut',
        'Ajouter search_enabled: true dans les paramètres',
        'Grok n\'a pas accès à X via l\'API',
      ],
      correct: 1,
      explanation: 'Avec grok-3, la recherche X est activée par défaut. '
          'Posez simplement votre question. Pour désactiver : '
          'extra_body={"search_enabled": False}.',
    ),
    _Question(
      question: 'Quelle formulation maximise les capacités de raisonnement de Grok 3 ?',
      options: [
        '"Réponds vite à..."',
        '"Raisonne étape par étape, utilise le mode Think pour..."',
        '"Sois bref et direct"',
        'Il n\'y a pas de différence selon la formulation',
      ],
      correct: 1,
      explanation: 'Demander à Grok de "raisonner étape par étape" '
          'ou d\'utiliser "le mode Think" active son raisonnement étendu. '
          'Via l\'API, combinez avec reasoning_effort: "high" pour les problèmes complexes.',
    ),
    _Question(
      question: 'Pour générer une image réaliste avec Aurora, quelle structure de prompt est la meilleure ?',
      options: [
        '"Image de chat"',
        '"Sujet + style + éclairage + angle + medium (ex: photo argentique, ultra-réaliste)"',
        '"Génère une image sans texte"',
        'Il suffit de mettre des mots-clés sans contexte',
      ],
      correct: 1,
      explanation: 'Un bon prompt Aurora décrit : le sujet principal, le style artistique, '
          'l\'éclairage, l\'angle de vue et le medium. '
          'Exemple : "Portrait femme, lumière dorée, bokeh, photo argentique, 35mm".',
    ),
    _Question(
      question: 'Quelle est la bonne pratique pour analyser des tendances X avec Grok ?',
      options: [
        'Demander "cherche sur Google ce qui est trending"',
        'Être précis sur le sujet, la période et le type d\'analyse voulu',
        'Utiliser le mode Think uniquement',
        'Grok ne peut analyser que les tweets récents de 24h',
      ],
      correct: 1,
      explanation: 'Pour analyser des tendances X, précisez : '
          'le sujet exact ("tendances IA"), la période ("cette semaine"), '
          'et le type d\'analyse ("sentiment", "résumé", "personnalités influentes"). '
          'Plus le prompt est précis, meilleure est l\'analyse.',
    ),
    _Question(
      question: 'Où accéder à Grok indépendamment de X (Twitter) ?',
      options: ['xai.com', 'grok.com', 'chat.xai.com', 'ai.x.com'],
      correct: 1,
      explanation: 'grok.com est l\'interface web standalone de Grok, '
          'accessible sans compte X. Elle offre l\'accès complet '
          'à Grok 3, Aurora, Think mode et DeepSearch.',
    ),
    _Question(
      question: 'Quel modèle xAI est recommandé pour un usage à fort volume avec raisonnement ?',
      options: ['grok-3', 'grok-3-mini', 'grok-3-fast', 'grok-2-image'],
      correct: 1,
      explanation: 'grok-3-mini est le modèle idéal pour le fort volume avec raisonnement : '
          'il supporte reasoning_effort ("low"/"high") et coûte '
          'seulement 0,30\$/1M tokens en entrée, soit 10x moins que grok-3.',
    ),
  ];

  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _answered = false;
  bool _finished = false;

  void _answer(int choice) {
    if (_answered) return;
    setState(() {
      _selected = choice;
      _answered = true;
      if (_questions[_index].correct == choice) _score++;
    });
  }

  void _next() {
    if (_index < _questions.length - 1) {
      setState(() { _index++; _selected = null; _answered = false; });
    } else {
      setState(() => _finished = true);
    }
  }

  void _restart() {
    setState(() { _index = 0; _score = 0; _selected = null; _answered = false; _finished = false; });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, theme, child) {
        if (_finished) return _ResultPage(score: _score, total: _questions.length, onRestart: _restart);
        final q = _questions[_index];
        final c = context.primary;
        final c2 = context.secondary;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${_index + 1} / ${_questions.length}',
                      style: TextStyle(color: context.onSurface.withValues(alpha: 0.6), fontSize: 13)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (_index + 1) / _questions.length,
                        backgroundColor: c.withValues(alpha: 0.15),
                        color: c, minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(children: [
                    Icon(Icons.star, color: c2, size: 16),
                    const SizedBox(width: 4),
                    Text('$_score', style: TextStyle(color: c2, fontWeight: FontWeight.bold, fontSize: 14)),
                  ]),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: context.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: c.withValues(alpha: 0.3)),
                ),
                child: Text(q.question,
                    style: TextStyle(color: context.onSurface, fontSize: 16,
                        fontWeight: FontWeight.w600, height: 1.4)),
              ),
              const SizedBox(height: 16),
              ...List.generate(q.options.length, (i) {
                Color borderColor = c.withValues(alpha: 0.2);
                Color bgColor = context.cardBg;
                Color textColor = context.onSurface.withValues(alpha: 0.85);
                IconData? trailingIcon;
                if (_answered) {
                  if (i == q.correct) {
                    borderColor = Colors.green; bgColor = Colors.green.withValues(alpha: 0.12);
                    textColor = Colors.green; trailingIcon = Icons.check_circle_outline;
                  } else if (i == _selected && i != q.correct) {
                    borderColor = Colors.red; bgColor = Colors.red.withValues(alpha: 0.1);
                    textColor = Colors.red.shade300; trailingIcon = Icons.cancel_outlined;
                  }
                }
                return GestureDetector(
                  onTap: () => _answer(i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: bgColor, borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(
                            color: (_answered && i == q.correct)
                                ? Colors.green.withValues(alpha: 0.2)
                                : c.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Text(String.fromCharCode(65 + i),
                              style: TextStyle(
                                  color: (_answered && i == q.correct) ? Colors.green : c,
                                  fontWeight: FontWeight.bold, fontSize: 13))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(q.options[i],
                            style: TextStyle(color: textColor, fontSize: 14))),
                        if (trailingIcon != null)
                          Icon(trailingIcon,
                              color: i == q.correct ? Colors.green : Colors.red.shade300, size: 20),
                      ],
                    ),
                  ),
                );
              }),
              if (_answered) ...[
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: c.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, color: c, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text(q.explanation,
                          style: TextStyle(
                              color: context.onSurface.withValues(alpha: 0.8),
                              fontSize: 13, height: 1.5))),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c, foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      _index < _questions.length - 1 ? 'Question suivante →' : 'Voir les résultats',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _ResultPage extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const _ResultPage({required this.score, required this.total, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    final ratio = score / total;
    final c = context.primary;
    final c2 = context.secondary;
    final (emoji, label, comment) = ratio >= 0.9
        ? ('🏆', 'Excellent !', 'Maîtrise parfaite de Grok & xAI !')
        : ratio >= 0.7
            ? ('⭐', 'Très bien !', 'Bonne connaissance, quelques points à revoir')
            : ratio >= 0.5
                ? ('👍', 'Pas mal !', 'Continuez à explorer le guide')
                : ('📚', 'À revoir', 'Relisez les sections du guide et réessayez');

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(label, style: TextStyle(color: c, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(comment, textAlign: TextAlign.center,
                style: TextStyle(color: context.onSurface.withValues(alpha: 0.7), fontSize: 15)),
            const SizedBox(height: 32),
            Container(
              width: 140, height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: c, width: 4),
                color: c.withValues(alpha: 0.08),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$score / $total',
                      style: TextStyle(color: c, fontSize: 32, fontWeight: FontWeight.bold)),
                  Text('${(ratio * 100).round()}%',
                      style: TextStyle(color: c2, fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: ratio,
                backgroundColor: c.withValues(alpha: 0.15),
                color: c, minHeight: 12,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRestart,
                icon: const Icon(Icons.refresh),
                label: const Text('Recommencer',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: c, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Question {
  final String question;
  final List<String> options;
  final int correct;
  final String explanation;

  const _Question({required this.question, required this.options, required this.correct, required this.explanation});
}

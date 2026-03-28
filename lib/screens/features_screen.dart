import 'package:flutter/material.dart';
import '../app_theme.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  static final _features = [
    _Feature(
      icon: Icons.psychology_outlined,
      title: 'Raisonnement avancé',
      description: 'Grok excelle dans le raisonnement logique, les mathématiques et la résolution de problèmes complexes.',
      tips: [
        'Déduction et inférence logique',
        'Résolution de problèmes mathématiques',
        'Analyse de code complexe',
        'Raisonnement en plusieurs étapes',
      ],
    ),
    _Feature(
      icon: Icons.public,
      title: 'Accès temps réel à X (Twitter)',
      description: 'Grok est le seul modèle avec accès natif aux données en temps réel de X.',
      tips: [
        'Actualités et tendances du moment',
        'Recherche dans les tweets récents',
        'Contexte sur des événements actuels',
        'Informations non disponibles dans les autres LLMs',
      ],
    ),
    _Feature(
      icon: Icons.memory,
      title: 'Contexte 131 072 tokens',
      description: 'Fenêtre de contexte de 128K tokens pour traiter de longs documents.',
      tips: [
        'Analyse de bases de code entières',
        'Documents longs ou livres',
        'Conversations étendues sans perte de contexte',
        'Traitement de gros fichiers texte',
      ],
    ),
    _Feature(
      icon: Icons.image_outlined,
      title: 'Vision (multimodal)',
      description: 'Grok Vision Beta analyse et comprend les images avec le texte.',
      tips: [
        'Description et analyse d\'images',
        'Lecture de graphiques et diagrammes',
        'OCR et extraction de texte d\'images',
        'Questions sur des captures d\'écran',
      ],
    ),
    _Feature(
      icon: Icons.api,
      title: 'Compatible OpenAI',
      description: 'L\'API xAI est 100% compatible avec le format OpenAI.',
      tips: [
        'Utilise le SDK openai Python/JS directement',
        'Migration facile depuis GPT',
        'Même format de requêtes et réponses',
        'Support streaming identique',
      ],
    ),
    _Feature(
      icon: Icons.speed,
      title: 'Vitesse & Performance',
      description: 'Grok Beta offre des temps de réponse compétitifs pour des réponses de qualité.',
      tips: [
        'Streaming pour les longues réponses',
        'Faible latence pour le chat',
        'Max 131 072 tokens de contexte',
        'API stable et fiable',
      ],
    ),
    _Feature(
      icon: Icons.code,
      title: 'Génération de code',
      description: 'Grok génère, explique et débogue du code dans de nombreux langages.',
      tips: [
        'Python, JavaScript, Dart, Go, Rust...',
        'Revue et refactoring de code',
        'Génération de tests unitaires',
        'Explication de code complexe',
      ],
    ),
    _Feature(
      icon: Icons.translate,
      title: 'Multilingue',
      description: 'Grok comprend et génère du contenu dans de nombreuses langues.',
      tips: [
        'Français, anglais, espagnol...',
        'Traduction haute qualité',
        'Compréhension des nuances culturelles',
        'Code-switching naturel',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, _, _) => ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _features.length,
        itemBuilder: (context, i) => _FeatureCard(
          feature: _features[i],
          color: context.palette[i % context.palette.length],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final _Feature feature;
  final Color color;
  const _FeatureCard({required this.feature, required this.color});
  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.feature.icon, color: widget.color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(widget.feature.title,
                        style: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                      color: widget.color, size: 20),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: widget.color.withValues(alpha: 0.2)),
                  Text(widget.feature.description,
                      style: TextStyle(
                          color: context.onSurface.withValues(alpha: 0.8),
                          fontSize: 13,
                          height: 1.5)),
                  const SizedBox(height: 10),
                  ...widget.feature.tips.map((tip) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_right, color: widget.color, size: 18),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(tip,
                                  style: TextStyle(
                                      color: context.onSurface.withValues(alpha: 0.7),
                                      fontSize: 13)),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String description;
  final List<String> tips;
  const _Feature({required this.icon, required this.title, required this.description, required this.tips});
}

import 'package:flutter/material.dart';
import '../app_theme.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  static final _apps = [
    _App(
      icon: Icons.chat_bubble_rounded,
      title: 'Grok sur X (Twitter)',
      category: 'Officiel xAI',
      description:
          'Grok est intégré directement dans X (anciennement Twitter). '
          'Accessible via le bouton Grok dans la barre latérale ou en mentionnant '
          '@Grok dans un tweet. Répond aux questions et analyse les contenus.',
      tips: [
        'Disponible via l\'application X (iOS / Android / Web)',
        'Abonnement X Premium requis pour l\'accès complet',
        'Mentionnez @Grok dans un tweet pour interagir',
        'Analyse les images et vidéos partagées sur X',
        'Accès aux tendances X en temps réel',
      ],
    ),
    _App(
      icon: Icons.public_outlined,
      title: 'Grok.com — Interface web',
      category: 'Officiel xAI',
      description:
          'Interface web standalone de Grok, indépendante de X. '
          'Offre l\'accès à Grok 3, le mode Think (raisonnement), '
          'Aurora (génération d\'images) et DeepSearch.',
      tips: [
        'Accès : grok.com',
        'Mode Think : raisonnement étape par étape',
        'Aurora : génération d\'images dans le chat',
        'DeepSearch : analyse approfondie multi-sources',
        'Plan gratuit disponible avec limites',
      ],
    ),
    _App(
      icon: Icons.phone_android_outlined,
      title: 'Grok — Application mobile',
      category: 'Officiel xAI',
      description:
          'Application mobile dédiée à Grok pour iOS et Android. '
          'Interface propre et rapide avec accès à tous les modèles xAI, '
          'génération d\'images Aurora et mode vocal.',
      tips: [
        'iOS : App Store → "Grok" par X Corp',
        'Android : Play Store → "Grok"',
        'Mode vocal : conversations orales avec Grok',
        'Génération d\'images Aurora intégrée',
        'Synchronisation avec le compte X',
      ],
    ),
    _App(
      icon: Icons.edit_outlined,
      title: 'Cursor avec Grok',
      category: 'Développement',
      description:
          'Configurez Cursor (éditeur IA basé sur VS Code) pour utiliser '
          'Grok 3 via l\'API xAI. Bénéficiez de l\'accès aux données '
          'récentes pour la recherche de documentation.',
      tips: [
        'Cursor Settings → Models → Custom',
        'Base URL : https://api.x.ai/v1',
        'Model : grok-3 ou grok-3-mini',
        'Clé API xAI commençant par "xai-"',
        'Téléchargement : cursor.sh',
      ],
    ),
    _App(
      icon: Icons.extension_outlined,
      title: 'Continue.dev avec Grok',
      category: 'Développement',
      description:
          'Extension VS Code open source configurable avec l\'API xAI. '
          'Utilisez Grok pour l\'autocomplétion et le chat dans votre '
          'éditeur, avec accès aux informations récentes.',
      tips: [
        'Extension VS Code : "Continue"',
        'config.json : provider "openai" + base_url xAI',
        'Model : grok-3-mini pour l\'autocomplétion',
        'Open source : github.com/continuedev/continue',
        'Gratuit avec votre clé API xAI',
      ],
    ),
    _App(
      icon: Icons.hub_outlined,
      title: 'LangChain + Grok',
      category: 'Développement',
      description:
          'Intégrez Grok dans vos pipelines LangChain via la compatibilité '
          'OpenAI de l\'API xAI. Créez des agents IA avec accès '
          'aux données X en temps réel.',
      tips: [
        'pip install langchain-openai',
        'ChatOpenAI(base_url="https://api.x.ai/v1", model="grok-3")',
        'Idéal pour les agents de veille et d\'analyse sociale',
        'Combine avec des vector stores pour le RAG',
        'Documentation : python.langchain.com',
      ],
    ),
    _App(
      icon: Icons.brush_outlined,
      title: 'Aurora — Génération d\'images',
      category: 'Officiel xAI',
      description:
          'Le modèle de génération d\'images de xAI, accessible via Grok.com, '
          'l\'application mobile et l\'API xAI. Produit des images réalistes '
          'avec moins de restrictions que les concurrents.',
      tips: [
        'API : model="grok-2-image"',
        'Endpoint : POST /v1/images/generations',
        'Jusqu\'à 10 images par requête',
        'Styles : réaliste, artistique, illustration, anime',
        'Prix : ~0,07\$/image via API',
      ],
    ),
    _App(
      icon: Icons.search_outlined,
      title: 'DeepSearch — Recherche approfondie',
      category: 'Officiel xAI',
      description:
          'Fonctionnalité de recherche avancée de Grok qui effectue '
          'plusieurs passes de recherche et de raisonnement avant '
          'de formuler une réponse complète et sourcée.',
      tips: [
        'Disponible sur grok.com et l\'application mobile',
        'Idéal pour les sujets complexes et les recherches poussées',
        'Combine sources web + données X en temps réel',
        'Temps de réponse plus long mais plus approfondi',
        'Similaire à Deep Research de Perplexity',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, theme, child) => ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _apps.length,
        itemBuilder: (context, i) => _AppCard(
          app: _apps[i],
          color: context.palette[i % context.palette.length],
        ),
      ),
    );
  }
}

class _AppCard extends StatefulWidget {
  final _App app;
  final Color color;
  const _AppCard({required this.app, required this.color});

  @override
  State<_AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<_AppCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.color;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.withValues(alpha: 0.3)),
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
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.app.icon, color: c, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.app.title,
                            style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: c.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(widget.app.category,
                              style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more, color: c, size: 20),
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
                  Divider(color: c.withValues(alpha: 0.2)),
                  Text(widget.app.description,
                      style: TextStyle(
                          color: context.onSurface.withValues(alpha: 0.8),
                          fontSize: 13, height: 1.5)),
                  const SizedBox(height: 10),
                  ...widget.app.tips.map((tip) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_right, color: c, size: 18),
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

class _App {
  final IconData icon;
  final String title;
  final String category;
  final String description;
  final List<String> tips;

  const _App({
    required this.icon,
    required this.title,
    required this.category,
    required this.description,
    required this.tips,
  });
}

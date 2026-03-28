import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, _, _) => _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildHero(context),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.tipBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.tipBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: context.accentLight, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Grok est le modèle d\'IA développé par xAI (Elon Musk). '
                  'Il est accessible via l\'API x.ai, compatible avec le format OpenAI. '
                  'Grok se distingue par son accès temps réel à X (Twitter) et son ton décalé.',
                  style: TextStyle(color: context.tipText, height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        sectionTitle('Modèles Grok', context),
        _ModelCard(
          name: 'Grok 3',
          id: 'grok-3',
          description: 'Modèle phare de 3ème génération. Raisonnement avancé, contexte étendu. Le plus capable.',
          color: context.palette[0],
          badge: 'Nouveau',
        ),
        _ModelCard(
          name: 'Grok 3 Mini',
          id: 'grok-3-mini',
          description: 'Version compacte de Grok 3. Rapide, efficace, idéal pour les tâches courantes.',
          color: context.palette[1],
          badge: 'Nouveau',
        ),
        _ModelCard(
          name: 'Grok 2',
          id: 'grok-2',
          description: 'Deuxième génération. Excellentes performances sur le raisonnement complexe.',
          color: context.palette[2],
        ),
        _ModelCard(
          name: 'Grok 2 Vision',
          id: 'grok-2-vision',
          description: 'Grok 2 avec capacités multimodales (texte + images).',
          color: context.palette[3],
        ),
        _ModelCard(
          name: 'Grok Beta',
          id: 'grok-beta',
          description: 'Modèle original. Contexte 131 072 tokens. Compatible OpenAI API.',
          color: context.palette[4],
        ),
        sectionTitle('Liens utiles', context),
        _LinkCard(
          icon: Icons.web,
          label: 'xAI Console',
          subtitle: 'console.x.ai',
          url: 'https://console.x.ai',
        ),
        _LinkCard(
          icon: Icons.description_outlined,
          label: 'Documentation API',
          subtitle: 'docs.x.ai',
          url: 'https://docs.x.ai',
        ),
        _LinkCard(
          icon: Icons.key_outlined,
          label: 'Obtenir une clé API',
          subtitle: 'console.x.ai — section API Keys',
          url: 'https://console.x.ai',
        ),
      ],
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.heroGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.psychology_outlined, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('xAI Grok',
                        style: TextStyle(
                            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('Guide complet de l\'API',
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Explorez l\'API Grok : installation, exemples de code, prompts et fonctionnalités avancées.',
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  final String name;
  final String id;
  final String description;
  final Color color;
  final String? badge;
  const _ModelCard({required this.name, required this.id, required this.description, required this.color, this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 15)),
                    if (badge != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(badge!, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ],
                ),
                Text(id,
                    style: TextStyle(
                        color: context.accentMid, fontSize: 11, fontFamily: 'monospace')),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(
                        color: context.onSurface.withValues(alpha: 0.8),
                        fontSize: 13,
                        height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final String url;
  const _LinkCard({required this.icon, required this.label, required this.subtitle, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.accentMid.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: context.accentLight, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(color: context.accentLight, fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: TextStyle(
                          color: context.onSurface.withValues(alpha: 0.6), fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.open_in_new,
                color: context.accentMid.withValues(alpha: 0.6), size: 16),
          ],
        ),
      ),
    );
  }
}

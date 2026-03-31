import 'package:flutter/material.dart';
import '../app_theme.dart';

class AuroraScreen extends StatefulWidget {
  const AuroraScreen({super.key});
  @override
  State<AuroraScreen> createState() => _AuroraScreenState();
}

class _AuroraScreenState extends State<AuroraScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, theme, child) => Column(
        children: [
          Container(
            color: context.cardBg,
            child: TabBar(
              controller: _tab,
              labelColor: context.primary,
              unselectedLabelColor: context.onSurface.withValues(alpha: 0.5),
              indicatorColor: context.primary,
              tabs: const [
                Tab(text: 'Aurora Images'),
                Tab(text: 'Live X Data'),
                Tab(text: 'Grok API'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _AuroraTab(),
                _LiveXTab(),
                _ApiTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab 1 : Aurora (génération d'images) ────────────────────────────────────

class _AuroraTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.primary;
    final c2 = context.secondary;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        sectionTitle('Aurora — Génération d\'images', context),
        _InfoCard(
          icon: Icons.auto_awesome,
          color: c,
          title: 'Qu\'est-ce qu\'Aurora ?',
          body: 'Aurora est le modèle de génération d\'images de xAI, '
              'intégré directement dans Grok. Il produit des images réalistes '
              'et créatives à partir de descriptions textuelles, '
              'en rivalisant avec DALL·E 3 et Midjourney.',
        ),
        const SizedBox(height: 8),
        sectionTitle('Utilisation via API', context),
        _StepCard(
          step: 1,
          color: c,
          title: 'Génération d\'image — Python',
          child: const CodeBlock(
            code: 'from openai import OpenAI\n\n'
                'client = OpenAI(\n'
                '  api_key="xai-votre_cle",\n'
                '  base_url="https://api.x.ai/v1"\n'
                ')\n\n'
                'response = client.images.generate(\n'
                '  model="grok-2-image",\n'
                '  prompt="Un chat astronaute sur la lune, style réaliste",\n'
                '  n=1\n'
                ')\n\n'
                'print(response.data[0].url)',
          ),
        ),
        _StepCard(
          step: 2,
          color: c,
          title: 'Plusieurs images à la fois',
          child: const CodeBlock(
            code: 'response = client.images.generate(\n'
                '  model="grok-2-image",\n'
                '  prompt="Paysage futuriste, style cyberpunk",\n'
                '  n=4  # jusqu\'à 10 images par requête\n'
                ')\n\n'
                'for img in response.data:\n'
                '    print(img.url)',
          ),
        ),
        const SizedBox(height: 8),
        sectionTitle('Capacités Aurora', context),
        _CapabilityCard(
          icon: Icons.landscape_outlined,
          color: c,
          title: 'Réalisme photographique',
          description: 'Aurora excelle dans la génération d\'images photoréalistes : '
              'portraits, paysages, scènes de vie. Qualité comparable '
              'aux meilleurs modèles du marché.',
        ),
        _CapabilityCard(
          icon: Icons.palette_outlined,
          color: c2,
          title: 'Styles artistiques variés',
          description: 'Supporte tous les styles : peinture, illustration, '
              'anime, cyberpunk, surréalisme, minimalisme. '
              'Précisez le style dans votre prompt.',
        ),
        _CapabilityCard(
          icon: Icons.text_fields_outlined,
          color: c,
          title: 'Texte dans les images',
          description: 'Aurora gère bien le texte intégré dans les images '
              '(logos, affiches, panneaux), un point faible de nombreux '
              'modèles concurrents.',
        ),
        _CapabilityCard(
          icon: Icons.lock_open_outlined,
          color: c2,
          title: 'Moins de censure',
          description: 'Aurora applique des restrictions moins strictes '
              'que DALL·E sur le contenu artistique, '
              'permettant des créations plus libres dans le cadre légal.',
        ),
        const SizedBox(height: 8),
        sectionTitle('Conseils de prompts', context),
        _InfoCard(
          icon: Icons.tips_and_updates_outlined,
          color: c,
          title: 'Structurer un bon prompt image',
          body: null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _tip(context, c, 'Sujet + style + ambiance + éclairage'),
              _tip(context, c, '"Ultra-réaliste, 8K, lumière dorée, bokeh"'),
              _tip(context, c, 'Éviter les négations ("sans...", "pas de...")'),
              _tip(context, c, 'Spécifier l\'angle : "vue de face", "plongée"'),
              _tip(context, c, 'Ajouter le medium : "huile sur toile", "photo argentique"'),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _tip(BuildContext ctx, Color c, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.arrow_right, color: c, size: 18),
            const SizedBox(width: 4),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                      color: ctx.onSurface.withValues(alpha: 0.75),
                      fontSize: 13)),
            ),
          ],
        ),
      );
}

// ── Tab 2 : Live X Data ─────────────────────────────────────────────────────

class _LiveXTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.primary;
    final c2 = context.secondary;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        sectionTitle('Accès temps réel à X (Twitter)', context),
        _InfoCard(
          icon: Icons.bolt_outlined,
          color: c,
          title: 'L\'avantage unique de Grok',
          body: 'Grok est le seul LLM grand public avec un accès direct '
              'et en temps réel aux données de X (anciennement Twitter). '
              'Il peut analyser les tendances, les tweets récents, '
              'les posts d\'une personnalité ou les discussions en cours.',
        ),
        const SizedBox(height: 8),
        sectionTitle('Ce que Grok peut faire', context),
        _FeatureCard(
          icon: Icons.trending_up,
          color: c,
          title: 'Tendances en temps réel',
          description: 'Analysez les sujets trending sur X, comprenez pourquoi '
              'un hashtag est populaire, suivez les discussions en cours.',
          example: '"Quels sont les sujets qui buzzent sur X aujourd\'hui en tech ?"',
        ),
        _FeatureCard(
          icon: Icons.person_search_outlined,
          color: c2,
          title: 'Analyse de compte X',
          description: 'Résumez les derniers posts d\'un compte, identifiez '
              'les thèmes récurrents, analysez la communication d\'une marque.',
          example: '"Résume les 10 derniers tweets de @elonmusk"',
        ),
        _FeatureCard(
          icon: Icons.forum_outlined,
          color: c,
          title: 'Sentiment et opinion',
          description: 'Mesurez l\'opinion publique sur X autour d\'un sujet, '
              'd\'un produit ou d\'un événement en temps réel.',
          example: '"Quel est le sentiment général sur X concernant l\'IA générative ?"',
        ),
        _FeatureCard(
          icon: Icons.event_outlined,
          color: c2,
          title: 'Suivi d\'événements',
          description: 'Suivez les réactions en direct à un événement sportif, '
              'une conférence tech, une annonce économique.',
          example: '"Comment X réagit-il à la conférence Apple de ce soir ?"',
        ),
        const SizedBox(height: 8),
        sectionTitle('Via l\'API', context),
        _InfoCard(
          icon: Icons.code_outlined,
          color: c,
          title: 'Activer la recherche Live',
          body: null,
          child: const CodeBlock(
            code: 'response = client.chat.completions.create(\n'
                '  model="grok-3",\n'
                '  messages=[{\n'
                '    "role": "user",\n'
                '    "content": "Quelles sont les dernières nouvelles sur SpaceX ?"\n'
                '  }],\n'
                '  # La recherche X est activée par défaut sur grok-3\n'
                '  # Désactiver avec :\n'
                '  extra_body={"search_enabled": False}\n'
                ')',
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ── Tab 3 : Grok API ────────────────────────────────────────────────────────

class _ApiTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.primary;
    final c2 = context.secondary;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        sectionTitle('Configurer l\'API xAI', context),
        _StepCard(
          step: 1,
          color: c,
          title: 'Obtenir une clé API',
          child: Text(
            'Rendez-vous sur console.x.ai → créez un compte xAI → '
            'API Keys → Create new key. La clé commence par "xai-".',
            style: TextStyle(
                color: context.onSurface.withValues(alpha: 0.8), fontSize: 13),
          ),
        ),
        _StepCard(
          step: 2,
          color: c,
          title: 'Installation (compatible OpenAI)',
          child: const CodeBlock(code: 'pip install openai'),
        ),
        _StepCard(
          step: 3,
          color: c,
          title: 'Premier appel — Python',
          child: const CodeBlock(
            code: 'from openai import OpenAI\n\n'
                'client = OpenAI(\n'
                '  api_key="xai-votre_cle",\n'
                '  base_url="https://api.x.ai/v1"\n'
                ')\n\n'
                'response = client.chat.completions.create(\n'
                '  model="grok-3",\n'
                '  messages=[\n'
                '    {"role": "system", "content": "Tu es Grok, un assistant IA de xAI."},\n'
                '    {"role": "user", "content": "Explique l\'architecture Transformer"}\n'
                '  ]\n'
                ')\n'
                'print(response.choices[0].message.content)',
          ),
        ),
        _StepCard(
          step: 4,
          color: c,
          title: 'Mode raisonnement (Grok-3 Think)',
          child: const CodeBlock(
            code: 'response = client.chat.completions.create(\n'
                '  model="grok-3-mini",\n'
                '  messages=[{"role": "user", "content": "Prouve que √2 est irrationnel"}],\n'
                '  extra_body={"reasoning_effort": "high"}  # low | high\n'
                ')',
          ),
        ),
        const SizedBox(height: 8),
        sectionTitle('Modèles disponibles', context),
        _ModelRow(color: c,  name: 'grok-3',          ctx: '131K', note: 'Flagship — meilleur'),
        _ModelRow(color: c2, name: 'grok-3-mini',     ctx: '131K', note: 'Rapide + raisonnement'),
        _ModelRow(color: c,  name: 'grok-3-fast',     ctx: '131K', note: 'Ultra rapide'),
        _ModelRow(color: c2, name: 'grok-2-image',    ctx: '—',    note: 'Génération d\'images Aurora'),
        const SizedBox(height: 8),
        sectionTitle('Tarification', context),
        _InfoCard(
          icon: Icons.attach_money,
          color: c,
          title: 'Prix par 1M tokens',
          body: null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _priceRow(context, c,  'grok-3',       '3\$',    '15\$'),
              _priceRow(context, c2, 'grok-3-mini',  '0,30\$', '0,50\$'),
              _priceRow(context, c,  'grok-3-fast',  '5\$',    '25\$'),
              _priceRow(context, c2, 'grok-2-image', '—',      '0,07\$/image'),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _priceRow(BuildContext ctx, Color c, String model, String input, String output) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Container(width: 8, height: 8,
                decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(model,
                  style: TextStyle(color: c, fontSize: 12,
                      fontWeight: FontWeight.w600, fontFamily: 'monospace')),
            ),
            Text('In: $input',
                style: TextStyle(
                    color: ctx.onSurface.withValues(alpha: 0.65), fontSize: 11)),
            const SizedBox(width: 10),
            Text('Out: $output',
                style: TextStyle(
                    color: ctx.onSurface.withValues(alpha: 0.65), fontSize: 11)),
          ],
        ),
      );
}

// ── Shared widgets ──────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? body;
  final Widget? child;

  const _InfoCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                    style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ],
          ),
          if (body != null) ...[
            const SizedBox(height: 10),
            Text(body!, style: TextStyle(
                color: context.onSurface.withValues(alpha: 0.8), fontSize: 13, height: 1.5)),
          ],
          if (child != null) ...[const SizedBox(height: 10), child!],
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int step;
  final Color color;
  final String title;
  final Widget child;

  const _StepCard({required this.step, required this.color, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.2), shape: BoxShape.circle),
            child: Center(
              child: Text('$step',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CapabilityCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const _CapabilityCard({required this.icon, required this.color, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                Text(description, style: TextStyle(
                    color: context.onSurface.withValues(alpha: 0.75), fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final String example;

  const _FeatureCard({required this.icon, required this.color, required this.title, required this.description, required this.example});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                    style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: TextStyle(
              color: context.onSurface.withValues(alpha: 0.8), fontSize: 13, height: 1.4)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.format_quote, color: color, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(example, style: TextStyle(
                      color: color, fontSize: 12, fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModelRow extends StatelessWidget {
  final Color color;
  final String name;
  final String ctx;
  final String note;

  const _ModelRow({required this.color, required this.name, required this.ctx, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(width: 8, height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(name, style: TextStyle(
                color: color, fontWeight: FontWeight.w600, fontSize: 12, fontFamily: 'monospace')),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(ctx, style: TextStyle(color: color, fontSize: 10)),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(note, textAlign: TextAlign.right,
                style: TextStyle(
                    color: context.onSurface.withValues(alpha: 0.55), fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

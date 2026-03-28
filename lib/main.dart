import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/installation_screen.dart';
import 'screens/api_screen.dart';
import 'screens/prompts_screen.dart';
import 'screens/features_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/playground_screen.dart';

class AppThemes {
  static ThemeData get darkGray => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4A4A4A),
          secondary: Color(0xFFB0B0B0),
          surface: Color(0xFF0A0A0A),
          onPrimary: Colors.white,
          onSurface: Color(0xFFE0E0E0),
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF1A1A1A)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: const CardThemeData(color: Color(0xFF1A1A1A), elevation: 2),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(const Color(0xFFB0B0B0)),
          trackColor: WidgetStateProperty.all(const Color(0xFF4A4A4A)),
        ),
      );

  static ThemeData get lightGray => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF424242),
          secondary: Color(0xFF212121),
          surface: Color(0xFFF5F5F5),
          onPrimary: Colors.white,
          onSurface: Color(0xFF212121),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFFFFFFFF)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Color(0xFF212121),
          elevation: 0,
        ),
        cardTheme: const CardThemeData(color: Color(0xFFFFFFFF), elevation: 2),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(const Color(0xFF212121)),
          trackColor: WidgetStateProperty.all(const Color(0xFF9E9E9E)),
        ),
      );
}

class ThemeConfig {
  final Color primary;
  final Color accent;
  final Color drawerBg;
  final Color divider;
  final Color selectedTile;
  final Color indicator;
  final Color footerText;
  final Color titleColor;
  final List<Color> headerGradient;
  final List<NavItem> navItems;

  const ThemeConfig({
    required this.primary,
    required this.accent,
    required this.drawerBg,
    required this.divider,
    required this.selectedTile,
    required this.indicator,
    required this.footerText,
    required this.titleColor,
    required this.headerGradient,
    required this.navItems,
  });

  static const darkGray = ThemeConfig(
    primary: Color(0xFF4A4A4A),
    accent: Color(0xFFB0B0B0),
    drawerBg: Color(0xFF1A1A1A),
    divider: Color(0xFF2D2D2D),
    selectedTile: Color(0xFF3A3A3A),
    indicator: Color(0xFFB0B0B0),
    footerText: Color(0xFF5A5A5A),
    titleColor: Colors.white,
    headerGradient: [Color(0xFF000000), Color(0xFF1C1C1C), Color(0xFF333333)],
    navItems: [
      NavItem(icon: Icons.home_outlined,         label: 'Accueil',         color: Color(0xFFB0B0B0)),
      NavItem(icon: Icons.download_outlined,     label: 'Installation',    color: Color(0xFF9E9E9E)),
      NavItem(icon: Icons.code_outlined,         label: 'API & Code',      color: Color(0xFF808080)),
      NavItem(icon: Icons.auto_awesome_outlined, label: 'Prompts',         color: Color(0xFFB0B0B0)),
      NavItem(icon: Icons.star_outline,          label: 'Fonctionnalités', color: Color(0xFF9E9E9E)),
      NavItem(icon: Icons.chat_bubble_outline,   label: 'Chat Grok',       color: Color(0xFFB0B0B0)),
      NavItem(icon: Icons.science_outlined,      label: 'Playground',      color: Color(0xFF9E9E9E)),
    ],
  );

  static const lightGray = ThemeConfig(
    primary: Color(0xFF424242),
    accent: Color(0xFF212121),
    drawerBg: Color(0xFFFFFFFF),
    divider: Color(0xFFE0E0E0),
    selectedTile: Color(0xFF424242),
    indicator: Color(0xFF212121),
    footerText: Color(0xFF9E9E9E),
    titleColor: Colors.white,
    headerGradient: [Color(0xFF212121), Color(0xFF424242), Color(0xFF616161)],
    navItems: [
      NavItem(icon: Icons.home_outlined,         label: 'Accueil',         color: Color(0xFF424242)),
      NavItem(icon: Icons.download_outlined,     label: 'Installation',    color: Color(0xFF616161)),
      NavItem(icon: Icons.code_outlined,         label: 'API & Code',      color: Color(0xFF424242)),
      NavItem(icon: Icons.auto_awesome_outlined, label: 'Prompts',         color: Color(0xFF757575)),
      NavItem(icon: Icons.star_outline,          label: 'Fonctionnalités', color: Color(0xFF212121)),
      NavItem(icon: Icons.chat_bubble_outline,   label: 'Chat Grok',       color: Color(0xFF424242)),
      NavItem(icon: Icons.science_outlined,      label: 'Playground',      color: Color(0xFF616161)),
    ],
  );
}

void main() {
  runApp(const GrokGuideApp());
}

class GrokGuideApp extends StatelessWidget {
  const GrokGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, theme, _) {
        return MaterialApp(
          title: 'Grok Guide',
          debugShowCheckedModeBanner: false,
          theme: theme == AppTheme.darkGray ? AppThemes.darkGray : AppThemes.lightGray,
          home: const MainScaffold(),
        );
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    InstallationScreen(),
    ApiScreen(),
    PromptsScreen(),
    FeaturesScreen(),
    ChatScreen(),
    PlaygroundScreen(),
  ];

  static const _titles = [
    'Accueil',
    'Installation',
    'API & Code',
    'Prompts',
    'Fonctionnalités',
    'Chat Grok',
    'Playground',
  ];

  ThemeConfig get _cfg =>
      themeNotifier.value == AppTheme.darkGray ? ThemeConfig.darkGray : ThemeConfig.lightGray;

  @override
  void initState() {
    super.initState();
    grokNavIndex.addListener(_onNavChange);
  }

  @override
  void dispose() {
    grokNavIndex.removeListener(_onNavChange);
    super.dispose();
  }

  void _onNavChange() {
    if (grokNavIndex.value != _currentIndex) {
      setState(() => _currentIndex = grokNavIndex.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, _, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            _titles[_currentIndex],
            style: TextStyle(fontWeight: FontWeight.bold, color: _cfg.titleColor),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _cfg.headerGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Switch(
                value: themeNotifier.value == AppTheme.lightGray,
                onChanged: (v) => themeNotifier.value =
                    v ? AppTheme.lightGray : AppTheme.darkGray,
                activeThumbColor: const Color(0xFF212121),
                activeTrackColor: const Color(0xFF9E9E9E),
                inactiveThumbColor: const Color(0xFFB0B0B0),
                inactiveTrackColor: const Color(0xFF4A4A4A),
              ),
            ),
          ],
        ),
        drawer: _buildDrawer(context),
        body: _screens[_currentIndex],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final cfg = _cfg;
    return Drawer(
      backgroundColor: cfg.drawerBg,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: cfg.headerGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.psychology_outlined, color: Colors.white, size: 28),
                    ),
                    const SizedBox(height: 12),
                    const Text('Grok Guide',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Guide complet xAI Grok',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: cfg.navItems.length,
              itemBuilder: (context, index) {
                final item = cfg.navItems[index];
                final isSelected = _currentIndex == index;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? cfg.selectedTile.withValues(alpha: 0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(item.icon,
                        color: isSelected ? item.color : item.color.withValues(alpha: 0.5)),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        color: isSelected
                            ? item.color
                            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    trailing: isSelected
                        ? Container(
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              color: cfg.indicator,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                        : null,
                    onTap: () {
                      setState(() => _currentIndex = index);
                      grokNavIndex.value = index;
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
          Divider(color: cfg.divider, height: 1),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Grok Guide v2.0',
                  style: TextStyle(color: cfg.footerText, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final Color color;
  const NavItem({required this.icon, required this.label, required this.color});
}

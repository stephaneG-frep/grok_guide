import 'package:flutter/material.dart';

final themeNotifier = ValueNotifier<AppTheme>(AppTheme.darkGray);
final grokNavIndex = ValueNotifier<int>(0);
final pendingPromptNotifier = ValueNotifier<String?>(null);
enum AppTheme { darkGray, lightGray }

extension AppThemeExt on BuildContext {
  bool get isLight => themeNotifier.value == AppTheme.lightGray;

  Color get primary => Theme.of(this).colorScheme.primary;
  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get cardBg => isLight ? const Color(0xFFFFFFFF) : const Color(0xFF1A1A1A);
  Color get codeBg => isLight ? const Color(0xFFF0F0F0) : const Color(0xFF0D0D0D);
  Color get codeHeader => isLight ? const Color(0xFFE0E0E0) : const Color(0xFF1A1A1A);
  Color get accentLight => isLight ? const Color(0xFF424242) : const Color(0xFFB0B0B0);
  Color get accentMid => isLight ? const Color(0xFF212121) : const Color(0xFF757575);
  Color get surfaceBg => isLight ? const Color(0xFFF5F5F5) : const Color(0xFF0A0A0A);
  Color get codeText => isLight ? const Color(0xFF424242) : const Color(0xFFB0B0B0);
  Color get codeBorder => isLight ? const Color(0xFFBDBDBD) : const Color(0xFF2D2D2D);
  Color get tipBg => isLight ? const Color(0xFFFAFAFA) : const Color(0xFF1A1A1A);
  Color get tipBorder => isLight ? const Color(0xFFBDBDBD) : const Color(0xFF3A3A3A);
  Color get tipText => isLight ? const Color(0xFF616161) : const Color(0xFF9E9E9E);
  Color get drawerDivider => isLight ? const Color(0xFFE0E0E0) : const Color(0xFF2D2D2D);
  Color get onSurface => isLight ? const Color(0xFF212121) : const Color(0xFFE0E0E0);

  List<Color> get heroGradient => isLight
      ? [const Color(0xFF212121), const Color(0xFF424242), const Color(0xFF616161)]
      : [const Color(0xFF000000), const Color(0xFF1C1C1C), const Color(0xFF333333)];

  List<Color> get palette => isLight
      ? [
          const Color(0xFF424242),
          const Color(0xFF616161),
          const Color(0xFF757575),
          const Color(0xFF212121),
          const Color(0xFF9E9E9E),
          const Color(0xFF4A4A4A),
        ]
      : [
          const Color(0xFF757575),
          const Color(0xFF9E9E9E),
          const Color(0xFF616161),
          const Color(0xFFB0B0B0),
          const Color(0xFF4A4A4A),
          const Color(0xFF808080),
        ];
}

Widget sectionTitle(String text, BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: context.accentLight,
        ),
      ),
    );

class CodeBlock extends StatelessWidget {
  final String code;
  final String? title;
  const CodeBlock({super.key, required this.code, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.codeBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.codeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: context.codeHeader,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title!,
                      style: TextStyle(
                          color: context.accentLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  IconButton(
                    icon: Icon(Icons.copy, size: 16, color: context.accentLight),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SelectableText(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: context.codeText,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

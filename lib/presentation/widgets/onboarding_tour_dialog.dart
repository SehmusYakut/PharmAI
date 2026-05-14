import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';

class OnboardingTourDialog extends StatefulWidget {
  const OnboardingTourDialog({super.key});

  @override
  State<OnboardingTourDialog> createState() => _OnboardingTourDialogState();
}

class _OnboardingTourDialogState extends State<OnboardingTourDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goNext(int pageCount) async {
    if (_currentPage >= pageCount - 1) {
      Navigator.of(context).pop(true);
      return;
    }
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _goBack() async {
    if (_currentPage == 0) return;
    await _pageController.previousPage(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pages = <_OnboardingPageData>[
      _OnboardingPageData(
        icon: Icons.auto_awesome_rounded,
        title: l10n.onboardingStepWelcomeTitle,
        description: l10n.onboardingStepWelcomeDescription,
      ),
      _OnboardingPageData(
        icon: Icons.search_rounded,
        title: l10n.onboardingStepIcdTitle,
        description: l10n.onboardingStepIcdDescription,
      ),
      _OnboardingPageData(
        icon: Icons.medication_rounded,
        title: l10n.onboardingStepDrugTitle,
        description: l10n.onboardingStepDrugDescription,
      ),
      _OnboardingPageData(
        icon: Icons.calculate_rounded,
        title: l10n.onboardingStepCalcTitle,
        description: l10n.onboardingStepCalcDescription,
      ),
    ];

    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final isLast = _currentPage == pages.length - 1;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.surface.withValues(alpha: 0.94),
                    colors.surfaceContainerHigh.withValues(alpha: 0.92),
                  ],
                ),
                border: Border.all(
                  color: colors.outlineVariant.withValues(alpha: 0.45),
                ),
              ),
              child: SafeArea(
                top: false,
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.onboardingTitle,
                              style: text.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(l10n.onboardingSkip),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 280,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: pages.length,
                          onPageChanged: (value) {
                            setState(() => _currentPage = value);
                          },
                          itemBuilder: (context, index) {
                            final page = pages[index];
                            return _OnboardingStepCard(page: page);
                          },
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          for (var i = 0; i < pages.length; i++) ...[
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              margin: const EdgeInsets.only(right: 6),
                              width: _currentPage == i ? 22 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentPage == i
                                    ? colors.primary
                                    : colors.outlineVariant,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ],
                          const Spacer(),
                          if (_currentPage > 0)
                            OutlinedButton(
                              onPressed: _goBack,
                              child: Text(l10n.onboardingBack),
                            ),
                          if (_currentPage > 0) const SizedBox(width: 8),
                          FilledButton(
                            onPressed: () => _goNext(pages.length),
                            child: Text(
                              isLast
                                  ? l10n.onboardingDone
                                  : l10n.onboardingNext,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingStepCard extends StatelessWidget {
  const _OnboardingStepCard({required this.page});

  final _OnboardingPageData page;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: colors.surfaceContainerLowest.withValues(alpha: 0.8),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.primary.withValues(alpha: 0.12),
            ),
            child: Icon(page.icon, color: colors.primary, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            page.title,
            style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(
            page.description,
            style: text.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

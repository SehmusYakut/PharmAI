import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_bloc.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_event.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_state.dart';
import 'package:pharmai/presentation/widgets/adaptive_search_field.dart';
import 'package:pharmai/presentation/widgets/drug_detail_card.dart';

class DrugInfoPage extends StatefulWidget {
  const DrugInfoPage({super.key, this.initialQuery});

  final String? initialQuery;

  @override
  State<DrugInfoPage> createState() => _DrugInfoPageState();
}

class _DrugInfoPageState extends State<DrugInfoPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<DrugSearchBloc>().add(
            DrugSearchQueryChanged(widget.initialQuery!),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navDrugInfo)),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: RefreshIndicator.adaptive(
          onRefresh: _refreshCurrentQuery,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                sliver: SliverToBoxAdapter(
                  child: AdaptiveSearchField(
                    controller: _controller,
                    onChanged: (value) => context.read<DrugSearchBloc>().add(
                      DrugSearchQueryChanged(value),
                    ),
                    placeholder: l10n.drugSearchPlaceholder,
                    clearTooltip: l10n.searchClear,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                sliver: SliverToBoxAdapter(
                  child: _SearchPromptCard(l10n: l10n),
                ),
              ),
              BlocBuilder<DrugSearchBloc, DrugSearchState>(
                builder: (context, state) => switch (state) {
                  DrugSearchInitial() => SliverFillRemaining(
                    hasScrollBody: false,
                    child: _HintView(l10n: l10n),
                  ),
                  DrugSearchLoading() => const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    sliver: SliverToBoxAdapter(child: _LoadingSkeletonList()),
                  ),
                  DrugSearchLoaded(:final results) => SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => DrugDetailCard(
                          key: ValueKey(
                            results[index].barcode.isEmpty
                                ? results[index].productName
                                : results[index].barcode,
                          ),
                          drug: results[index],
                        ),
                        childCount: results.length,
                      ),
                    ),
                  ),
                  DrugSearchEmpty(:final query) => SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyView(query: query, l10n: l10n),
                  ),
                  DrugSearchError(:final message) => SliverFillRemaining(
                    hasScrollBody: false,
                    child: _ErrorView(message: message),
                  ),
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshCurrentQuery() async {
    final query = _controller.text.trim();
    if (query.length < AppConstants.minSearchLength) return;

    context.read<DrugSearchBloc>().add(DrugSearchQueryChanged(query));
    await Future<void>.delayed(
      const Duration(milliseconds: AppConstants.icd10SearchDebounceMs + 140),
    );
  }
}

// ── Helper views ───────────────────────────────────────────────────────────────

class _SearchPromptCard extends StatelessWidget {
  const _SearchPromptCard({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(Icons.medication_rounded, color: colors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.drugSearchHint,
                  style: text.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.drugSearchHintExample,
                  style: text.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HintView extends StatelessWidget {
  const _HintView({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.45),
            ),
          ),
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.medication_outlined, size: 56, color: colors.outline),
              const SizedBox(height: 16),
              Text(
                l10n.drugSearchHint,
                style: text.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                l10n.drugSearchHintExample,
                style: text.bodySmall?.copyWith(color: colors.outline),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingSkeletonList extends StatefulWidget {
  const _LoadingSkeletonList();

  @override
  State<_LoadingSkeletonList> createState() => _LoadingSkeletonListState();
}

class _LoadingSkeletonListState extends State<_LoadingSkeletonList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          children: List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ShimmerPanel(
                progress: (_controller.value + index * 0.18) % 1.0,
                baseColor: colors.surfaceContainerHighest.withValues(
                  alpha: 0.55,
                ),
                highlightColor: colors.surfaceContainerLowest.withValues(
                  alpha: 0.9,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.query, required this.l10n});
  final String query;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.45),
            ),
          ),
          padding: const EdgeInsets.all(22),
          child: Text(
            l10n.searchEmpty(query),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.error.withValues(alpha: 0.25),
            ),
          ),
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerPanel extends StatelessWidget {
  const _ShimmerPanel({
    required this.progress,
    required this.baseColor,
    required this.highlightColor,
  });

  final double progress;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(18),
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          final start = -1.0 + (progress * 2.0);
          return LinearGradient(
            begin: Alignment(start, -0.2),
            end: Alignment(start + 1.0, 0.2),
            colors: [baseColor, highlightColor, baseColor],
            stops: const [0.25, 0.5, 0.75],
          ).createShader(bounds);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 190,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

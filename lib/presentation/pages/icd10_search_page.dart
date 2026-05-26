import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // context.pop()
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_cubit.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_state.dart';
import 'package:pharmai/presentation/widgets/adaptive_search_field.dart';
import 'package:pharmai/presentation/widgets/icd10_result_card.dart';

/// ICD-10 Search page.
///
/// Adaptive design:
///   • iOS   – [CupertinoNavigationBar] + [BouncingScrollPhysics]
///   • Other – [AppBar] (Material 3) + [ClampingScrollPhysics]
///
/// Focus strategy:
///   A [FocusNode] is created in [State] and [requestFocus] is called via
///   [WidgetsBinding.addPostFrameCallback] so focus is set after the route
///   transition completes.  This eliminates the dropped-first-keystroke bug
///   caused by [autofocus] racing with the IME initialisation on Android.
class Icd10SearchPage extends StatefulWidget {
  const Icd10SearchPage({super.key});

  @override
  State<Icd10SearchPage> createState() => _Icd10SearchPageState();
}

class _Icd10SearchPageState extends State<Icd10SearchPage> {
  final _queryController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Delay focus request until after the first frame so the route animation
    // has settled and the OS IME is ready — prevents dropped first keystroke.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent * 0.9) {
      context.read<Icd10SearchCubit>().loadMore();
    }
  }

  bool get _isIOS => Theme.of(context).platform == TargetPlatform.iOS;

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return _isIOS ? _buildCupertinoScaffold() : _buildMaterialScaffold();
  }

  // ── iOS scaffold ────────────────────────────────────────────────────────────

  Widget _buildCupertinoScaffold() {
    final l10n = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.icd10SearchTitle),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          child: Text(l10n.searchBack),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _onClear,
          child: Text(l10n.searchClear),
        ),
      ),
      child: GestureDetector(
        onTap: () => _focusNode.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: AdaptiveSearchField(
                  controller: _queryController,
                  focusNode: _focusNode,
                  onChanged: _onQueryChanged,
                  placeholder: l10n.searchPlaceholder,
                  clearTooltip: l10n.searchClear,
                ),
              ),
              Expanded(
                child: _buildBody(physics: const BouncingScrollPhysics()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Material scaffold ───────────────────────────────────────────────────────

  Widget _buildMaterialScaffold() {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.icd10SearchTitle),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: AdaptiveSearchField(
              controller: _queryController,
              focusNode: _focusNode,
              onChanged: _onQueryChanged,
              placeholder: l10n.searchPlaceholder,
              clearTooltip: l10n.searchClear,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => _focusNode.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: _buildBody(physics: const ClampingScrollPhysics()),
      ),
    );
  }

  // ── Body ────────────────────────────────────────────────────────────────────

  Widget _buildBody({required ScrollPhysics physics}) {
    return BlocBuilder<Icd10SearchCubit, Icd10SearchState>(
      builder: (context, state) {
        return RefreshIndicator.adaptive(
          onRefresh: _refreshCurrentQuery,
          child: CustomScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(parent: physics),
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              ..._buildStateSlivers(state),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        );
      },
    );
  }

  Future<void> _refreshCurrentQuery() async {
    final query = _queryController.text.trim();
    if (query.isEmpty) return;

    context.read<Icd10SearchCubit>().onQueryChanged(query);
    await Future<void>.delayed(
      const Duration(milliseconds: AppConstants.icd10SearchDebounceMs + 140),
    );
  }

  List<Widget> _buildStateSlivers(Icd10SearchState state) => switch (state) {
    Icd10SearchInitial() => [
      const SliverFillRemaining(hasScrollBody: false, child: _HintView()),
    ],
    Icd10SearchLoading() => [
      const SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        sliver: SliverToBoxAdapter(child: _LoadingSkeletonList()),
      ),
    ],
    Icd10SearchEmpty(:final query) => [
      SliverFillRemaining(
        hasScrollBody: false,
        child: _EmptyView(query: query),
      ),
    ],
    Icd10SearchError(:final message) => [
      SliverFillRemaining(
        hasScrollBody: false,
        child: _ErrorView(message: message),
      ),
    ],
    Icd10SearchLoaded() => [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index >= state.results.length) {
              return const _LoadMoreIndicator();
            }
            return Icd10ResultCard(
              key: ValueKey(state.results[index].code),
              code: state.results[index],
              highlight: state.query,
            );
          }, childCount: state.results.length + (state.canLoadMore ? 1 : 0)),
        ),
      ),
    ],
  };

  void _onQueryChanged(String value) {
    context.read<Icd10SearchCubit>().onQueryChanged(value);
  }

  void _onClear() {
    _queryController.clear();
    context.read<Icd10SearchCubit>().clear();
  }
}

// ── State-specific views ──────────────────────────────────────────────────────

class _HintView extends StatelessWidget {
  const _HintView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primary.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.manage_search_rounded,
                  size: 34,
                  color: colors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.searchHint,
                style: text.titleMedium?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.searchHintExample,
                style: text.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
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
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ShimmerPanel(
                progress: (_controller.value + index * 0.16) % 1.0,
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
  const _EmptyView({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 64,
                color: colors.outlineVariant,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.searchEmpty(query),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
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
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.error.withValues(alpha: 0.25)),
          ),
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, size: 64, color: colors.error),
              const SizedBox(height: 12),
              Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: colors.error),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadMoreIndicator extends StatelessWidget {
  const _LoadMoreIndicator();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: SizedBox(
          width: 44,
          height: 44,
          child: CircularProgressIndicator(
            strokeWidth: 2.6,
            color: colors.primary,
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
              width: 84,
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
              width: 220,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 84,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 54,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

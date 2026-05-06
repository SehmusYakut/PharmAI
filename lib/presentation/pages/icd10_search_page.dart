import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
          onPressed: () => context.go('/'),
          child: Text(l10n.searchBack),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _onClear,
          child: Text(l10n.searchClear),
        ),
      ),
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
              ),
            ),
            Expanded(child: _buildBody(physics: const BouncingScrollPhysics())),
          ],
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: AdaptiveSearchField(
              controller: _queryController,
              focusNode: _focusNode,
              onChanged: _onQueryChanged,
              placeholder: l10n.searchPlaceholder,
            ),
          ),
        ),
      ),
      body: _buildBody(physics: const ClampingScrollPhysics()),
    );
  }

  // ── Body ────────────────────────────────────────────────────────────────────

  Widget _buildBody({required ScrollPhysics physics}) {
    return BlocConsumer<Icd10SearchCubit, Icd10SearchState>(
      listener: (context, state) {
        if (state is Icd10SearchInitial && _queryController.text.isNotEmpty) {
          _queryController.clear();
        }
      },
      builder: (context, state) {
        return switch (state) {
          Icd10SearchInitial() => const _HintView(),
          Icd10SearchLoading() => const _LoadingView(),
          Icd10SearchEmpty(:final query) => _EmptyView(query: query),
          Icd10SearchError(:final message) => _ErrorView(message: message),
          Icd10SearchLoaded() => _ResultsList(
            state: state,
            scrollController: _scrollController,
            physics: physics,
          ),
        };
      },
    );
  }

  void _onQueryChanged(String value) {
    context.read<Icd10SearchCubit>().onQueryChanged(value);
  }

  void _onClear() {
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.manage_search_rounded,
            size: 72,
            color: colors.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.searchHint,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.searchHintExample,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: colors.outline),
          ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
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
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 64, color: colors.error),
            const SizedBox(height: 12),
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: colors.error),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Results list ──────────────────────────────────────────────────────────────

class _ResultsList extends StatelessWidget {
  const _ResultsList({
    required this.state,
    required this.scrollController,
    required this.physics,
  });

  final Icd10SearchLoaded state;
  final ScrollController scrollController;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    final results = state.results;
    final itemCount = results.length + (state.canLoadMore ? 1 : 0);

    return ListView.builder(
      controller: scrollController,
      physics: physics,
      cacheExtent: 480,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= results.length) {
          return const _LoadMoreIndicator();
        }
        return Icd10ResultCard(
          key: ValueKey(results[index].code),
          code: results[index],
          highlight: state.query,
        );
      },
    );
  }
}

class _LoadMoreIndicator extends StatelessWidget {
  const _LoadMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

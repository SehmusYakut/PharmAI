import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/domain/entities/icd10_code.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_cubit.dart';
import 'package:pharmai/presentation/bloc/icd10_search/icd10_search_state.dart';
import 'package:pharmai/presentation/widgets/adaptive_search_field.dart';
import 'package:pharmai/presentation/widgets/icd10_code_tile.dart';

/// ICD-10 Search page.
///
/// Adaptive design:
///   • iOS   – [CupertinoNavigationBar] + [BouncingScrollPhysics]
///   • Other – [AppBar] (Material 3) + [ClampingScrollPhysics]
///
/// Lazy loading:
///   [ListView.builder] only builds widgets for visible items.
///   A [ScrollController] fires [Icd10SearchCubit.loadMore] when the user
///   reaches 90 % of the scroll extent.
class Icd10SearchPage extends StatefulWidget {
  const Icd10SearchPage({super.key});

  @override
  State<Icd10SearchPage> createState() => _Icd10SearchPageState();
}

class _Icd10SearchPageState extends State<Icd10SearchPage> {
  final _queryController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController.dispose();
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('ICD-10 Search'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _onClear,
          child: const Text('Clear'),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: AdaptiveSearchField(
                controller: _queryController,
                onChanged: _onQueryChanged,
                placeholder: 'ICD-10 kodu veya tanım ara…',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('ICD-10 Ara'),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: AdaptiveSearchField(
              controller: _queryController,
              onChanged: _onQueryChanged,
              placeholder: 'ICD-10 kodu veya tanım ara…',
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
      // Clear the text field when the cubit is reset externally.
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
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.manage_search_rounded, size: 72, color: colors.outlineVariant),
          const SizedBox(height: 16),
          Text(
            'ICD-10 kodu veya tanımını girin',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Örn: "E11", "diabetes", "J00"',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.outline,
                ),
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
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: colors.outlineVariant),
          const SizedBox(height: 12),
          Text(
            '"$query" için sonuç bulunamadı',
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
    // Extra slot at the end for the load-more indicator.
    final itemCount = results.length + (state.canLoadMore ? 1 : 0);

    return ListView.separated(
      controller: scrollController,
      physics: physics,
      // cacheExtent ensures widgets are pre-built before they scroll into view,
      // giving smoother lazy-loading performance.
      cacheExtent: 480,
      itemCount: itemCount,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 84),
      itemBuilder: (context, index) {
        if (index >= results.length) {
          return const _LoadMoreIndicator();
        }
        return Icd10CodeTile(
          key: ValueKey(results[index].code),
          code: results[index],
          highlight: state.query,
          onTap: () => _onTap(context, results[index]),
        );
      },
    );
  }

  void _onTap(BuildContext context, Icd10Code code) {
    // Detail page navigation will be added in a future sprint.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${code.code} – ${code.descriptionTr}'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_bloc.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_event.dart';
import 'package:pharmai/presentation/bloc/drug_search/drug_search_state.dart';
import 'package:pharmai/presentation/widgets/drug_detail_card.dart';

class DrugInfoPage extends StatefulWidget {
  const DrugInfoPage({super.key});

  @override
  State<DrugInfoPage> createState() => _DrugInfoPageState();
}

class _DrugInfoPageState extends State<DrugInfoPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navDrugInfo),
      ),
      body: Column(
        children: [
          // ── Search field ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _controller,
              autofocus: false,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: l10n.drugSearchPlaceholder,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (_, val, _) => val.text.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          tooltip: l10n.searchClear,
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _controller.clear();
                            context
                                .read<DrugSearchBloc>()
                                .add(const DrugSearchCleared());
                          },
                        ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => context
                  .read<DrugSearchBloc>()
                  .add(DrugSearchQueryChanged(v)),
            ),
          ),

          // ── Results ───────────────────────────────────────────────────────
          Expanded(
            child: BlocBuilder<DrugSearchBloc, DrugSearchState>(
              builder: (context, state) => switch (state) {
                DrugSearchInitial() => _HintView(l10n: l10n),
                DrugSearchLoading() => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                DrugSearchLoaded(:final results) => ListView.builder(
                    itemCount: results.length,
                    padding: const EdgeInsets.only(bottom: 24),
                    itemBuilder: (_, i) =>
                        DrugDetailCard(drug: results[i]),
                  ),
                DrugSearchEmpty(:final query) => _EmptyView(
                    query: query,
                    l10n: l10n,
                  ),
                DrugSearchError(:final message) => _ErrorView(message: message),
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper views ───────────────────────────────────────────────────────────────

class _HintView extends StatelessWidget {
  const _HintView({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.medication_outlined, size: 56, color: colors.outline),
            const SizedBox(height: 16),
            Text(
              l10n.drugSearchHint,
              style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
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
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.query, required this.l10n});
  final String query;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          l10n.searchEmpty(query),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          textAlign: TextAlign.center,
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
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

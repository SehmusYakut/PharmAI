import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A search input that renders [CupertinoSearchTextField] on iOS and a
/// Material 3 pill-shaped [TextField] on all other platforms.
///
/// The caller owns [controller] so it can programmatically clear the field
/// (e.g. when the user taps the back button or the cubit resets state).
class AdaptiveSearchField extends StatelessWidget {
  const AdaptiveSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.placeholder = 'Search ICD-10…',
    this.autofocus = true,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String placeholder;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? _CupertinoField(
            controller: controller,
            onChanged: onChanged,
            placeholder: placeholder,
            autofocus: autofocus,
          )
        : _MaterialField(
            controller: controller,
            onChanged: onChanged,
            placeholder: placeholder,
            autofocus: autofocus,
          );
  }
}

// ── iOS ────────────────────────────────────────────────────────────────────────

class _CupertinoField extends StatelessWidget {
  const _CupertinoField({
    required this.controller,
    required this.onChanged,
    required this.placeholder,
    required this.autofocus,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String placeholder;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: controller,
      autofocus: autofocus,
      placeholder: placeholder,
      onChanged: onChanged,
      // onSuffixTap fires when the ✕ is tapped; fire onChanged('') so the
      // cubit reacts exactly as if the user had deleted all text.
      onSuffixTap: () {
        controller.clear();
        onChanged('');
      },
    );
  }
}

// ── Material 3 ─────────────────────────────────────────────────────────────────

class _MaterialField extends StatelessWidget {
  const _MaterialField({
    required this.controller,
    required this.onChanged,
    required this.placeholder,
    required this.autofocus,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String placeholder;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      autofocus: autofocus,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: const Icon(Icons.search_rounded),
        // Show clear button only when field has text.
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (_, value, _) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.cancel_rounded),
              tooltip: 'Clear',
              onPressed: () {
                controller.clear();
                onChanged('');
              },
            );
          },
        ),
        filled: true,
        fillColor: colors.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
      onChanged: onChanged,
    );
  }
}

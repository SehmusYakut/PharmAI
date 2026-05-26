import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/entities/chat_session.dart';
import 'package:pharmai/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmai/presentation/bloc/chat/chat_bloc.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key, required this.sessionId});

  final int sessionId;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthBloc>().state;
    if (auth is AuthAuthenticated) {
      context.read<ChatBloc>().add(
        FetchSessions(
          userId: auth.profile.firebaseUid,
          activeSessionId: widget.sessionId,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 120,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatRoomState) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scrollToBottom(),
          );
          final error = _resolveErrorMessage(state, l10n);
          if (error != null && error.isNotEmpty) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(error)));
          }
        }
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading || state is ChatInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is! ChatRoomState) {
            return const Scaffold(body: SizedBox.shrink());
          }

          final title = state.session.title.isEmpty
              ? l10n.chatNewSessionTitle
              : state.session.title;
          final media = MediaQuery.of(context);
          final isWide = media.size.width >= 900;

          final chatContent = Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  itemCount: state.messages.length + (state.isSending ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.messages.length) {
                      return _TypingBubble(label: l10n.chatTyping);
                    }
                    final msg = state.messages[index];
                    final isUser = msg.role == ChatRole.user;
                    return _ChatBubble(message: msg.content, isUser: isUser);
                  },
                ),
              ),
              _ChatComposer(
                controller: _controller,
                onSend: () => _handleSend(context),
                hint: l10n.chatInputHint,
                isSending: state.isSending,
              ),
            ],
          );

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [
                IconButton(
                  tooltip: l10n.chatRenameAction,
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: () =>
                      _openRenameDialog(context, l10n, state.session),
                ),
              ],
            ),
            body: Stack(
              children: [
                if (isWide)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 24, 24),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 420,
                          maxHeight: media.size.height * 0.82,
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          elevation: 8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: chatContent,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  chatContent,
                if (state is PremiumLimitReachedState)
                  _PremiumOverlay(onUpgrade: () => _handleUpgrade(context)),
              ],
            ),
          );
        },
      ),
    );
  }

  String? _resolveErrorMessage(ChatRoomState state, AppLocalizations l10n) {
    switch (state.errorKey) {
      case ChatErrorKey.localSaveFailed:
        return l10n.chatErrorLocalSave;
      case ChatErrorKey.upgradeFailed:
        return l10n.chatErrorUpgrade;
      case ChatErrorKey.renameFailed:
        return l10n.chatErrorRename;
      case null:
        return state.errorMessage;
    }
  }

  Future<void> _openRenameDialog(
    BuildContext context,
    AppLocalizations l10n,
    ChatSession session,
  ) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (_) =>
          _RenameChatDialog(l10n: l10n, initialTitle: session.title),
    );

    final newTitle = result?.trim();
    if (newTitle == null || newTitle.isEmpty) return;

    context.read<ChatBloc>().add(
      RenameSession(sessionId: session.id, newTitle: newTitle),
    );
  }

  void _handleSend(BuildContext context) {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    _controller.clear();

    final auth = context.read<AuthBloc>().state;
    if (auth is! AuthAuthenticated) return;

    context.read<ChatBloc>().add(
      SendMessage(userId: auth.profile.firebaseUid, text: text),
    );
  }

  void _handleUpgrade(BuildContext context) {
    final auth = context.read<AuthBloc>().state;
    if (auth is! AuthAuthenticated) return;

    context.read<ChatBloc>().add(
      UpgradeToPremium(userId: auth.profile.firebaseUid),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message, required this.isUser});

  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final align = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final bg = isUser ? colors.primary : colors.surfaceContainerHigh;
    final fg = isUser ? colors.onPrimary : colors.onSurface;

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: bg.withValues(alpha: 0.18),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: fg, height: 1.4),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 10),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({
    required this.controller,
    required this.onSend,
    required this.hint,
    required this.isSending,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final String hint;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => isSending ? null : onSend(),
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton.filled(
              onPressed: isSending ? null : onSend,
              icon: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumOverlay extends StatelessWidget {
  const _PremiumOverlay({required this.onUpgrade});

  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;

    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          color: Colors.black.withValues(alpha: 0.35),
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.surface.withValues(alpha: 0.9),
                  colors.surfaceContainerHigh.withValues(alpha: 0.85),
                ],
              ),
              border: Border.all(color: colors.primary.withValues(alpha: 0.22)),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.workspace_premium_rounded,
                  size: 44,
                  color: colors.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.chatLimitTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.chatLimitBody,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colors.primary.withValues(alpha: 0.08),
                  ),
                  child: Text(
                    l10n.chatUpgradeSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: onUpgrade,
                  child: Text(l10n.chatGoPremium),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RenameChatDialog extends StatefulWidget {
  const _RenameChatDialog({required this.l10n, required this.initialTitle});

  final AppLocalizations l10n;
  final String initialTitle;

  @override
  State<_RenameChatDialog> createState() => _RenameChatDialogState();
}

class _RenameChatDialogState extends State<_RenameChatDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.surface.withValues(alpha: 0.92),
                  colors.surfaceContainerHigh.withValues(alpha: 0.88),
                ],
              ),
              border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.l10n.chatRenameTitle,
                  style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: widget.l10n.chatRenameHint,
                    filled: true,
                    fillColor: colors.surfaceContainerLowest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => _onSave(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(widget.l10n.chatRenameCancel),
                    ),
                    const SizedBox(width: 8),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _controller,
                      builder: (_, value, __) {
                        final enabled = value.text.trim().isNotEmpty;
                        return FilledButton(
                          onPressed: enabled ? () => _onSave(context) : null,
                          child: Text(widget.l10n.chatRenameSave),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSave(BuildContext context) {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    Navigator.of(context).pop(title);
  }
}

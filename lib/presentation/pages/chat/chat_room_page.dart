import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/domain/entities/chat_message.dart';
import 'package:pharmai/domain/entities/chat_session.dart';
import 'package:pharmai/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmai/presentation/bloc/chat/chat_bloc.dart';
import 'package:pharmai/presentation/bloc/locale/locale_cubit.dart';

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

    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.sessions.any((s) => s.id == widget.sessionId)) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        }
      },
      builder: (context, state) {
        final session = state.sessions.cast<ChatSession?>().firstWhere(
              (s) => s?.id == widget.sessionId,
              orElse: () => null,
            );

        return Scaffold(
          appBar: AppBar(
            title: Text(session?.title ?? l10n.chatNewSessionTitle),
            actions: [
              if (session != null)
                PopupMenuButton<String>(
                  onSelected: (val) {
                    if (val == 'rename') {
                      _openRenameDialog(
                        context.read<ChatBloc>(),
                        l10n,
                        session,
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'rename',
                      child: Row(
                        children: [
                          const Icon(Icons.edit_outlined, size: 20),
                          const SizedBox(width: 12),
                          Text(l10n.chatRenameAction),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: _MessageList(
                  messages: state.messages,
                  isLoading: state.status == ChatStatus.loading,
                ),
              ),
              if (state.status == ChatStatus.typing)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LinearProgressIndicator(minHeight: 2),
                ),
              _ChatInput(
                onSend: () => _handleSend(context),
                controller: _controller,
                enabled: state.status != ChatStatus.loading &&
                    state.status != ChatStatus.typing,
                hintText: l10n.chatInputHint,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openRenameDialog(
    ChatBloc chatBloc,
    AppLocalizations l10n,
    ChatSession session,
  ) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) =>
          _RenameChatDialog(l10n: l10n, initialTitle: session.title),
    );

    final newTitle = result?.trim();
    if (newTitle == null || newTitle.isEmpty) return;

    if (!context.mounted) return;

    chatBloc.add(
      RenameSession(sessionId: session.id, newTitle: newTitle),
    );
  }

  void _handleSend(BuildContext context) {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    _controller.clear();

    final auth = context.read<AuthBloc>().state;
    if (auth is! AuthAuthenticated) return;

    final localeCode = context.read<LocaleCubit>().state.languageCode;
    context.read<ChatBloc>().add(
      SendMessage(
        userId: auth.profile.firebaseUid,
        text: text,
        localeCode: localeCode,
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({required this.messages, required this.isLoading});
  final List<ChatMessage> messages;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading && messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (messages.isEmpty) {
      return Center(
        child: Icon(
          Icons.chat_bubble_outline,
          size: 48,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) => _MessageBubble(message: messages[index]),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isMe = message.isUser;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isMe ? colors.primary : colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(18).copyWith(
            bottomRight: isMe ? const Radius.circular(2) : null,
            bottomLeft: !isMe ? const Radius.circular(2) : null,
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: isMe ? colors.onPrimary : colors.onSurface),
        ),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  const _ChatInput({
    required this.onSend,
    required this.controller,
    required this.enabled,
    required this.hintText,
  });

  final VoidCallback onSend;
  final TextEditingController controller;
  final bool enabled;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + MediaQuery.viewInsetsOf(context).bottom),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: enabled ? onSend : null,
            icon: const Icon(Icons.send_rounded),
          ),
        ],
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
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.l10n.chatRenameTitle),
      content: TextField(
        controller: _ctrl,
        autofocus: true,
        decoration: InputDecoration(hintText: widget.l10n.chatRenameHint),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.l10n.chatRenameCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _ctrl.text),
          child: Text(widget.l10n.chatRenameSave),
        ),
      ],
    );
  }
}

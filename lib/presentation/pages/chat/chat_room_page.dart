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
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (prev, curr) {
        if (curr is ChatRoomState && prev is ChatRoomState) {
          return curr.messages.length != prev.messages.length ||
              curr.streamingText != prev.streamingText ||
              curr.errorKey != prev.errorKey ||
              curr.errorMessage != prev.errorMessage;
        }
        return prev.status != curr.status;
      },
      listener: (context, state) {
        if (state is ChatRoomState) {
          if (state.errorKey != null || state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? l10n.chatErrorLocalSave),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
          // Scroll on message count change or streaming text update
          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        }
      },
      builder: (context, state) {
        final session = state.sessions.cast<ChatSession?>().firstWhere(
              (s) => s?.id == widget.sessionId,
              orElse: () => null,
            );

        String? streamingText;
        if (state is ChatRoomState && state.isStreaming) {
          streamingText = state.streamingText;
        }

        final bool isTyping = state.status == ChatStatus.typing;

        return Scaffold(
          appBar: AppBar(
            title: Text(session?.title ?? l10n.chatNewSessionTitle),
            centerTitle: true,
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
                  scrollController: _scrollController,
                  messages: state.messages,
                  isLoading: state.status == ChatStatus.loading,
                  streamingText: streamingText,
                ),
              ),
              if (isTyping && (streamingText == null || streamingText.isEmpty))
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

    context.read<ChatBloc>().add(
      SendMessage(
        userId: auth.profile.firebaseUid,
        text: text,
        localeCode: context.read<LocaleCubit>().state.languageCode,
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({
    required this.messages,
    required this.isLoading,
    required this.scrollController,
    this.streamingText,
  });

  final List<ChatMessage> messages;
  final bool isLoading;
  final ScrollController scrollController;
  final String? streamingText;

  @override
  Widget build(BuildContext context) {
    if (isLoading && messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final showStreaming = streamingText != null && streamingText!.isNotEmpty;
    final totalCount = messages.length + (showStreaming ? 1 : 0);

    if (totalCount == 0) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).chatWelcomeMessage,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: totalCount,
      itemBuilder: (context, index) {
        if (index < messages.length) {
          return _MessageBubble(message: messages[index]);
        } else {
          return _MessageBubble(
            message: ChatMessage(
              id: -1,
              sessionId: -1,
              role: ChatRole.model,
              content: streamingText!,
              timestamp: DateTime.now(),
            ),
            isStreaming: true,
          );
        }
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, this.isStreaming = false});
  final ChatMessage message;
  final bool isStreaming;

  @override
  Widget build(BuildContext context) {
    final isMe = message.isUser;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe)
                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 4),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: colors.primaryContainer,
                    child: Icon(Icons.auto_awesome, size: 14, color: colors.onPrimaryContainer),
                  ),
                ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe ? colors.primary : colors.surfaceContainerHigh,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isMe ? 20 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isMe ? colors.onPrimary : colors.onSurface,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isStreaming)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 4),
              child: SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colors.primary.withValues(alpha: 0.5)),
                ),
              ),
            ),
        ],
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + MediaQuery.viewInsetsOf(context).bottom),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: TextField(
                controller: controller,
                enabled: enabled,
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => enabled ? onSend() : null,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: enabled ? onSend : null,
            icon: const Icon(Icons.send_rounded),
            style: IconButton.styleFrom(
              minimumSize: const Size(52, 52),
            ),
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

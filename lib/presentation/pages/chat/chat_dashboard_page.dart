import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmai/presentation/bloc/chat/chat_bloc.dart';

class ChatDashboardPage extends StatefulWidget {
  const ChatDashboardPage({super.key});

  @override
  State<ChatDashboardPage> createState() => _ChatDashboardPageState();
}

class _ChatDashboardPageState extends State<ChatDashboardPage> {
  int? _lastOpenedId;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthBloc>().state;
    if (auth is AuthAuthenticated) {
      context.read<ChatBloc>().add(FetchSessions(userId: auth.profile.firebaseUid));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (previous, current) => current is ChatSessionsLoaded,
      listener: (context, state) {
        if (state is! ChatSessionsLoaded) return;
        final id = state.openSessionId;
        if (id == null || id == _lastOpenedId) return;
        _lastOpenedId = id;
        context.push('${AppConstants.routeChatDashboard}/$id');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.chatDashboardTitle),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final auth = context.read<AuthBloc>().state;
            if (auth is! AuthAuthenticated) return;
            context.read<ChatBloc>().add(
                  StartNewChat(userId: auth.profile.firebaseUid),
                );
          },
          icon: const Icon(Icons.add_comment_rounded),
          label: Text(l10n.chatNewChat),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading || state is ChatInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is! ChatSessionsLoaded) {
              return const SizedBox.shrink();
            }
            if (state.sessions.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 48, color: Theme.of(context).hintColor),
                      const SizedBox(height: 16),
                      Text(
                        l10n.chatEmptyTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.chatEmptySubtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
              itemBuilder: (context, index) {
                final session = state.sessions[index];
                final title = session.title.isEmpty
                    ? l10n.chatNewSessionTitle
                    : session.title;
                return ListTile(
                  leading: const Icon(Icons.chat_bubble_rounded),
                  title: Text(title),
                  subtitle: Text(
                    _formatDate(session.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  onTap: () => context
                      .push('${AppConstants.routeChatDashboard}/${session.id}'),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: state.sessions.length,
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime value) {
    final date = MaterialLocalizations.of(context).formatMediumDate(value);
    final time = MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(value),
      alwaysUse24HourFormat: true,
    );
    return '$date • $time';
  }
}

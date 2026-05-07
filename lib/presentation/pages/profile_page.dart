import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/domain/entities/bookmark.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/profile_repository.dart';
import 'package:pharmai/injection_container.dart';
import 'package:pharmai/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmai/presentation/bloc/locale/locale_cubit.dart';
import 'package:pharmai/presentation/bloc/theme/theme_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final s = context.read<AuthBloc>().state;
    _nameCtrl = TextEditingController(
      text: s is AuthAuthenticated ? s.profile.customName ?? '' : '',
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveName(UserProfile profile) async {
    setState(() => _saving = true);
    await sl<ProfileRepository>().updateProfile(
      profile.copyWith(customName: _nameCtrl.text.trim()),
    );
    setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && context.canPop()) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.profile),
          leading: BackButton(onPressed: () => context.pop()),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is! AuthAuthenticated) {
              return Center(
                child: FilledButton(
                  onPressed: () => context.go(AppConstants.routeLogin),
                  child: Text(l.signInWithGoogle),
                ),
              );
            }
            final profile = state.profile;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _AvatarSection(profile: profile),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameCtrl,
                        decoration: InputDecoration(
                          labelText: l.customName,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _saving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : IconButton(
                            onPressed: () => _saveName(profile),
                            icon: const Icon(Icons.save_outlined),
                          ),
                  ],
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: Text(l.darkMode),
                  value: context.watch<ThemeCubit>().state == ThemeMode.dark,
                  onChanged: (_) => context.read<ThemeCubit>().toggle(),
                ),
                SwitchListTile(
                  title: Text(l.languageTurkish),
                  value:
                      context.watch<LocaleCubit>().state.languageCode == 'tr',
                  onChanged: (val) => context.read<LocaleCubit>().setLocale(
                    Locale(val ? 'tr' : 'en'),
                  ),
                ),
                const SizedBox(height: 16),
                _BookmarksSection(uid: profile.firebaseUid),
                const SizedBox(height: 24),
                FilledButton.tonal(
                  onPressed: () => context.read<AuthBloc>().add(
                    const AuthSignOutRequested(),
                  ),
                  child: Text(l.signOut),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AvatarSection extends StatelessWidget {
  const _AvatarSection({required this.profile});
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final initials = (profile.customName ?? profile.email)[0].toUpperCase();
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: profile.photoUrl != null
              ? NetworkImage(profile.photoUrl!)
              : null,
          child: profile.photoUrl == null
              ? Text(initials, style: const TextStyle(fontSize: 28))
              : null,
        ),
        const SizedBox(height: 8),
        Text(profile.email, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _BookmarksSection extends StatelessWidget {
  const _BookmarksSection({required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return FutureBuilder(
      future: sl<ProfileRepository>().getBookmarks(uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final bookmarks = snapshot.data!.fold(
          (_) => <Bookmark>[],
          (list) => list,
        );
        if (bookmarks.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.bookmarks, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...bookmarks.map(
              (b) => ListTile(
                leading: const Icon(Icons.bookmark_outline),
                title: Text(b.code),
                subtitle: Text(b.category),
              ),
            ),
          ],
        );
      },
    );
  }
}

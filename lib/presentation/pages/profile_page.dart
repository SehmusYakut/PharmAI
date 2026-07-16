import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/core/l10n/app_localizations.dart';
import 'package:pharmai/domain/entities/bookmark.dart';
import 'package:pharmai/domain/entities/user_profile.dart';
import 'package:pharmai/domain/repositories/bookmark_repository.dart';
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
    if (mounted) {
      setState(() => _saving = false);
    }
  }

  Future<void> _confirmDeleteAccount() async {
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.deleteAccountConfirmTitle),
        content: Text(l.deleteAccountConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(l.deleteAccountConfirmBtn),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<AuthBloc>().add(const AuthDeleteAccountRequested());
    }
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
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is! AuthAuthenticated) {
                return Center(
                  child: FilledButton(
                    onPressed: () => context.go(AppConstants.routeLogin),
                    child: Text(l.signInWithGoogle),
                  ),
                );
              }
            final profile = state.profile;
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque,
              child: ListView(
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
                  const SizedBox(height: 16),
                  Text(l.themeLabel,
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Light'),
                        selected: context.watch<ThemeCubit>().state == 'light',
                        onSelected: (val) => val
                            ? context.read<ThemeCubit>().setTheme('light')
                            : null,
                      ),
                      ChoiceChip(
                        label: const Text('Dark'),
                        selected: context.watch<ThemeCubit>().state == 'dark',
                        onSelected: (val) => val
                            ? context.read<ThemeCubit>().setTheme('dark')
                            : null,
                      ),
                      ChoiceChip(
                        label: Text(l.themeMidnight),
                        selected:
                            context.watch<ThemeCubit>().state == 'midnight',
                        onSelected: (val) => val
                            ? context.read<ThemeCubit>().setTheme('midnight')
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(l.languageLabel,
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(l.languageTurkish),
                        selected:
                            context.watch<LocaleCubit>().state.languageCode ==
                                'tr',
                        onSelected: (val) => val
                            ? context.read<LocaleCubit>().setLocale(
                                  const Locale('tr'),
                                )
                            : null,
                      ),
                      ChoiceChip(
                        label: Text(l.languageEnglish),
                        selected:
                            context.watch<LocaleCubit>().state.languageCode ==
                                'en',
                        onSelected: (val) => val
                            ? context.read<LocaleCubit>().setLocale(
                                  const Locale('en'),
                                )
                            : null,
                      ),
                      ChoiceChip(
                        label: Text(l.languageGerman),
                        selected:
                            context.watch<LocaleCubit>().state.languageCode ==
                                'de',
                        onSelected: (val) => val
                            ? context.read<LocaleCubit>().setLocale(
                                  const Locale('de'),
                                )
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _BookmarksSection(uid: profile.firebaseUid),
                  const SizedBox(height: 24),
                  FilledButton.tonal(
                    onPressed: () => context.read<AuthBloc>().add(
                      const AuthSignOutRequested(),
                    ),
                    child: Text(l.signOut),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _confirmDeleteAccount,
                    icon: const Icon(Icons.delete_forever_rounded),
                    label: Text(l.deleteAccount),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      side: BorderSide(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
    return FutureBuilder<Either<Failure, List<Bookmark>>>(
      future: sl<BookmarkRepository>().fetchAllBookmarks(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        
        final result = snapshot.data!;
        return result.fold(
          (failure) => const SizedBox.shrink(),
          (bookmarks) {
            if (bookmarks.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.bookmarks, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...bookmarks.map(
              (b) => ListTile(
                leading: Icon(
                  b.itemType == BookmarkItemType.icd10
                      ? Icons.tag_rounded
                      : Icons.medication_rounded,
                ),
                title: Text(b.title),
                subtitle: Text(b.subtitle),
                onTap: () {
                  final route = b.itemType == BookmarkItemType.icd10
                      ? AppConstants.routeIcd10Search
                      : AppConstants.routeDrugInfo;
                  context.push('$route?q=${Uri.encodeComponent(b.itemId)}');
                },
              ),
            ),
              ],
            );
          },
        );
      },
    );
  }
}

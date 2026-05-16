import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/router/app_router.gr.dart';
import 'package:ryori/core/utils/dialog_utils.dart';
import 'package:ryori/core/utils/toast_utils.dart';
import 'package:ryori/features/profile/presentation/viewmodels/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileViewModel _vm;
  GetProfileStatus? _previousGetProfileStatus;
  PostLogoutStatus? _previousPostLogoutStatus;

  @override
  void initState() {
    super.initState();
    _vm = context.read<ProfileViewModel>();
    _previousGetProfileStatus = _vm.getProfileStatus;
    _previousPostLogoutStatus = _vm.postLogoutStatus;
    _vm.addListener(_listener);
  }

  @override
  void dispose() {
    _vm.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    final currentGetProfileStatus = _vm.getProfileStatus;
    final currentPostLogoutStatus = _vm.postLogoutStatus;
    final profileStatusChanged =
        _previousGetProfileStatus != currentGetProfileStatus;
    final logoutStatusChanged =
        _previousPostLogoutStatus != currentPostLogoutStatus;

    if (profileStatusChanged) {
      _previousGetProfileStatus = currentGetProfileStatus;
      if (currentGetProfileStatus == GetProfileStatus.failure) {
        _handleFailure();
      }
    }

    if (!logoutStatusChanged) {
      return;
    }

    _previousPostLogoutStatus = currentPostLogoutStatus;

    if (currentPostLogoutStatus == PostLogoutStatus.loading) {
      showLoadingDialog(context);
      return;
    }

    if (currentPostLogoutStatus == PostLogoutStatus.success) {
      Navigator.pop(context);
      showSuccessToast(
        context,
        'Logout Success',
        _vm.logoutResponse?.message ?? 'You have been logged out.',
      );
      context.router.replaceAll([const StartupSetup()]);
      return;
    }

    if (currentPostLogoutStatus == PostLogoutStatus.failure) {
      Navigator.pop(context);
      _handleFailure();
    }
  }

  void _handleFailure() {
    final message =
        _vm.errorMessage ??
        (_vm.isAuthError
            ? 'Your session has expired. Please login again.'
            : 'An unexpected error occurred. Please try again.');

    showErrorToast(
      context,
      _vm.isAuthError ? 'Session Expired' : 'Profile Error',
      message,
    );

    if (_vm.isAuthError) {
      context.router.replaceAll([const StartupSetup()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Consumer<ProfileViewModel>(
          builder: (context, vm, child) {
            if (vm.getProfileStatus == GetProfileStatus.loading ||
                vm.getProfileStatus == GetProfileStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.getProfileStatus == GetProfileStatus.failure &&
                !vm.isAuthError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 48,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        vm.errorMessage ??
                            'Unable to load your profile right now.',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: vm.fetchProfile,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final profile = vm.profile;
            if (profile == null) {
              return const SizedBox.shrink();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor:
                                    theme.colorScheme.primaryContainer,
                                foregroundColor:
                                    theme.colorScheme.onPrimaryContainer,
                                child: Text(
                                  _initialsFor(profile.name, profile.email),
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                profile.name?.trim().isNotEmpty == true
                                    ? profile.name!.trim()
                                    : 'Ryori User',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Your account information',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 24),
                              _ProfileField(
                                label: 'Name',
                                value:
                                    profile.name?.trim().isNotEmpty == true
                                        ? profile.name!.trim()
                                        : 'Ryori User',
                              ),
                              const SizedBox(height: 16),
                              _ProfileField(
                                label: 'Email',
                                value: profile.email,
                              ),
                              const SizedBox(height: 16),
                              _ProfileField(
                                label: 'User ID',
                                value: profile.id,
                              ),
                              const SizedBox(height: 16),
                              _ProfileField(
                                label: 'Created At',
                                value: _formatDate(profile.createdAt),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton.icon(
                        onPressed:
                            vm.postLogoutStatus == PostLogoutStatus.loading
                                ? null
                                : () => _confirmLogout(context, vm),
                        icon: const Icon(Icons.logout_rounded),
                        label: const Text('Logout'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.error,
                          side: BorderSide(color: theme.colorScheme.error),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmLogout(
    BuildContext context,
    ProfileViewModel vm,
  ) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout?'),
          content: const Text(
            'You will need to login again to access your account.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true && context.mounted) {
      await vm.logout();
    }
  }

  String _initialsFor(String? name, String email) {
    final normalizedName = name?.trim();
    if (normalizedName != null && normalizedName.isNotEmpty) {
      final parts = normalizedName.split(RegExp(r'\s+'));
      final buffer = StringBuffer();
      for (final part in parts.take(2)) {
        if (part.isNotEmpty) {
          buffer.write(part[0].toUpperCase());
        }
      }
      if (buffer.length > 0) {
        return buffer.toString();
      }
    }

    return email.isNotEmpty ? email[0].toUpperCase() : 'R';
  }

  String _formatDate(DateTime value) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final local = value.toLocal();
    final month = months[local.month - 1];
    final day = local.day.toString().padLeft(2, '0');
    return '$day $month ${local.year}';
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

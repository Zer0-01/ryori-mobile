import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryori/app/router/app_router.gr.dart';
import 'package:ryori/core/utils/dialog_utils.dart';
import 'package:ryori/core/utils/toast_utils.dart';
import 'package:ryori/features/login/presentation/viewmodels/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final LoginViewModel _vm;
  PostLoginStatus? _previousPostLoginStatus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _vm = context.read<LoginViewModel>();
    _previousPostLoginStatus = _vm.postLoginStatus;
    _vm.addListener(_listener);
  }

  @override
  void dispose() {
    _vm.removeListener(_listener);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _listener() {
    final currentStatus = _vm.postLoginStatus;
    final statusChanged = _previousPostLoginStatus != currentStatus;

    if (!statusChanged) {
      return;
    }

    _previousPostLoginStatus = currentStatus;

    if (currentStatus == PostLoginStatus.loading) {
      showLoadingDialog(context);
      return;
    }

    if (currentStatus == PostLoginStatus.success) {
      Navigator.pop(context);
      showSuccessToast(context, 'Login Success', 'Welcome back to Ryori.');
      context.router.replace(const HomeSetup());
      return;
    }

    if (currentStatus == PostLoginStatus.failure) {
      Navigator.pop(context);
      showErrorToast(
        context,
        'Login Failed',
        'An error occurred while signing in. Please try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Ryori',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sign in to continue to your recipes.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Consumer<LoginViewModel>(
                        builder: (context, vm, child) {
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Login',
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  validator: _validateEmail,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                  validator: _validatePassword,
                                  onFieldSubmitted: (_) => _submit(),
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                  ),
                                ),
                                const SizedBox(height: 24),
                                FilledButton(
                                  onPressed: _submit,
                                  child: const Text('Login'),
                                ),
                                const SizedBox(height: 12),
                                TextButton(
                                  onPressed:
                                      () => context.router.push(
                                        const RegisterSetup(),
                                      ),
                                  child: const Text(
                                    "Don't have an account? Register",
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _vm.login(email: _emailController.text, password: _passwordController.text);
  }

  String? _validateEmail(String? value) {
    final normalized = value?.trim() ?? '';
    if (normalized.isEmpty) {
      return 'Email cannot be empty';
    }

    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailPattern.hasMatch(normalized)) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password cannot be empty';
    }

    return null;
  }
}

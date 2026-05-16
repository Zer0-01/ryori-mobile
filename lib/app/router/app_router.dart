import 'package:auto_route/auto_route.dart';
import 'package:ryori/app/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: StartupSetup.page, initial: true, path: '/'),
    AutoRoute(page: LoginSetup.page, path: '/login'),
    AutoRoute(page: RegisterSetup.page, path: '/register'),
    AutoRoute(page: HomeSetup.page, path: '/home'),
    AutoRoute(page: AddRecipeSetup.page, path: '/add-recipe'),
    AutoRoute(page: EditRecipeSetup.page, path: '/edit-recipe/:recipeId'),
    AutoRoute(page: RecipeDetailSetup.page, path: '/recipe-detail/:recipeId'),
  ];
}

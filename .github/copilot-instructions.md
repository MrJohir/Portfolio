# 🤖 AI Agent Instructions for Flutter Development

## 🚨 Critical Rules (Must Follow)

These rules are non-negotiable and must be applied in all generated code.

### 1. Imports
- **✅ Use package imports** for all files within `lib/`:
  ```dart
  import 'package:nishantrawat21/core/utils/constants/app_colors.dart';
  ```
- **❌ Avoid relative imports**:
  ```dart
  import '../../constants/app_colors.dart';
  ```
- **Agent Action**: Always generate `package:` imports for files in `lib/`. Use relative imports only for files outside `lib/` (e.g., tests).

### 2. Color Methods
- **✅ Use `Color.withValues(alpha: ...)`** for opacity:
  ```dart
  Color.withValues(alpha: 0.5)
  ```
- **❌ Avoid deprecated `Color.withOpacity(...)`**:
  ```dart
  Color.withOpacity(0.5)
  ```
- **Agent Action**: Replace any `.withOpacity()` with `.withValues(alpha: ...)` in generated code.

### 3. GetX Controllers
- **✅ Use `Get.find<MyController>()` in widgets**:
  ```dart
  final controller = Get.find<MyController>();
  ```
- **❌ Never use `Get.put()` in `build()` methods**:
  ```dart
  final controller = Get.put(MyController());
  ```
- **Agent Action**: Assume controllers are bound via `Bindings`. Never generate `Get.put()` inside widget `build()` methods.

// Notification preference
- **🚫 Notification method**: Do NOT use `Get.snackbar` for user-facing messages.
- **✅ Preferred**: Use `EasyLoading` for all transient user messages, errors, and success feedback in controllers and services.

### Logging
- **✅ Use `AppLoggerHelper`** for all application logging. Import it with a package import:
  ```dart
  import 'package:nishantrawat21/core/utils/logging/logger.dart';
  ```
- **❌ Do NOT** use `print()`, `debugPrint()`, or instantiate `Logger()` directly in app code.
- **Agent Action**: Replace any direct `print`/`debugPrint` or local `Logger` usage with `AppLoggerHelper.debug/info/warning/error`.
- **If missing**: If `AppLoggerHelper` does not exist in the workspace, create a single global logger wrapper at `lib/core/utils/logging/logger.dart` and use it everywhere. Do NOT create multiple logger instances scattered across files.


### 4. Controller Bindings
- **✅ Use `controller_binder.dart` for all controller registrations**:
  ```dart
  // In controller_binder.dart
  Get.lazyPut<MyController>(() => MyController(), fenix: true);
  ```
- **❌ Never add bindings directly in `app_pages.dart`**:
  ```dart
  // ❌ Avoid this in app_pages.dart
  binding: BindingsBuilder(() {
    Get.lazyPut<MyController>(() => MyController());
  }),
  ```
- **Agent Action**: Always register controllers in `controller_binder.dart`. Never add individual bindings to routes in `app_pages.dart`.

### 5. Text Strings
- **✅ Use constants from `AppStrings`**:
  ```dart
  Text(AppStrings.welcomeMessage)
  ```
- **❌ Avoid hardcoded strings**:
  ```dart
  Text('Welcome to the app')
  ```
- **Agent Action**: Always reference `AppStrings` for text. If a string is missing, suggest adding it to `core/utils/constants/app_strings.dart`.

### Validation

- **✅ Use `AppValidator` for all form and input validation**. Implement common validators (email, phone, full name, required, password, etc.) in a single shared file at:
  ```
  lib/core/utils/validators/app_validator.dart
  ```
- **✅ Use package imports** when referencing the validator from any file in `lib/`:
  ```dart
  import 'package:nishantrawat21/core/utils/validators/app_validator.dart';
  ```
- **✅ Preferred usage**: In widgets and controllers always call `AppValidator` helpers (for example `AppValidator.validateEmail(value)`) instead of inlining regex or custom validation logic.
- **❌ Avoid** duplicating validation logic or inlining regex patterns across widgets/controllers.
- **Agent Action**: Before generating any validation code, check for the existence of `lib/core/utils/validators/app_validator.dart`:
  1. If it exists, use its helpers for all validation.
  2. If it does not exist, create a single, well-documented `AppValidator` at `lib/core/utils/validators/app_validator.dart` that contains common validators (email, phone, full name, required, password, confirm password). Use null-safe signatures and clear error messages.
  3. After creating the validator file, add a short note in the task/PR (or communicate to the user) that the shared validator was created and where to add/modify validators.

Example usage in a form field:
```dart
CustomTextField(
  label: 'Email Address',
  validator: (value) => AppValidator.validateEmail(value),
  controller: controller.emailController,
)
```

### 6. UI Structure
- **Business Logic**: Place in controllers only.
- **UI Widgets**: Use for presentation only, no logic.
- **Widget Extraction**: Extract reusable widgets immediately.
- **ListView Preference**: Use `ListView` or `ListView.builder` instead of `SingleChildScrollView` + `Column`:
  ```dart
  // ✅ Preferred
  ListView(children: [...])
  // ❌ Avoid
  SingleChildScrollView(child: Column(...))
  ```
- **Agent Action**: Ensure widgets are stateless unless state is required. Extract repeated UI patterns into reusable widgets in `lib/features/[feature]/views/widgets/`.

---

## 🎯 Development Philosophy

**Write for Junior Developers**:
- Prioritize **clarity** over cleverness.
- Use simple, readable solutions.
- Avoid complex abstractions unless necessary.
- Ensure code is maintainable and extendable.

**Core Principles**:
- One responsibility per file/class/method.
- Extract widgets early to avoid duplication.
- Comment business logic, not obvious code.
- Keep methods under 30 lines where possible.

**Agent Action**: Generate code that is simple, well-commented, and follows the single-responsibility principle. Suggest widget extraction 
when patterns repeat.

## Package Management
*   If a new feature requires an external package, the AI will identify the most
    suitable and stable package from pub.dev.
*   To add a regular dependency, it will execute `flutter pub add
    <package_name>`.
*   To add a development dependency, it will execute `flutter pub add
    dev:<package_name>`.

### Dependency selection and updates (always check online)

- Before adding or updating any package the agent MUST search pub.dev to locate the package and determine the latest stable, null-safe version that is compatible with the project's SDK constraint.
- Prefer the newest non-prerelease (no `-dev`/`-beta`) release that supports null-safety and the project's current Flutter/Dart SDK.
- Use `flutter pub add <package_name>` to add the dependency. After adding, run `flutter pub get` to fetch packages.
- If version solving fails (dependency conflict), the agent should not force an unsafe upgrade. Instead it must: 
  1. Report the conflict with a short explanation of the incompatible packages.
  2. Propose 1-2 viable version alternatives (for the new package or existing packages) that are likely to resolve the conflict.
  3. Apply the chosen, non-breaking change only after explicit confirmation from the user (or if the user previously authorized automatic resolution in scope of the request).
- To audit available updates, the agent may run `flutter pub outdated` and report upgrade candidates; however the agent must not automatically upgrade the whole dependency tree without user approval.
- When adding a package that also requires platform setup (Android/iOS), include a short platform integration note (e.g., manifest or podfile changes) in the patch or follow-up message.

---

## 🏗 Architecture: Strict MVC Pattern

```
Model     → Data classes, API models, database entities
View      → UI widgets and screens (presentation only)
Controller → Business logic, state management, API calls
```

- **Business Logic**: Always in controllers.
- **UI Widgets**: Presentation only, no logic.
- **Agent Action**: Enforce MVC by placing logic in controllers and keeping widgets clean.

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── utils/constants/     # app_colors.dart, app_strings.dart, sizer.dart
│   ├── common/widgets/      # Reusable UI components (CustomAppBar, CustomButton)
│   ├── services/           # network_caller.dart, storage_service.dart
│   └── theme/              # AppTextStyles, theme data
├── features/
│   └── [feature_name]/
│       ├── controllers/    # Business logic (e.g., UserController)
│       ├── models/        # Data classes (e.g., User)
│       └── views/
│           ├── screens/   # Full-screen widgets
│           └── widgets/   # Feature-specific widgets
└── routes/                # Navigation setup (e.g., app_routes.dart)
```

- **Agent Action**: Place files in the correct folder based on their role. Use descriptive names (e.g., `UserProfileScreen`, `CustomButtonWidget`).

---

## 📋 Documentation Requirements

- **Location**: Place `.md` files in `notes/` folder for task notes.
- **Task Notes**: Create comprehensive notes in `notes/` folder using descriptive filename (e.g., `instagram_style_comment_system.md`).
- **Content**: Explain core concepts for new Flutter developers with:
  - Overview and learning objectives
  - Architecture explanation (MVC pattern)
  - Step-by-step implementation guide
  - Code examples with explanations
  - Common issues and solutions
  - Testing guidelines
  - Performance considerations
- **When to Document**: MANDATORY for complex features like:
  - Complete UI systems (comment systems, chat interfaces,etc)
  - State management implementations
  - Custom animations and interactions
  - API integrations
  - Multi-file feature implementations
- **Agent Action**: After completing any complex task involving multiple files or advanced concepts, ALWAYS create detailed documentation in `notes/` folder that a beginner developer can follow to understand and replicate the implementation.

---

## 📝 Code Quality Standards

### Naming Conventions
- **Variables/Methods**: camelCase (e.g., `userEmailController`, `fetchUserData`).
- **Classes/Widgets**: PascalCase (e.g., `UserCardWidget`).
- **Constants**: UPPER_CASE (e.g., `AppStrings.WELCOME_MESSAGE`).
- **Agent Action**: Use consistent naming conventions in all generated code.

### Commenting
- Use `//` for single-line comments.
- Use `///` for documentation comments on classes/methods:
  ```dart
  /// Fetches user data from API
  /// [id] - User ID
  /// Returns: User object
  Future<User> fetchUser(String id) async { ... }
  ```
- Comment business logic, not obvious code.
- **Agent Action**: Add comments for complex logic or non-obvious functionality.

---

## 🎨 UI Development Standards

### Text and Colors
- **Text**: Use `AppTextStyles` for typography:
  ```dart
  Text(AppStrings.welcome, style: AppTextStyles.heading1.copyWith(color: AppColors.primary))
  ```
- **Colors**: Use `AppColors` constants. Add missing colors to `core/utils/constants/app_colors.dart`:
  ```dart
  class AppColors {
    static const newDesignColor = Color(0xFF123456);
  }
  ```
- **Agent Action**: Use `AppTextStyles` and `AppColors`. Suggest adding new colors to `app_colors.dart` if needed.

### Responsive Sizing
- Use `screen_utils` package for all sizing:
  ```dart
  Container(
    width: 200.w,
    height: 100.h,
    padding: EdgeInsets.all(16.r),
  )
  ```
- **Agent Action**: Always apply `screen_utils` (`w`, `h`, `r`) for dimensions and spacing.

### Reusable Widgets
- Extract repeated UI patterns into reusable widgets:
  ```dart
  class InfoRow extends StatelessWidget {
    const InfoRow({super.key, required this.icon, required this.text});
    final IconData icon;
    final String text;

    @override
    Widget build(BuildContext context) {
      return Row(
        children: [
          Icon(icon, color: AppColors.secondary),
          SizedBox(width: 8.w),
          Text(text, style: AppTextStyles.body),
        ],
      );
    }
  }
  ```
- **Agent Action**: Extract widgets into `lib/features/[feature]/views/widgets/` when patterns repeat.

### Code Reusability & DRY Principle
- **✅ Always use existing reusable components**:
  ```dart
  // Use existing CustomTextField for all text inputs
  CustomTextField(
    label: 'Phone Number',
    placeholder: 'Enter phone number',
    controller: controller.phoneController,
    keyboardType: TextInputType.phone,
  )
  ```
- **❌ Never create custom implementations when reusable components exist**:
  ```dart
  // ❌ Don't create custom TextFormField when CustomTextField exists
  Container(
    decoration: BoxDecoration(...),
    child: TextFormField(...),
  )
  ```
- **Agent Action**: Before writing custom widgets, check if reusable components already exist. Use CustomTextField, CustomButton, etc. instead of creating duplicates.

### Figma Implementation
- **Priorities**:
  1. Use Flutter built-in widgets (e.g., `AppBar`, `ElevatedButton`) over custom `Container`.
  2. Minimize unnecessary code; avoid over-engineering.
  3. Use `padding`/`margin` for spacing, avoid fixed `SizedBox`.
  4. Use `screen_utils` for all sizing (`200.w`, `100.h`, `16.r`).
  5. **MANDATORY**: When user provides Figma URLs, ALWAYS call both `mcp_figma2_get_code` and `mcp_figma2_get_screenshot` for EVERY URL provided
- **Figma MCP Protocol**:
  ```dart
  // REQUIRED workflow for Figma URLs:
  // 1. Extract node-id from URL (e.g., node-id=138-961 becomes "138:961")
  // 2. Call mcp_figma2_get_code with extracted nodeId
  // 3. Call mcp_figma2_get_screenshot with same nodeId
  // 4. Implement pixel-perfect UI based on both code and screenshot
  ```
- **Common Widgets**:
  ```dart
  CustomAppBar(title: AppStrings.home)
  CustomButton(text: AppStrings.submit, onPressed: controller.submit)
  CustomTextField(controller: controller.emailController, validator: AppValidator.email)
  ```
- **AppBar Usage Guidelines**:
  - **✅ ALWAYS use `CustomAppBar` for all screens**:
  ```dart
  Scaffold(
    appBar: CustomAppBar(title: 'Screen Title'),
    body: content,
  )
  ```
  - **❌ NEVER use `Container` or custom implementations for app bar**:
  ```dart
  // ❌ Don't create custom app bar containers
  Container(
    height: 54.h,
    child: Row(...), // Custom app bar implementation
  )
  ```
  - **✅ Use `appBar` property in `Scaffold`, NOT in body**:
  ```dart
  // ✅ Correct way
  Scaffold(
    appBar: CustomAppBar(title: 'Title'),
    body: content,
  )
  
  // ❌ Wrong way
  Scaffold(
    body: Column(
      children: [
        CustomAppBar(title: 'Title'), // Don't put in body
        content,
      ],
    ),
  )
  ```
  - **AppBar Theme**: Main theme configured in `core/utils/theme/custom_themes/app_bar_theme.dart`
- **Images/Icons**:
  - Use online image links (to be replaced with assets later).
  - Use Flutter `Icon` for icons (to be replaced with custom assets later).
- **TextField Borders**:
  - Same border for focus/enable states; red for error state.
- **Scaffold Background**:
  - Use theme data, not direct `backgroundColor`:
  ```dart
  Scaffold(body: content) // ✅
  Scaffold(backgroundColor: Colors.blue, body: content) // ❌
  ```
- **CustomButton Properties**:
  - **✅ Only specify non-default properties**:
  ```dart
  CustomButton(text: 'Submit', onPressed: onPressed, height: 56)
  ```
  - **❌ Avoid redundant default properties**:
  ```dart
  CustomButton(text: 'Submit', onPressed: onPressed, showShadow: true, borderRadius: 25) // ❌
  ```
- **Agent Action**: Ensure pixel-perfect UI matching Figma designs. Use built-in widgets, `screen_utils`, and global styles. Never specify default properties in CustomButton calls. Always use CustomAppBar for consistent app bar implementation.

---

## 🌐 API Integration

### Network Layer
- Use `NetworkCaller` with `http` package:
  ```dart
  class UserController extends GetxController {
    final RxList<User> users = <User>[].obs;
    final RxBool isLoading = false.obs;

    Future<void> getUsers() async {
      try {
        isLoading.value = true;
        EasyLoading.show();
        final response = await NetworkCaller.get(ApiConstants.users);
        final userList = (response.data as List)
            .map((json) => User.fromJson(json))
            .toList();
        users.assignAll(userList);
        EasyLoading.showSuccess('Users loaded');
      } catch (error) {
        AppLoggerHelper.error('GetUsers error: $error', error: error);
        EasyLoading.showError('Failed to load users');
      } finally {
        isLoading.value = false;
        EasyLoading.dismiss();
      }
    }
  }
  ```
- **Agent Action**: Place API logic in controllers, use `NetworkCaller`, and handle errors with `EasyLoading` and `Logger`.

### Model Classes
- Always null-safe with proper defaults:
  ```dart
  class User {
    final String id;
    final String name;
    final String email;

    const User({
      required this.id,
      required this.name,
      required this.email,
    });

    factory User.fromJson(Map<String, dynamic> json) {
      return User(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
      );
    }

    Map<String, dynamic> toJson() {
      return {'id': id, 'name': name, 'email': email};
    }
  }
  ```
- **Agent Action**: Generate null-safe models with `fromJson` and `toJson` methods.

---

## 🧪 Error Handling & Loading States

### Loading States
- Use `EasyLoading` for global loading:
  ```dart
  EasyLoading.show(status: 'Loading...');
  EasyLoading.dismiss();
  EasyLoading.showSuccess('Success!');
  EasyLoading.showError('Error occurred');
  ```
- Use `Shimmer` for list loading, matching Figma design:
  ```dart
  if (controller.isLoading.value) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => const UserShimmer(),
    );
  }
  ```
- **Agent Action**: Implement `EasyLoading` for all loading states and `Shimmer` for list placeholders.

### Error Handling
- Handle errors in `NetworkCaller`, not controllers:
  ```dart
  try {
    final response = await NetworkCaller.get(ApiConstants.users);
    // Process response
  } catch (error) {
    Logger.error('API Error: $error');
    EasyLoading.showError('Something went wrong');
  }
  ```
- **Agent Action**: Ensure errors are logged with `Logger` and displayed with `EasyLoading`.

Note: Prefer `EasyLoading` over `Get.snackbar` or `SnackBar` for showing transient success/error/info messages. `EasyLoading` provides a consistent overlay UI and is the project's standard for feedback.

---

## 🚫 Anti-Patterns to Avoid

- **Business Logic in UI**:
  ```dart
  class MyScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      fetchUserData(); // ❌
      return Scaffold(...);
    }
  }
  ```
- **Redundant Default Properties**:
  ```dart
  CustomButton(showShadow: true, borderRadius: 25) // ❌ (these are defaults)
  ```
- **Unnecessary Scaffold backgroundColor**:
  ```dart
  Scaffold(backgroundColor: AppColors.white) // ❌ (use theme)
  ```
- **Unnecessary Container/SizedBox Wrappers**:
  ```dart
  SizedBox(height: 300, child: Column(...)) // ❌ (use direct spacing)
  ```
- **Creating Custom Widgets for Existing Components**:
  ```dart
  // ❌ Don't create when CustomTextField exists
  Widget _buildCustomTextField() { return Container(...); }
  ```
- **Hardcoded Values**:
  ```dart
  Text('Login') // ❌
  Colors.blue.withOpacity(0.5) // ❌
  ```
- **Deep Relative Imports**:
  ```dart
  import '../../utils/colors.dart'; // ❌
  ```
- **Complex Nested Widgets**:
  ```dart
  Column(children: [Container(child: Row(...))]) // ❌
  ```
- **Complex Ternaries or One-Liners**:
  ```dart
  widget.x ? doThis() : widget.y ? doThat() : doOther(); // ❌
  ```
- **Using `print()`**:
  ```dart
  print('Debug'); // ❌
  ```
- **Dynamic Types**:
  ```dart
  var data = response.data; // ❌
  ```
- **Agent Action**: Avoid these patterns. Suggest refactoring if detected in existing code.

---

## 🔧 Code Style Guidelines

### Widget Construction
```dart
class CustomButton extends StatelessWidget {
  /// Custom button with rounded corners
  /// [onPressed] - Callback for button press
  /// [text] - Button text
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(text, style: AppTextStyles.button),
    );
  }
}
```
- **Agent Action**: Use `const` constructors, `super.key`, and `AppTextStyles` in widgets.

### Method Structure
- Keep methods short (20-30 lines).
- Use early returns to reduce nesting:
  ```dart
  Future<void> loadUserData() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final userData = await userService.getCurrentUser();
      user.value = userData;
      EasyLoading.showSuccess('User loaded');
    } catch (error) {
      Logger.error('LoadUser error: $error');
      EasyLoading.showError('Failed to load user');
    } finally {
      isLoading.value = false;
    }
  }
  ```
- **Agent Action**: Structure methods for clarity with early returns and proper error handling.

---

## 🎯 Agent Success Criteria

1. **Scan Critical Rules First**: Imports, colors, GetX, text, UI structure.
2. **Extract Reusable Widgets**: Avoid UI duplication.
3. **Keep Logic in Controllers**: UI is presentation only.
4. **Use Constants**: For strings, colors, sizes.
5. **Handle Errors Gracefully**: Use `EasyLoading` and `Logger`.
6. **Write Clear Code**: Understandable by junior developers.
7. **Document Complex Tasks**: Create detailed notes in `notes/` folder after completing multi-file features or advanced implementations.

**Agent Action**: Prioritize these criteria in all generated code. Suggest improvements for violations in existing code. ALWAYS create documentation for complex implementations.
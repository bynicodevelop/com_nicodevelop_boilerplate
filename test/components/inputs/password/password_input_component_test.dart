import "package:com_nicodevelop_dotmessenger/components/inputs/password/password_input_component.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  testWidgets("Should expect 'Password' label in textfield", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PasswordInputComponent(
            controller: TextEditingController(),
          ),
        ),
      ),
    );

    final textFinder = find.text("Password");

    expect(textFinder, findsOneWidget);
  });

  testWidgets("Should expect an error when password is invalid (min 6)", (
    WidgetTester tester,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: "123",
    );

    late BuildContext ctx;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(builder: (context) {
          ctx = context;

          return Scaffold(
            body: PasswordInputComponent(
              controller: controller,
            ),
          );
        }),
      ),
    );

    final textField = find.byType(TextField);

    await tester.tap(textField);

    FocusScope.of(ctx).unfocus();

    await tester.pumpAndSettle();

    final errorFinder = find.text("Invalid password");

    expect(errorFinder, findsOneWidget);
  });

  testWidgets("Should expect an error when password is invalid (min 3)", (
    WidgetTester tester,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: "123",
    );

    late BuildContext ctx;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(builder: (context) {
          ctx = context;

          return Scaffold(
            body: PasswordInputComponent(
              controller: controller,
              minValidLength: 3,
            ),
          );
        }),
      ),
    );

    final textField = find.byType(TextField);

    await tester.tap(textField);

    FocusScope.of(ctx).unfocus();

    await tester.pumpAndSettle();

    final errorFinder = find.text("Invalid password");

    expect(errorFinder, findsOneWidget);
  });
}

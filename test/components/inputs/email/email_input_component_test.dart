import "package:com_nicodevelop_dotmessenger/components/inputs/email/email_input_component.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  testWidgets("Should expect 'E-mail' label in textfield", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmailInputComponent(
            controller: TextEditingController(),
          ),
        ),
      ),
    );

    final textFinder = find.text("E-mail");

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      "Should expect an error when textfield is blur an email is invalid", (
    WidgetTester tester,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: "invalid-email",
    );

    late BuildContext ctx;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(builder: (context) {
          ctx = context;

          return Scaffold(
            body: EmailInputComponent(
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

    final errorFinder = find.text("Invalid e-mail");

    expect(errorFinder, findsOneWidget);
  });
}

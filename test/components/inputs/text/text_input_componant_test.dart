import "package:com_nicodevelop_boilerplate/components/inputs/text/text_input_component.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  testWidgets(
      "Should expect error message if text field is required without value",
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController(
      text: "",
    );

    late BuildContext ctx;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(builder: (context) {
          ctx = context;

          return Scaffold(
            body: TextInputComponent(
              controller: controller,
              isRequire: true,
            ),
          );
        }),
      ),
    );

    final textField = find.byType(TextField);

    await tester.tap(textField);

    FocusScope.of(ctx).unfocus();

    await tester.pumpAndSettle();

    final errorFinder = find.text("Required field");

    expect(errorFinder, findsOneWidget);
  });
}

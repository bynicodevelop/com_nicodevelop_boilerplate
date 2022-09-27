import 'package:com_nicodevelop_dotmessenger/components/profile/avatar/profile_avatar_component.dart';
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:network_image_mock/network_image_mock.dart";

void main() {
  testWidgets("Should show initial form username", (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileAvatarComponent(
            username: "nico develop",
          ),
        ),
      ),
    );

    expect(find.text("ND"), findsOneWidget);
  });

  testWidgets("Should not show initial form username",
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileAvatarComponent(
              username: "nico develop",
              url: "https://avatars.githubusercontent.com/u/45257698?v=4",
            ),
          ),
        ),
      );

      expect(find.text("ND"), findsNothing);
    });
  });
}

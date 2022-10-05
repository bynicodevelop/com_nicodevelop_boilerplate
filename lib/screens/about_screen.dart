import "package:about_screen/about_screen.dart";
import "package:com_nicodevelop_boilerplate/config/constants.dart";
import "package:flutter/material.dart";
import "package:package_info_plus/package_info_plus.dart";

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
        ),
      ),
      body: Center(
        child: FutureBuilder<PackageInfo>(
            // ignore: discarded_futures
            future: PackageInfo.fromPlatform(),
            builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
              final String version =
                  snapshot.hasData ? snapshot.data!.version : "Unknown version";

              return aboutScreen(
                "Dot Messenger",
                applicationVersion: version,
                // applicationIcon: ...,
                applicationLegalese: kCredits,
              );
            }),
      ),
    );
  }
}

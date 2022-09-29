import "package:clipboard/clipboard.dart";
import "package:com_nicodevelop_dotmessenger/config/constants.dart";
import "package:com_nicodevelop_dotmessenger/utils/notifications.dart";
import "package:com_nicodevelop_dotmessenger/utils/translate.dart";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

class ShareAffiliateCodeScreen extends StatelessWidget {
  const ShareAffiliateCodeScreen({Key? key}) : super(key: key);

  Future<void> _copyCode(String code) async =>
      await FlutterClipboard.copy(code);

  Widget _iconButton(
    BuildContext context,
    IconData icon,
    String text,
    Function() onPressed,
  ) {
    return Column(
      children: [
        IconButton(
          iconSize: kDefaultPadding * 2.5,
          onPressed: onPressed,
          icon: Icon(
            icon,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }

  Widget _bottomSheet(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          top: kDefaultPadding * 3,
          bottom: kDefaultPadding * 5,
        ),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: kDefaultPadding * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t(context)!.share_text_title,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconButton(
                  context,
                  Icons.copy,
                  t(context)!.share_label_button_copy,
                  () async => _copyCode("1234").then(
                    (value) => sendNotificaton(
                      context,
                      t(context)!.share_code_copied_title,
                      t(context)!.share_code_copied_description,
                    ),
                  ),
                ),
                _iconButton(
                  context,
                  Icons.sms,
                  t(context)!.share_label_button_sms,
                  () async {
                    Uri uri = Uri(
                      scheme: "sms",
                      path: "",
                      query: "body=hello there",
                    );

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw "Could not launch $uri";
                    }
                  },
                ),
                _iconButton(
                  context,
                  Icons.mail,
                  t(context)!.share_label_button_email,
                  () async {
                    Uri uri = Uri(
                      scheme: "mailto",
                      path: "",
                      query: "subject=App Feedback&body=App Version 3.23",
                    );

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw "Could not launch $uri";
                    }
                  },
                ),
              ],
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(
          kDefaultPadding * 2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              t(context)!.share_text,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: kDefaultPadding * 3,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(
                  kDefaultPadding,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  kDefaultPadding,
                ),
                onTap: () async =>
                    _copyCode("1234").then((value) => sendNotificaton(
                          context,
                          t(context)!.share_code_copied_title,
                          t(context)!.share_code_copied_description,
                        )),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding,
                        horizontal: kDefaultPadding * 3,
                      ),
                      child: Text(
                        "1234",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    const Positioned(
                      right: kDefaultPadding * .7,
                      top: kDefaultPadding * .7,
                      child: Icon(
                        Icons.copy,
                        color: Colors.grey,
                        size: kDefaultPadding * 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 3,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async => showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        kDefaultPadding,
                      ),
                    ),
                  ),
                  context: context,
                  builder: (context) => _bottomSheet(context),
                ),
                child: Text(
                  t(context)!.share_text_button,
                ),
              ),
            ),
            const SizedBox(
              height: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}

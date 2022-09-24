import "package:com_nicodevelop_dotmessenger/config/constants.dart";
import "package:com_nicodevelop_dotmessenger/screens/authentication/signup_screen.dart";
import "package:com_nicodevelop_dotmessenger/services/search_affiliate_code/search_affiliate_code_bloc.dart";
import "package:com_nicodevelop_dotmessenger/utils/notifications.dart";
import "package:com_nicodevelop_dotmessenger/utils/translate.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CodeScreen extends StatefulWidget {
  const CodeScreen({Key? key}) : super(key: key);

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final List<String> codes = [];

  @override
  Widget build(BuildContext context) {
    final width =
        (MediaQuery.of(context).size.width - kDefaultPadding * 3 * (3 - 1)) / 3;

    return BlocListener<SearchAffiliateCodeBloc, SearchAffiliateCodeState>(
      listener: (context, state) async {
        if (state is SearchAffiliateCodeSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpScreen(
                affiliateCode: codes.join(""),
              ),
            ),
            (route) => false,
          );

          return;
        }

        if (state is SearchAffiliateCodeErrorState) {
          setState(() => codes.clear());

          sendNotificaton(
            context,
            t(context)!.affiliate_code_invalid_title,
            t(context)!.affiliate_code_invalid_message,
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(
            kDefaultPadding,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Sponsor code",
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          codes.isNotEmpty ? codes[0] : "•",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPadding,
                      ),
                      Flexible(
                        child: Text(
                          codes.length > 1 ? codes[1] : "•",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPadding,
                      ),
                      Flexible(
                        child: Text(
                          codes.length > 2 ? codes[2] : "•",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPadding,
                      ),
                      Flexible(
                        child: Text(
                          codes.length > 3 ? codes[3] : "•",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  Wrap(
                    runSpacing: kDefaultPadding,
                    spacing: kDefaultPadding,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      10,
                      (index) => SizedBox(
                        width: width,
                        height: width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (codes.length < 4) {
                                  codes.add((index < 9 ? "${index + 1}" : "0")
                                      .toString());
                                }
                              });

                              if (codes.length == 4) {
                                context.read<SearchAffiliateCodeBloc>().add(
                                      OnSearchAffiliateCodeEvent(
                                        affiliateCode: codes.join(),
                                      ),
                                    );
                              }
                            },
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            child: Center(
                              child: Text(
                                index < 9 ? "${index + 1}" : "0",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

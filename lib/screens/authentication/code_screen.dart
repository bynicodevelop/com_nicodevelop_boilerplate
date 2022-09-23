import "package:com_nicodevelop_dotmessenger/components/inputs/text/text_input_component.dart";
import "package:com_nicodevelop_dotmessenger/config/constants.dart";
import "package:com_nicodevelop_dotmessenger/services/search_affiliate_code/search_affiliate_code_bloc.dart";
import "package:com_nicodevelop_dotmessenger/utils/translate.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CodeScreen extends StatefulWidget {
  const CodeScreen({Key? key}) : super(key: key);

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final TextEditingController _codeController = TextEditingController();

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocus,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              kDefaultPadding,
            ),
            child: Column(
              children: [
                Text(
                  t(context)!.invitation_code_title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                TextInputComponent(
                  controller: _codeController,
                  isRequire: true,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _unfocus();

                      if (_codeController.text.isEmpty) {
                        return;
                      }

                      context.read<SearchAffiliateCodeBloc>().add(
                            OnSearchAffiliateCodeEvent(
                              affiliateCode: _codeController.text,
                            ),
                          );
                    },
                    child: Text(t(context)!.next_label),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

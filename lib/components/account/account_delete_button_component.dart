import "package:com_nicodevelop_dotmessenger/services/delete_account/delete_account_bloc.dart";
import "package:com_nicodevelop_dotmessenger/utils/notifications.dart";
import "package:com_nicodevelop_dotmessenger/utils/translate.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:show_confirm_modal/show_confirm_modal.dart";

class AccountDeleteButtonComponent extends StatelessWidget {
  const AccountDeleteButtonComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountBloc, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccessState) {
          sendNotificaton(
            context,
            t(context)!.delete_account_button_confirm_deleted_title,
            t(context)!.delete_account_button_confirm_deleted_description,
          );
        }
      },
      child: ElevatedButton(
        onPressed: () async {
          await showConfirm(
            context: context,
            title: t(context)!.delete_account_button_confirm_modal_title,
            content:
                t(context)!.delete_account_button_confirm_modal_description,
            confirmText: t(context)!.common_confirm,
            cancelText: t(context)!.common_cancel,
            onCancel: () {},
            onConfirm: () => context.read<DeleteAccountBloc>().add(
                  OnDeleteAccountEvent(),
                ),
          );
        },
        child: const Text("Delete Account"),
      ),
    );
  }
}

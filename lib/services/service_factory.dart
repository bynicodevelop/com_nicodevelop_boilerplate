import "package:cloud_firestore/cloud_firestore.dart";
import "package:cloud_functions/cloud_functions.dart";
import "package:com_nicodevelop_dotmessenger/models/ready_start_model.dart";
import "package:com_nicodevelop_dotmessenger/repositories/account_repository.dart";
import "package:com_nicodevelop_dotmessenger/repositories/affiliate_repository.dart";
import "package:com_nicodevelop_dotmessenger/repositories/authentication_repository.dart";
import "package:com_nicodevelop_dotmessenger/repositories/discussion_repository.dart";
import "package:com_nicodevelop_dotmessenger/repositories/upload_repository.dart";
import "package:com_nicodevelop_dotmessenger/services/authentication_status/authentication_status_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/bloc/list_discussion_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/bootstrap/bootstrap_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/create_account/create_account_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/delete_account/delete_account_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/get_affiliate_code/get_affiliate_code_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/login/login_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/logout/logout_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/search_affiliate_code/search_affiliate_code_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/update_account/update_account_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/upload_file/upload_file_bloc.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ServiceFactory extends StatelessWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseFunctions firebaseFunctions;

  final Widget child;

  const ServiceFactory({
    super.key,
    required this.child,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.firebaseFunctions,
  });

  @override
  Widget build(BuildContext context) {
    final AffiliateRepository affiliateRepository = AffiliateRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );

    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository(
      firebaseAuth: firebaseAuth,
    );

    final AccountRepository accountRepository = AccountRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );

    final UploadRepository uploadRepository = UploadRepository(
      firebaseAuth: firebaseAuth,
      firebaseStorage: firebaseStorage,
    );

    final DiscussionRepository discussionRepository = DiscussionRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<BootstrapBloc>(
          create: (_) => BootstrapBloc()
            ..add(OnBootstrapEvent(
              readyStartModel: ReadyStartModel(),
            )),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AuthenticationStatusBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<SearchAffiliateCodeBloc>(
          create: (context) => SearchAffiliateCodeBloc(
            affiliateRepository: affiliateRepository,
          ),
        ),
        BlocProvider<GetAffiliateCodeBloc>(
          create: (context) => GetAffiliateCodeBloc(
            affiliateRepository: affiliateRepository,
          ),
        ),
        BlocProvider<CreateAccountBloc>(
          create: (context) => CreateAccountBloc(
            accountRepository: accountRepository,
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationRepository: AuthenticationRepository(
              firebaseAuth: firebaseAuth,
            ),
          ),
        ),
        BlocProvider<UpdateAccountBloc>(
          create: (context) => UpdateAccountBloc(
            accountRepository: accountRepository,
          ),
        ),
        BlocProvider<DeleteAccountBloc>(
          create: (context) => DeleteAccountBloc(
            accountRepository: accountRepository,
          ),
        ),
        BlocProvider<LogoutBloc>(
          create: (context) => LogoutBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<UploadFileBloc>(
          create: (context) => UploadFileBloc(
            uploadRepository: uploadRepository,
          ),
        ),
        BlocProvider<ListDiscussionBloc>(
          lazy: false,
          create: (context) => ListDiscussionBloc(
            discussionRepository: discussionRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}

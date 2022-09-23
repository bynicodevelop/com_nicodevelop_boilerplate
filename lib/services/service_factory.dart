import "package:cloud_firestore/cloud_firestore.dart";
import "package:cloud_functions/cloud_functions.dart";
import "package:com_nicodevelop_dotmessenger/components/list_messages/bloc/get_list_message_bloc.dart";
import "package:com_nicodevelop_dotmessenger/repositories/messages_repository.dart";
import "package:com_nicodevelop_dotmessenger/repositories/affiliate_repository.dart";
import "package:com_nicodevelop_dotmessenger/services/bootstrap/bootstrap_bloc.dart";
import "package:com_nicodevelop_dotmessenger/services/search_affiliate_code/search_affiliate_code_bloc.dart";
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
    final AffiliateRepository parrainageRepository = AffiliateRepository(
      firebaseFirestore: firebaseFirestore,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<BootstrapBloc>(
          create: (_) => BootstrapBloc()..add(OnBootstrapEvent()),
        ),
        BlocProvider<GetListMessageBloc>(
          create: (context) => GetListMessageBloc(
            messageRepository: MessagesRepository(),
          )..add(OnGetListMessageEvent()),
        ),
        BlocProvider<SearchAffiliateCodeBloc>(
          create: (context) => SearchAffiliateCodeBloc(
            parrainageRepository: parrainageRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}

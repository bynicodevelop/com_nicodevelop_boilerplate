class ReadyStartModel {
  final bool authenticationStatus;

  ReadyStartModel({
    this.authenticationStatus = false,
  });

  ReadyStartModel copyWith({
    bool? authenticationStatus,
  }) =>
      ReadyStartModel(
        authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      );

  bool isReady() {
    return authenticationStatus;
  }

  Map<String, dynamic> toMap() => {
        "authenticationStatus": authenticationStatus,
      };
}

class AuthTokenModel {
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? scope;

  AuthTokenModel(
      {this.accessToken, this.expiresIn, this.tokenType, this.scope});

  AuthTokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    tokenType = json['token_type'];
    scope = json['scope'];
  }

  @override
  String toString() {
    return '{"accessToken : $accessToken","expiresIn : $expiresIn","tokenType : $tokenType,"scope : $scope"}';
  }
}

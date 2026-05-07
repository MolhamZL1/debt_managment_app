abstract class BackendEndPoint {
  static const String url = 'https://api.sajilha.app';
  static const String signIn = '/api/auth/login';
  static const String signUp = '/api/auth/register';
  static const String signOut = '/api/auth/logout';
  static const String refresh = '/api/auth/refresh';
  static const String me = '/api/auth/me';
  static const String resendCode = '/api/auth/resend/code';
  static const String activeCode = '/api/auth/active/code';
  static const String forgotPassword = '/api/auth/password/forgot';
  static const String verifyforgetpasswordCode =
      '/api/auth/password/code/verify';
  static const String resetPassword = '/api/auth/password/reset';
  static const String clientes = '/api/client/index/';
  static const String clienteData = '/api/client/show/';
  static const String addClient = "/api/client/store";
  static const String clientsSearch = '/api/client/search';
  static const String debtsClient = '/api/debts/client/';
  static const String deleteClient = '/api/client/destroy/';
  static const String addDebt = '/api/debts/store';
  static const String paymentsClinet = '/api/payments/client/';
  static const String addPayment = '/api/payments/store';
  static const String transactionsClient = '/api/clients/transactions/';
  static const String transaction = "/api/transactions/";
  static const String homeView = '/api/total_account';
}

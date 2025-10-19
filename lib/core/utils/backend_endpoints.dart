abstract class BackendEndPoint {
  static const String url = 'http://10.0.2.2:8000';
  static const String signIn = '/api/auth/login';
  static const String signUp = '/api/auth/register';
  static const String signOut = '/api/auth/logout';
  static const String refresh = '/api/auth/refresh';
  static const String clientes = '/api/client/index/';
  static const String clienteData = '/api/client/show/';
  static const String addClient = "/api/client/store";
  static const String clientsSearch = '/api/client/search';
  static const String debtsClient = '/api/debts/client/';
  static const String addDebt = '/api/debts/store';
  static const String paymentsClinet = '/api/payments/client/';
  static const String addPayment = '/api/payments/store';
  static const String transactionsClient = '/api/clients/transactions/';
  static const String transaction = "/api/transactions/";
  static const String homeView = '/api/total_account';
}

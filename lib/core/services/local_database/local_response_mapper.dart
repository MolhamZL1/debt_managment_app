abstract class LocalResponseMapper {
  static Map<String, dynamic> debt(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'client_id': row['client_id'],
      'description': row['description'],
      'amount': row['amount'].toString(),
      'debt_date': row['debt_date'],
    };
  }

  static Map<String, dynamic> payment(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'client_id': row['client_id'],
      'notes': row['notes'],
      'amount': row['amount'].toString(),
      'payment_date': row['payment_date'],
    };
  }

  static Map<String, dynamic> transaction(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'client_id': row['client_id'],
      'client': {'name': row['client_name']},
      'date': row['date'],
      'description': row['description'],
      'amount': row['amount'].toString(),
      'type': row['type'],
    };
  }

  static Map<String, dynamic> clientTransaction(Map<String, dynamic> row) {
    final type = row['type'];
    final dateKey = type == 'debt' ? 'debt_date' : 'payment_date';
    final descriptionKey = type == 'debt' ? 'description' : 'notes';

    return {
      'id': row['id'],
      'client_id': row['client_id'],
      'amount': row['amount'].toString(),
      descriptionKey: row['description'],
      dateKey: row['date'],
      'type': type,
    };
  }

  static Map<String, dynamic> localAuthResult() {
    return {
      'result': {
        'user': {
          'id': 1,
          'name': 'مستخدم محلي',
          'email': 'offline@sajilha.local',
          'mobile': '',
        },
        'token': {'access_token': 'local'},
        'access_token': 'local',
      },
    };
  }
}

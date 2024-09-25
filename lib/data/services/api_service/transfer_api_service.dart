import 'dart:convert';
import 'package:expenseecho/data/services/config.dart';
import 'package:expenseecho/data/services/queue_manager.dart';
import 'package:http/http.dart' as http;
import 'package:expenseecho/data/models/transfers/transfers_model.dart';

class TransferAPIService {
  static Future<List<TransfersModel>> fetchTransfers() async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/api/collections/transfers/records'),
    );

    print(
        "---> JSON Status code :: Get Transfer List ::${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      return items.map((item) => TransfersModel.fromMap(item)).toList();
    } else {
      throw Exception('---> Failed to load transfer list');
    }
  }

  static Future<bool> createTransfer({
    required String userId,
    required String fromAccountId,
    required String toAccountId,
    required String description,
    required double amount,
  }) async {
    final Map<String, dynamic> body = {
      'user_id': userId,
      'from_account_id': fromAccountId,
      'to_account_id': toAccountId,
      'description': description,
      'amount': amount,
    };

    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/collections/transfers/records'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    print("---> JSON Status code :: Create Transfer :: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("---> Transfer created successfully");
      return true;
    } else {
      print("---> Failed to create transfer: ${response.body}");
      throw Exception(
          '---> Failed to create transfer :: ${response.reasonPhrase}');
    }
  }

  static Future<bool> updateTransfer({
    required TransfersModel transferModel,
    String? transferId,
  }) async {
    print('---> Transfer ID :: update:: $transferId ');
    print('---> Transfer body :: update:: ${transferModel.toJson()} ');
    final uri = Uri.parse(
        '${Config.baseUrl}/api/collections/transfers/records/$transferId');
    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: transferModel.toJson(),
    );
    print('---> URL :: update:: $uri ');
    print('---> Status code :: update:: ${response.statusCode} ');

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update transfer: ${response.reasonPhrase}');
      return false;
    }
  }

  static Future<bool> deleteTransfer({required String transferId}) async {
    final response = await http.delete(
      Uri.parse(
          '${Config.baseUrl}/api/collections/transfers/records/$transferId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print("---> JSON Status code :: Delete Transfer :: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("---> Transfer deleted successfully");
      return true;
    } else {
      print("---> Failed to delete transfer: ${response.body}");
      throw Exception(
          '---> Failed to delete transfer :: ${response.reasonPhrase}');
    }
  }

  static Future<void> addTransferToQueue(TransfersModel transfer) async {
    await QueueManager().addTransactionToQueue('transfer', transfer.toMap());
  }
}

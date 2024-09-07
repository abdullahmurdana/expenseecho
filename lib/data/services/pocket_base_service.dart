import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  static const String url = 'https://ffd9-103-72-2-72.ngrok-free.app';
  static final pocketBase = PocketBase(url);

  static Future<String> signIn(
      {required String identity, required String password}) async {
    late RecordAuth authData;
    await pocketBase
        .collection('users')
        .authWithPassword(identity, password)
        .then((value) {
      authData = value;
    });
    print("---> Record Auth :: ${authData.token}");

    return authData.token;
  }

  static Future<List<dynamic>> getExpenses() async {
    // you can also fetch all records at once via getFullList
    final records = await pocketBase.collection('expenses').getFullList();
    return records;
  }

  static Future<List<dynamic>> getIncomeList() async {
    // you can also fetch all records at once via getFullList
    final records = await pocketBase.collection('income').getFullList();
    return records;
  }
}

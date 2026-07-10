import 'package:get/get.dart';

class ExportDataScreenController extends GetxController {
  var dataType = 'All'.obs;
  var dateRange = 'Last 7 days'.obs;
  var dataFormat = 'CSV'.obs;

  final List<String> dataTypes = ['All', 'Expenses', 'Incomes'];
  final List<String> dateRanges = [
    'Last 7 days',
    'Last 14 days',
    'Last 30 days'
  ];
  final List<String> dataFormats = ['CSV', 'Excel', 'PDF'];
}

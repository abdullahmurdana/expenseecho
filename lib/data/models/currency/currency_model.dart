// ignore_for_file: public_member_api_docs, sort_constructors_first
class CurrencyModel {
  final String shortForm;
  final String fullName;
  final String symbol;

  CurrencyModel({
    required this.shortForm,
    required this.fullName,
    required this.symbol,
  });

  // Method to convert Currency object to JSON
  Map<String, dynamic> toJson() => {
        'shortForm': shortForm,
        'fullName': fullName,
        'symbol': symbol,
      };

  // Method to create Currency object from JSON
  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      shortForm: json['shortForm'],
      fullName: json['fullName'],
      symbol: json['symbol'],
    );
  }

  @override
  String toString() =>
      'CurrencyModel(shortForm: $shortForm, fullName: $fullName, symbol: $symbol)';
}

final List<CurrencyModel> currencies = [
  CurrencyModel(
      shortForm: 'USD', fullName: 'United States Dollar', symbol: '\$'),
  CurrencyModel(shortForm: 'EUR', fullName: 'Euro', symbol: '€'),
  CurrencyModel(shortForm: 'GBP', fullName: 'British Pound', symbol: '£'),
  CurrencyModel(
      shortForm: 'AED', fullName: 'United Arab Emirates Dirham', symbol: 'د.إ'),
  CurrencyModel(shortForm: 'JPY', fullName: 'Japanese Yen', symbol: '¥'),
  CurrencyModel(shortForm: 'PKR', fullName: 'Pakistani Rupee', symbol: '₨'),
  CurrencyModel(shortForm: 'INR', fullName: 'Indian Rupee', symbol: '₹'),
  CurrencyModel(shortForm: 'KRW', fullName: 'South Korean Won', symbol: '₩'),
  CurrencyModel(shortForm: 'IDR', fullName: 'Indonesian Rupiah', symbol: 'Rp'),
  CurrencyModel(shortForm: 'RUB', fullName: 'Russian Ruble', symbol: '₽'),
  CurrencyModel(shortForm: 'CAD', fullName: 'Canadian Dollar', symbol: '\$'),
  CurrencyModel(shortForm: 'AUD', fullName: 'Australian Dollar', symbol: '\$'),
  CurrencyModel(shortForm: 'BDT', fullName: 'Bangladeshi Taka', symbol: '৳'),
  CurrencyModel(shortForm: 'CNY', fullName: 'Chinese Yuan', symbol: '¥'),
  CurrencyModel(shortForm: 'NZD', fullName: 'New Zealand Dollar', symbol: '\$'),
  CurrencyModel(shortForm: 'TRY', fullName: 'Turkish Lira', symbol: '₺'),
];

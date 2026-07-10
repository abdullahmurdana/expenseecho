const String createTransactionTable = r'''
CREATE TABLE transactions (
  id TEXT PRIMARY KEY,
  type TEXT,
  data TEXT
);
''';

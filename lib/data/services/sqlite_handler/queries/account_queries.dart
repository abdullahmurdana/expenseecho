const String createAccountTable = r'''
      CREATE TABLE accounts (
        id TEXT PRIMARY KEY,
        user_id TEXT,
        name TEXT,
        type TEXT,
        balance REAL,
        created TEXT,
        updated TEXT
      )
    ''';

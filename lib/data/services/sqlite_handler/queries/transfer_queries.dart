const String createTransferTable = r'''
      CREATE TABLE transfers (
        id TEXT PRIMARY KEY,
        user_id TEXT,
        from_account_id TEXT,
        to_account_id TEXT,
        amount REAL,
        description TEXT,
        created TEXT,
        updated TEXT
      )
    ''';

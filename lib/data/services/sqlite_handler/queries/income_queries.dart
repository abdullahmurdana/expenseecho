const String createIncomeTable = r'''
      CREATE TABLE incomes (
        id TEXT PRIMARY KEY,
        created TEXT,
        updated TEXT,
        user_id TEXT,
        account_id TEXT,
        category TEXT,
        title TEXT,
        description TEXT,
        income_amount REAL,
        attachment_link TEXT,
        repeated INTEGER,
        frequency TEXT,
        start_date TEXT,
        end_after_date TEXT
      )
    ''';

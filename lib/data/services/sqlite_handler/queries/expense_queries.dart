const String createExpenseTable = r'''
      CREATE TABLE expenses(
        id TEXT PRIMARY KEY,
        user_id TEXT,
        account_id TEXT,
        category TEXT,
        title TEXT,
        description TEXT,
        expense_amount REAL,
        attachment_link TEXT,
        repeated INTEGER,
        frequency TEXT,
        end_after_date TEXT,
        start_date TEXT,
        created TEXT,
        updated TEXT
      )
    ''';

const String createBudgetTable = r'''
      CREATE TABLE budgets (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        category TEXT NOT NULL,
        budget_amount INTEGER NOT NULL,
        receive_alert INTEGER,
        alert_percentile INTEGER,
        created TEXT,
        updated TEXT
      )
    ''';

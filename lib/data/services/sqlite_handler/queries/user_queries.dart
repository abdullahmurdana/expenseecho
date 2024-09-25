const String createUserTable = r'''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT,
        username TEXT,
        password TEXT,
        avatar_link TEXT,
        created TEXT,
        updated TEXT
      )
    ''';

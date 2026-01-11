const createVssTableSql = '''
CREATE VIRTUAL TABLE IF NOT EXISTS vss_vectors
USING vss0(
  id TEXT PRIMARY KEY,
  embedding BLOB,
  metadata TEXT
);
''';

import 'package:sqflite/sqlite_api.dart';

class TestDraftRepository {
  TestDraftRepository({required Database testDraftRepository})
      : _testDraftRepository = testDraftRepository;

  //database
  final Database _testDraftRepository;
}

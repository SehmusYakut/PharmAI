import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:pharmai/data/datasources/local/drug_json_parser.dart';
import 'package:pharmai/data/datasources/local/icd10_csv_parser.dart';
import 'package:pharmai/data/models/bookmark_model.dart';
import 'package:pharmai/data/models/drug_model.dart';
import 'package:pharmai/data/models/icd10_code_model.dart';
import 'package:pharmai/data/models/local_profile_model.dart';

import 'package:pharmai/data/models/chat_session_model.dart';
import 'package:pharmai/data/models/chat_message_model.dart';
import 'package:pharmai/data/models/chat_usage_model.dart';

class SeedRequest {
  const SeedRequest({
    required this.dbDirectory,
    required this.dbName,
    required this.rootIsolateToken,
  });

  final String dbDirectory;
  final String dbName;
  final RootIsolateToken rootIsolateToken;
}

/// Runs first-launch seeding in a background isolate to avoid UI jank.
Future<void> seedLocalDatabaseInBackground(SeedRequest request) async {
  await Isolate.run(() async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
      request.rootIsolateToken,
    );
    await Isar.initializeIsarCore(download: true);

    final isar = await Isar.open(
      [
        Icd10CodeModelSchema,
        LocalProfileModelSchema,
        BookmarkModelSchema,
        DrugModelSchema,
        ChatSessionModelSchema,
        ChatMessageModelSchema,
        ChatUsageModelSchema,
      ],
      directory: request.dbDirectory,
      name: request.dbName,
    );

    final icd10Count = await isar.icd10CodeModels.count();
    if (icd10Count == 0) {
      final raw = await rootBundle.loadString('assets/data/icd10_codes.csv');
      final models = Icd10CsvParser.parseRaw(raw);
      await isar.writeTxn(() => isar.icd10CodeModels.putAll(models));
    }

    final drugCount = await isar.drugModels.count();
    if (drugCount == 0) {
      final raw = await rootBundle.loadString('assets/data/drugs_data.json');
      final models = DrugJsonParser.parseRaw(raw);
      await isar.writeTxn(() => isar.drugModels.putAll(models));
    }

    await isar.close();
  });
}

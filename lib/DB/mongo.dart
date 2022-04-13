import 'package:mongo_dart/mongo_dart.dart';
import 'package:vibe/DB/constants.dart';

class Mongo {
  static var db;
  static var dataTaggingCollection;

  static openConnection() async {
    db = await Db.create(MONGO_CONNECTION_URL);
    await db.open();

    dataTaggingCollection = db.collection(DATA_TAGGING_COLLECTION);
  }

  static closeConnection() async {
    await db.close();
  }

  static addOneToCollection(Map<String, dynamic> itemToAdd) async {
    dataTaggingCollection.insertMany([itemToAdd]);
  }

  static getDataTaggingCollection() async {
    return await dataTaggingCollection;
  }
}

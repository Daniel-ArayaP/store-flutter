import 'package:flutter_kotlin_1/src/models/market.dart';
import 'package:flutter_kotlin_1/src/models/product.dart';
import 'package:flutter_kotlin_1/src/services/firestore_service.dart';

class CustomerBloc {
  final db = FirestoreService();

  //Get
  Stream<List<Market>> get fetchUpcomingMarkets => db.fetchUpcomingMarkets();
  Stream<List<Product>> get fetchAvailableProducts => db.fetchAvailableProducts();

  dispose(){
    
  }
}
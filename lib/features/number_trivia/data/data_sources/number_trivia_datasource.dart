import 'package:injectable/injectable.dart';

import '../../../../core/network/network_client.dart';
import '../../domain/usecases/get_number_trivia_usecase.dart';
import '../models/trivia_model.dart';

//This is a sample datasource file

// Abstract class representing a data source for fetching number trivia
abstract class NumberTriviaDataSource {
  Future<TriviaModel> getConcreteTrivia(
      NumberParam params); // Method for getting concrete trivia
}

// Registering NumberTriviaDataSource as a lazy singleton for dependency injection
@LazySingleton(as: NumberTriviaDataSource)
@injectable
class NumberTriviaDataSourceImpl implements NumberTriviaDataSource {
  final NetworkClient client;

  NumberTriviaDataSourceImpl(
      this.client); // Constructor injecting NetworClient dependency

  @override
  Future<TriviaModel> getConcreteTrivia(NumberParam params) async {
    try {
      // Making GET request to fetch trivia
    final response = await client.get(
        path: "/${params.number}/trivia?json",
        requiresAuth: false,
      );
      // Parsing response data into TriviaModel
      return TriviaModel.fromJson(response.data);
    } catch (e) {
      //throwing exception
      rethrow;
    }
  }
}



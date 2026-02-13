import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../entities/trivia_entity.dart';
import '../usecases/get_number_trivia_usecase.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, TriviaEntity>> getNumberTrivia(NumberParam params);
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../domain/entities/trivia_entity.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../../domain/usecases/get_number_trivia_usecase.dart';
import '../data_sources/number_trivia_datasource.dart';

@LazySingleton(as: NumberTriviaRepository)
@injectable
class NumberTriviaRepoImpl implements NumberTriviaRepository {
  NumberTriviaDataSource numberTriviaDataSource;
  NumberTriviaRepoImpl(this.numberTriviaDataSource);

  @override
  Future<Either<Failure, TriviaEntity>> getNumberTrivia(
      NumberParam params) async {
    try {
      final trivia = await numberTriviaDataSource.getConcreteTrivia(params);
      return Right(trivia);
    } on CustomException catch (e) {
      return Left(Failure.apiRequestFailure(e.message));
    }
  }
}



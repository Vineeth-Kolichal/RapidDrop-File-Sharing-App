import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/failures/failures.dart';
import '../entities/trivia_entity.dart';
import '../repositories/number_trivia_repository.dart';

@lazySingleton
@injectable
class GetNumberTriviaUseCase implements UseCase<TriviaEntity, NumberParam> {
  NumberTriviaRepository numberTriviaRepository;
  GetNumberTriviaUseCase(this.numberTriviaRepository);
  @override
  Future<Either<Failure, TriviaEntity>> call(NumberParam params) async {
    return numberTriviaRepository.getNumberTrivia(params);
  }
}

class NumberParam {
  final int number;

  NumberParam(this.number);
}

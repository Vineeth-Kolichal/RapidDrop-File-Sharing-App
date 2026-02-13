import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/trivia_entity.dart'; // Importing domain entity
import '../../../domain/usecases/get_number_trivia_usecase.dart'; // Importing domain use case

part 'number_trivia_event.dart'; // Importing related event class
part 'number_trivia_state.dart'; // Importing related state class
part 'number_trivia_bloc.freezed.dart'; // Importing generated freezed file

@injectable
class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  TextEditingController numberController =
      TextEditingController(); // Controller for handling text input
  GetNumberTriviaUseCase useCase; // Instance of the use case
  NumberTriviaBloc(this.useCase) : super(NumberTriviaState.initial()) {
    on<GetTrivia>((event, emit) async {
      // Event handler for GetTrivia event
      emit(state.copyWith(
          isLoading: true,
          error: null,
          trivia: null)); // Emitting loading state
      final result = await useCase(
        NumberParam(
          int.parse(
            numberController.text.trim(), // Parsing the input to int
          ),
        ),
      );
      final newState = result.fold((fail) {
        // Handling failure result
        numberController.clear(); // Clearing text input
        return state.copyWith(
            isLoading: false,
            trivia: null,
            error: fail.error); // Emitting failure state
      }, (trivia) {
        // Handling success result
        numberController.clear(); // Clearing text input
        return state.copyWith(
            isLoading: false,
            error: null,
            trivia: trivia); // Emitting success state
      });
      emit(newState); // Emitting the new state
    });
  }

  @override
  Future<void> close() {
    numberController.dispose(); // Disposing the controller
    return super.close(); // Closing the bloc
  }
}

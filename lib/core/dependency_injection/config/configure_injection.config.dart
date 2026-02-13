// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:file_sharing/core/dependency_injection/modules/dio_module.dart'
    as _i286;
import 'package:file_sharing/core/network/network_client.dart' as _i625;
import 'package:file_sharing/features/number_trivia/data/data_sources/number_trivia_datasource.dart'
    as _i644;
import 'package:file_sharing/features/number_trivia/data/repositories_impl/number_trivia_repo_impl.dart'
    as _i744;
import 'package:file_sharing/features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i832;
import 'package:file_sharing/features/number_trivia/domain/usecases/get_number_trivia_usecase.dart'
    as _i608;
import 'package:file_sharing/features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_bloc.dart'
    as _i418;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dioInstance);
    gh.lazySingleton<_i625.NetworkClient>(
      () => _i625.NetworkClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i644.NumberTriviaDataSource>(
      () => _i644.NumberTriviaDataSourceImpl(gh<_i625.NetworkClient>()),
    );
    gh.lazySingleton<_i832.NumberTriviaRepository>(
      () => _i744.NumberTriviaRepoImpl(gh<_i644.NumberTriviaDataSource>()),
    );
    gh.lazySingleton<_i608.GetNumberTriviaUseCase>(
      () => _i608.GetNumberTriviaUseCase(gh<_i832.NumberTriviaRepository>()),
    );
    gh.factory<_i418.NumberTriviaBloc>(
      () => _i418.NumberTriviaBloc(gh<_i608.GetNumberTriviaUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i286.DioModule {}

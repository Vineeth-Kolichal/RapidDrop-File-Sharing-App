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
import 'package:file_sharing/core/services/sharedprefs_services.dart' as _i467;
import 'package:file_sharing/features/local_server/data/datasources/shelf_server_datasource.dart'
    as _i461;
import 'package:file_sharing/features/local_server/data/repositories/local_server_repository_impl.dart'
    as _i691;
import 'package:file_sharing/features/local_server/domain/repositories/local_server_repository.dart'
    as _i806;
import 'package:file_sharing/features/local_server/domain/usecases/add_file_usecase.dart'
    as _i245;
import 'package:file_sharing/features/local_server/domain/usecases/get_server_info_usecase.dart'
    as _i962;
import 'package:file_sharing/features/local_server/domain/usecases/remove_file_usecase.dart'
    as _i542;
import 'package:file_sharing/features/local_server/domain/usecases/start_server_usecase.dart'
    as _i864;
import 'package:file_sharing/features/local_server/domain/usecases/stop_server_usecase.dart'
    as _i140;
import 'package:file_sharing/features/local_server/domain/usecases/watch_shared_files_usecase.dart'
    as _i676;
import 'package:file_sharing/features/local_server/presentation/bloc/server_bloc.dart'
    as _i523;
import 'package:file_sharing/features/web_client/data/datasources/remote_server_datasource.dart'
    as _i1002;
import 'package:file_sharing/features/web_client/data/repositories/web_client_repository_impl.dart'
    as _i872;
import 'package:file_sharing/features/web_client/domain/repositories/web_client_repository.dart'
    as _i591;
import 'package:file_sharing/features/web_client/domain/usecases/connect_to_server_usecase.dart'
    as _i81;
import 'package:file_sharing/features/web_client/domain/usecases/delete_file_usecase.dart'
    as _i752;
import 'package:file_sharing/features/web_client/domain/usecases/get_file_list_usecase.dart'
    as _i273;
import 'package:file_sharing/features/web_client/domain/usecases/listen_to_notifications_usecase.dart'
    as _i387;
import 'package:file_sharing/features/web_client/domain/usecases/upload_file_usecase.dart'
    as _i497;
import 'package:file_sharing/features/web_client/domain/usecases/validate_pin_usecase.dart'
    as _i1015;
import 'package:file_sharing/features/web_client/presentation/bloc/client_bloc.dart'
    as _i700;
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
    gh.lazySingleton<_i467.SharedPrefsServices>(
      () => _i467.SharedPrefsServices(),
    );
    gh.lazySingleton<_i461.ShelfServerDataSource>(
      () => _i461.ShelfServerDataSource(),
    );
    gh.lazySingleton<_i625.NetworkClient>(
      () => _i625.NetworkClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1002.RemoteServerDataSource>(
      () => _i1002.RemoteServerDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i806.LocalServerRepository>(
      () => _i691.LocalServerRepositoryImpl(gh<_i461.ShelfServerDataSource>()),
    );
    gh.lazySingleton<_i591.WebClientRepository>(
      () => _i872.WebClientRepositoryImpl(gh<_i1002.RemoteServerDataSource>()),
    );
    gh.lazySingleton<_i245.AddFileUseCase>(
      () => _i245.AddFileUseCase(gh<_i806.LocalServerRepository>()),
    );
    gh.lazySingleton<_i962.GetServerInfoUseCase>(
      () => _i962.GetServerInfoUseCase(gh<_i806.LocalServerRepository>()),
    );
    gh.lazySingleton<_i542.RemoveFileUseCase>(
      () => _i542.RemoveFileUseCase(gh<_i806.LocalServerRepository>()),
    );
    gh.lazySingleton<_i864.StartServerUseCase>(
      () => _i864.StartServerUseCase(gh<_i806.LocalServerRepository>()),
    );
    gh.lazySingleton<_i140.StopServerUseCase>(
      () => _i140.StopServerUseCase(gh<_i806.LocalServerRepository>()),
    );
    gh.lazySingleton<_i676.WatchSharedFilesUseCase>(
      () => _i676.WatchSharedFilesUseCase(gh<_i806.LocalServerRepository>()),
    );
    gh.lazySingleton<_i81.ConnectToServerUseCase>(
      () => _i81.ConnectToServerUseCase(gh<_i591.WebClientRepository>()),
    );
    gh.lazySingleton<_i752.DeleteFileUseCase>(
      () => _i752.DeleteFileUseCase(gh<_i591.WebClientRepository>()),
    );
    gh.lazySingleton<_i273.GetFileListUseCase>(
      () => _i273.GetFileListUseCase(gh<_i591.WebClientRepository>()),
    );
    gh.lazySingleton<_i387.ListenToNotificationsUseCase>(
      () => _i387.ListenToNotificationsUseCase(gh<_i591.WebClientRepository>()),
    );
    gh.lazySingleton<_i497.UploadFileUseCase>(
      () => _i497.UploadFileUseCase(gh<_i591.WebClientRepository>()),
    );
    gh.lazySingleton<_i1015.ValidatePinUseCase>(
      () => _i1015.ValidatePinUseCase(gh<_i591.WebClientRepository>()),
    );
    gh.factory<_i523.ServerBloc>(
      () => _i523.ServerBloc(
        gh<_i864.StartServerUseCase>(),
        gh<_i140.StopServerUseCase>(),
        gh<_i962.GetServerInfoUseCase>(),
        gh<_i245.AddFileUseCase>(),
        gh<_i542.RemoveFileUseCase>(),
        gh<_i676.WatchSharedFilesUseCase>(),
      ),
    );
    gh.factory<_i700.ClientBloc>(
      () => _i700.ClientBloc(
        gh<_i81.ConnectToServerUseCase>(),
        gh<_i273.GetFileListUseCase>(),
        gh<_i497.UploadFileUseCase>(),
        gh<_i1015.ValidatePinUseCase>(),
        gh<_i752.DeleteFileUseCase>(),
        gh<_i387.ListenToNotificationsUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i286.DioModule {}

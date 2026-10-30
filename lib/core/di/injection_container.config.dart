// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tickify_task/features/scan_result/data/data_source/scan_result_mock_data_source.dart'
    as _i967;
import 'package:tickify_task/features/scan_result/data/repository/scan_result_repository_impl.dart'
    as _i900;
import 'package:tickify_task/features/scan_result/domain/repositories/scan_result_repository.dart'
    as _i490;
import 'package:tickify_task/features/scan_result/domain/use_cases/get_scan_result_use_case.dart'
    as _i560;
import 'package:tickify_task/features/scan_result/presentation/cubit/scan_result_cubit.dart'
    as _i733;
import 'package:tickify_task/features/ticket_wallet/data/data_source/ticket_wallet_mock_data_source.dart'
    as _i487;
import 'package:tickify_task/features/ticket_wallet/data/repository/ticket_wallet_repository_impl.dart'
    as _i384;
import 'package:tickify_task/features/ticket_wallet/domain/repositories/ticket_wallet_repository.dart'
    as _i321;
import 'package:tickify_task/features/ticket_wallet/domain/use_cases/get_tickets_use_case.dart'
    as _i237;
import 'package:tickify_task/features/ticket_wallet/presentation/cubit/ticket_wallet_cubit.dart'
    as _i480;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i487.TicketWalletDataSource>(
      () => _i487.TicketWalletMockDataSource(),
    );
    gh.lazySingleton<_i967.ScanResultDataSource>(
      () => _i967.ScanResultMockDataSource(),
    );
    gh.lazySingleton<_i490.ScanResultRepository>(
      () => _i900.ScanResultRepositoryImpl(gh<_i967.ScanResultDataSource>()),
    );
    gh.lazySingleton<_i321.TicketWalletRepository>(
      () =>
          _i384.TicketWalletRepositoryImpl(gh<_i487.TicketWalletDataSource>()),
    );
    gh.lazySingleton<_i560.GetScanResultUseCase>(
      () => _i560.GetScanResultUseCase(gh<_i490.ScanResultRepository>()),
    );
    gh.lazySingleton<_i237.GetTicketsUseCase>(
      () => _i237.GetTicketsUseCase(gh<_i321.TicketWalletRepository>()),
    );
    gh.factory<_i733.ScanResultCubit>(
      () => _i733.ScanResultCubit(
        getScanResultUseCase: gh<_i560.GetScanResultUseCase>(),
      ),
    );
    gh.factory<_i480.TicketWalletCubit>(
      () => _i480.TicketWalletCubit(
        getTicketsUseCase: gh<_i237.GetTicketsUseCase>(),
      ),
    );
    return this;
  }
}

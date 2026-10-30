import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tickify_task/core/navigation/app_routes.dart';
import 'package:tickify_task/features/scan_result/domain/entities/scan_result.dart';
import 'package:tickify_task/features/scan_result/presentation/cubit/scan_result_cubit.dart';
import 'package:tickify_task/features/scan_result/presentation/screens/scan_result_screen.dart';
import 'package:tickify_task/features/scan_result/presentation/screens/scan_screen.dart';

import '../../features/ticket_wallet/domain/entities/ticket.dart';
import '../../features/ticket_wallet/presentation/cubit/ticket_wallet_cubit.dart';
import '../../features/ticket_wallet/presentation/screens/ticket_details_screen.dart';
import '../../features/ticket_wallet/presentation/screens/ticket_wallet_screen.dart';
import '../di/injection_container.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.tickets,
  routes: [
    GoRoute(
      path: AppRoutes.tickets,
      builder: (context, state) {
        return BlocProvider<TicketWalletCubit>(
          create: (_) => getIt<TicketWalletCubit>()..getTickets(),
          child: const TicketWalletScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.ticketDetails,
      builder: (context, state) {
        final ticket = state.extra! as Ticket;

        return TicketDetailsScreen(ticket: ticket);
      },
    ),

    GoRoute(
      path: AppRoutes.scanResult,
      builder: (context, state) {
        final resultType =
            state.extra as ScanResultType? ?? ScanResultType.valid;

        return BlocProvider<ScanResultCubit>(
          create: (_) => getIt<ScanResultCubit>()..showResult(resultType),
          child: const ScanResultScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.scan,
      builder: (context, state) => const ScanScreen(),
    ),
  ],
);

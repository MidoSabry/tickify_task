import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tickify_task/core/navigation/app_routes.dart';
import 'package:tickify_task/core/theme/app_theme_controller.dart';
import 'package:tickify_task/core/widgets/shared_text.dart';

import '../../../../core/base/base_state.dart';
import '../../domain/entities/ticket.dart';
import '../cubit/ticket_wallet_cubit.dart';
import '../widgets/ticket_card.dart';

class TicketWalletScreen extends StatelessWidget {
  const TicketWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          tooltip: 'Open ticket scanner',
          onPressed: () => context.push(AppRoutes.scan),
          icon: const Icon(Icons.qr_code_scanner),
          label: const AppText(text: 'Scan demo'),
        ),
        appBar: AppBar(
          title: const AppText(text: 'My Tickets', size: AppTextSize.title),
          actions: [
            ValueListenableBuilder<ThemeMode>(
              valueListenable: AppThemeController.themeMode,
              builder: (context, themeMode, child) {
                final isDarkMode = themeMode == ThemeMode.dark;

                return IconButton(
                  tooltip: isDarkMode
                      ? 'Switch to light mode'
                      : 'Switch to dark mode',
                  icon: Icon(
                    isDarkMode
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                  ),
                  onPressed: AppThemeController.toggle,
                );
              },
            ),
            PopupMenuButton<String>(
              tooltip: 'Demo states',
              onSelected: (value) {
                final cubit = context.read<TicketWalletCubit>();

                switch (value) {
                  case 'tickets':
                    cubit.getTickets();
                    break;
                  case 'empty':
                    cubit.clearTicketsForDemo();
                    break;
                  case 'error':
                    cubit.showErrorForDemo();
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'tickets', child: Text('Show tickets')),
                PopupMenuItem(value: 'empty', child: Text('Show empty state')),
                PopupMenuItem(value: 'error', child: Text('Show error state')),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: BlocBuilder<TicketWalletCubit, BaseState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ErrorState) {
              return Center(
                child: AppText(
                  text: 'Something went wrong: ${state.data}',
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state is LoadedState<List<Ticket>> && state.data != null) {
              final tickets = state.data!;
              final today = DateTime.now();
              final todayDate = DateTime(today.year, today.month, today.day);

              final upcomingTickets = tickets
                  .where((ticket) => !ticket.eventDate.isBefore(todayDate))
                  .toList();

              final pastTickets = tickets
                  .where((ticket) => ticket.eventDate.isBefore(todayDate))
                  .toList();

              return TabBarView(
                children: [
                  _TicketsList(
                    tickets: upcomingTickets,
                    emptyMessage: 'No upcoming tickets',
                  ),
                  _TicketsList(
                    tickets: pastTickets,
                    emptyMessage: 'No past tickets',
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _TicketsList extends StatelessWidget {
  const _TicketsList({required this.tickets, required this.emptyMessage});

  final List<Ticket> tickets;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return Center(child: AppText(text: emptyMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return TicketCard(ticket: tickets[index]);
      },
    );
  }
}

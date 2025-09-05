// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:service_mitra/config/colors/colors.dart';
// import 'package:service_mitra/config/images/app_images.dart';
// import 'package:service_mitra/views/screens/drawer/breakdown_ticket_status/close_tickets.dart';
// import 'package:service_mitra/views/screens/drawer/drawer.dart';
// import 'package:service_mitra/views/screens/drawer/breakdown_ticket_status/open_tickets.dart';
// import 'package:service_mitra/views/widegts/inter_text.dart';
//
// class BreakDownTicketStatus extends StatefulWidget {
//   const BreakDownTicketStatus({super.key});
//
//   @override
//   State<BreakDownTicketStatus> createState() => _BreakDownTicketStatusState();
//   // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
// }
//
// class _BreakDownTicketStatusState extends State<BreakDownTicketStatus>
//     with TickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(length: 2, vsync: this);
//     return Scaffold(
//       backgroundColor: AppColors.textformfieldcol,
//       key: scaffoldKey,
//       drawer: const DrawerScreen(),
//       appBar: AppBar(
//         backgroundColor: AppColors.textformfieldcol,
//         centerTitle: true,
//         toolbarHeight: 100,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.whitecol,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//           ),
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             scaffoldKey.currentState?.openDrawer();
//           },
//           child: SvgPicture.asset(
//             AppImages.drawericon,
//             fit: BoxFit.scaleDown,
//           ),
//         ),
//         title: const InterText(
//           text: "Breakdown ticket status",
//           fontsize: 22,
//           fontweight: FontWeight.w600,
//           color: AppColors.primarycol,
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.colorange, width: 1),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: TabBar(
//                 controller: tabController,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: AppColors.colorange,
//                 ),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicatorColor: Colors.transparent,
//                 dividerColor: Colors.transparent,
//                 unselectedLabelStyle:
//                     const TextStyle(color: AppColors.lightblackcol),
//                 unselectedLabelColor: AppColors.lightblackcol,
//                 labelColor: AppColors.whitecol,
//                 labelStyle: const TextStyle(
//                   color: AppColors.whitecol,
//                   fontSize: 18,
//                   fontFamily: 'inter',
//                   fontWeight: FontWeight.w500,
//                 ),
//                 tabs: const [
//                   Tab(
//                     text: "Open",
//                   ),
//                   Tab(
//                     text: "Close",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: tabController,
//         children: const [
//           OpenTickets(),
//           CloseTickets(),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_cubit.dart';
import 'package:service_mitra/bloc/cubit/tickets_cubit/tickets_state.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/repository/ticket/ticket_respository.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/views/screens/drawer/breakdown_ticket_status/close_tickets.dart';
import 'package:service_mitra/views/screens/drawer/drawer.dart';
import 'package:service_mitra/views/screens/drawer/breakdown_ticket_status/open_tickets.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

import '../../../../config/share_preferences/preferences.dart';

class BreakDownTicketStatus extends StatefulWidget {
  const BreakDownTicketStatus({super.key});

  @override
  State<BreakDownTicketStatus> createState() => _BreakDownTicketStatusState();
}

class _BreakDownTicketStatusState extends State<BreakDownTicketStatus>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    // UPDATED: The entire screen is now wrapped in a BlocProvider.
    // This will create one instance of the TicketsCubit for both tabs and call the new filtering function.
    return BlocProvider(
      create: (context) => TicketsCubit(TicketRespository())..fetchAndCategorizeAllTickets(context),
        child: BlocListener<TicketsCubit, TicketsState>(
          listener: (context, state) {
            if (state is TicketsCategorized && state.ticketIdForFeedback != null) {
              final localTicketId = Preference.getString("feedback_ticket_id");
              if (localTicketId != state.ticketIdForFeedback) {
                Preference.setString("feedback_ticket_id", state.ticketIdForFeedback!);
                showFeedbackDialog(context, state.ticketIdForFeedback!);
              }
            }
          },
          child: Scaffold(
        backgroundColor: AppColors.textformfieldcol,
        key: scaffoldKey,
        drawer: const DrawerScreen(),
        appBar: AppBar(
          backgroundColor: AppColors.textformfieldcol,
          centerTitle: true,
          toolbarHeight: 100,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: AppColors.whitecol,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: SvgPicture.asset(
              AppImages.drawericon,
              fit: BoxFit.scaleDown,
            ),
          ),
          title: const InterText(
            text: "Breakdown ticket status",
            fontsize: 22,
            fontweight: FontWeight.w600,
            color: AppColors.primarycol,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.colorange, width: 1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.colorange,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  unselectedLabelStyle:
                  const TextStyle(color: AppColors.lightblackcol),
                  unselectedLabelColor: AppColors.lightblackcol,
                  labelColor: AppColors.whitecol,
                  labelStyle: const TextStyle(
                    color: AppColors.whitecol,
                    fontSize: 18,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(
                      text: "Open",
                    ),
                    Tab(
                      text: "Close",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // UPDATED: The body is now a BlocBuilder.
        // It listens to state changes from the TicketsCubit and rebuilds the UI accordingly.
        body: BlocBuilder<TicketsCubit, TicketsState>(
          builder: (context, state) {
            // Show a loading circle while tickets are being fetched.
            if (state is TicketsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Once tickets are successfully filtered, show the TabBarView.
            if (state is TicketsCategorized) {
              return TabBarView(
                controller: tabController,
                children: [
                  // Pass the list of open tickets to the OpenTickets widget.
                  OpenTickets(tickets: state.openTickets),
                  // Pass the list of closed tickets to the CloseTickets widget.
                  CloseTickets(tickets: state.closedTickets),
                ],
              );
            }

            // If there's an error, display the error message.
            if (state is TicketsError) {
              return Center(child: Text(state.message));
            }

            // Default view while the initial state is loading or for any other case.
            return const Center(child: Text("Loading tickets..."));
          },
        ),
      ),
    ));
  }
}
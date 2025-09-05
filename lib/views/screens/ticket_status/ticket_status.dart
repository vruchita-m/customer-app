import 'package:flutter/material.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/views/screens/drawer/drawer.dart';
import 'package:service_mitra/views/screens/ticket_status/ticket_status_close.dart';
import 'package:service_mitra/views/screens/ticket_status/ticket_status_open.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

class TicketStatus extends StatefulWidget {
  final String vehicleId;
  const TicketStatus({super.key, required this.vehicleId});

  @override
  State<TicketStatus> createState() => _TicketStatusState();
}

class _TicketStatusState extends State<TicketStatus>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerScreen(),
      backgroundColor: AppColors.textformfieldcol,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.lightblackcol),
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
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const InterText(
          text: "Ticket status",
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
      body: TabBarView(
        controller: tabController,
        children: [
          TicketStatusOpen(vehicleId: widget.vehicleId),
          TicketStatusClose(vehicleId: widget.vehicleId),
        ],
      ),
    );
  }
}

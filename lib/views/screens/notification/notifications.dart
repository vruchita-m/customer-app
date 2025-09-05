import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:service_mitra/bloc/notification_bloc/notification_cubit.dart';
import 'package:service_mitra/bloc/notification_bloc/notification_state.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/model/notification_modal.dart';
import 'package:service_mitra/config/data/model/ticket/ticket_model.dart';
import 'package:service_mitra/config/data/repository/notification_repositry/notification_repositry.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().loadNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textformfieldcol,
      appBar: const CustomAppBar(
        title: "Notifications",
        // automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            debugPrint("Length : ${state.notifications.length}");
            if (state.notifications.isEmpty) {
              return const Center(child: Text("No Notifications"));
            }
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                NotificationResults notification =
                state.notifications.reversed.toList()[index];
                return GestureDetector(
                  onTap: () {
                    String ticketId = notification.ticketId ?? "";
                    NotificationRepositry()
                        .getTicketDetail(ticketId, context)
                        .then((value) {
                      debugPrint("Value : $value");
                      TicketsResults result = value;
                      debugPrint("Value : ${result.id}");
                      debugPrint("Value : ${result.status}");
                      Navigator.pushNamed(
                        context,
                        RoutesName.estimate,
                        arguments: {"ticketsResults": result},
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whitecol,
                        borderRadius: BorderRadius.circular(22)),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(1.5),
                                  decoration: const BoxDecoration(
                                      color: AppColors.whitecol,
                                      shape: BoxShape.circle),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 54,
                                    width: 54,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.whitecol, width: 2),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                            AppImages.notificationLogo,
                                          ),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   // bottom: 10,
                                //   child: Container(
                                //     width: 18,
                                //     height: 18,
                                //     decoration: const BoxDecoration(
                                //         shape: BoxShape.circle,
                                //         gradient: LinearGradient(colors: [
                                //           AppColors.gradient1,
                                //           AppColors.gradient2
                                //         ])),
                                //     child: const Center(
                                //       child: InterText(
                                //         color: AppColors.whitecol,
                                //         text: "1",
                                //         fontsize: 10,
                                //         fontweight: FontWeight.w500,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: InterText(
                                          text: notification.notificationtitle,
                                          fontsize: 16,
                                          fontweight: FontWeight.w500,
                                        ),
                                      ),
                                      InterText(
                                        text:
                                        formatDate(notification.createdAt),
                                        fontsize: 12,
                                        fontweight: FontWeight.w400,
                                        color: AppColors.lightblackcol,
                                      )
                                    ],
                                  ),
                                  InterText(
                                    text: notification.notificationbody,
                                    fontsize: 11,
                                    fontweight: FontWeight.w400,
                                    color: AppColors.lightblackcol,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is NotificationError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("No Notifications"));
        },
      ),
    );
  }

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';

    try {
      DateTime dateTime = DateTime.parse(dateString);
      String formattedDate = DateFormat("dd MMM yyyy")
          .format(dateTime.toUtc().add(const Duration(hours: 5, minutes: 30)));
      return formattedDate;
    } catch (e) {
      return 'N/A';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_boxes/app_constants.dart';
import 'package:food_boxes/utility/shared_functions.dart';

import '../app_icons.dart';
import '../utility/size_config.dart';
import '../utility/ticket_list_notifier.dart';

class TicketsPage extends ConsumerWidget {
  const TicketsPage({super.key});

  Widget innerRow(IconData iconData, String text) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.black,
          size: SizeConfig.scaledHeight(2.5),
        ),
        SizedBox(
          width: SizeConfig.scaledWidth(3),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: SizeConfig.scaledHeight(2.5),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketList = ref.watch(ticketListProvider);
    final uniqueTickets = Set.from(ticketList);
    if (ticketList.isEmpty) {
      return Center(
        child: Container(
          height: SizeConfig.scaledHeight(14),
          width: SizeConfig.scaledWidth(75),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.scaledWidth(10),
          ),
          margin: EdgeInsets.only(
            top: SizeConfig.scaledHeight(5),
          ),
          decoration: BoxDecoration(
            borderRadius: AppConstants.circleRadius,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            "No active tickets. Please visit the schedule page to place an order.",
            style: TextStyle(
              fontSize: SizeConfig.scaledHeight(2.5),
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(
        top: SizeConfig.scaledHeight(10),
      ),
      itemCount: uniqueTickets.length,
      itemBuilder: (_, index) {
        final ticketQuantity = ref
            .read(ticketListProvider.notifier)
            .getNumberOfTickets(uniqueTickets.elementAt(index).id);
        return GestureDetector(
          onTap: () => orderDetailsDialogue(
            ref,
            orderNumber: "${index + 1}",
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: AppConstants.circleRadius,
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(
              vertical: SizeConfig.scaledHeight(1.5),
              horizontal: SizeConfig.scaledWidth(3),
            ),
            child: Column(children: [
              Stack(
                children: [
                  Container(
                    height: SizeConfig.scaledHeight(30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                            uniqueTickets.elementAt(index).imageURL!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: SizeConfig.scaledHeight(2),
                    right: SizeConfig.scaledWidth(1),
                    child: Container(
                      width: SizeConfig.scaledWidth(70),
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.scaledHeight(1),
                        horizontal: SizeConfig.scaledWidth(1.5),
                      ),
                      color: Colors.black54,
                      child: Text(
                        "${uniqueTickets.elementAt(index).name} x$ticketQuantity",
                        style: TextStyle(
                          fontSize: SizeConfig.scaledHeight(3.5),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.scaledHeight(3),
                  horizontal: SizeConfig.scaledWidth(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    innerRow(
                      AppIcons.calendar,
                      formatDate(ticketList[index].date),
                    ),
                    innerRow(
                      Icons.attach_money,
                      "${ticketList[index].price * ticketQuantity}",
                    ),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}

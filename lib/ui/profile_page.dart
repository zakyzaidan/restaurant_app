import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/controllers/scheduling_controller.dart';
import 'package:restaurant_app/helper/preference_helper.dart';

class ProfilePage extends StatelessWidget {
  final SchedulingController schedulingController = Get.put(
      SchedulingController(preferenceHelper: PreferenceHelper()));
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                color: secondaryColor,
              ),
              const SizedBox(height: 100,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Settings", 
                    style: Theme.of(context).textTheme.displayMedium,)
                  ],
                ),
              ),
               _buildList(context),
            ],
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width/2) - 70,
            top: 300-70,
            child: const CircleAvatar(
              foregroundColor: secondaryColor,
              radius: 70,
              child: Icon(Icons.person, size: 50,),
            ),
          ),
          
        ],
      );
  }

  Widget _buildList(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('Scheduling Restaurant'),
        GetBuilder(
          init: schedulingController,
          builder: (_){
            return Switch.adaptive(
              value: schedulingController.isScheduled,
              onChanged: (value) {
                  schedulingController.scheduledRestaurant(value);
                  schedulingController.enableNotification(value);
              }
            );
          }
        ),
      ],
    );
    
    
  //   ListView(
  //     children: [
  //       Material(
  //         child: ListTile(
  //           title: const Text('Scheduling News'),
  //           trailing: GetBuilder(
  //             builder: (_){
  //               return Switch.adaptive(
  //                 value: schedulingController.isScheduled,
  //                 onChanged: (value) async {
  //                   if (Platform.isIOS) {
  //                     customDialog(context);
  //                   } else {
  //                     schedulingController.scheduledNews(value);
  //                   }
  //                 }
  //               );
  //             }
  //         ),
  //       ),
  //       ),
  //     ]);
  }
}
            // Consumer<SchedulingProvider>(
            //    builder: (context, scheduled, _) {
            //     return Switch.adaptive(
            //       value: scheduled.isScheduled,
            //       onChanged: (value) async {
            //         if (Platform.isIOS) {
            //           customDialog(context);
            //         } else {
            //           scheduled.scheduledNews(value);
            //         }
            //       },
            //     );
            //   },
            // ),
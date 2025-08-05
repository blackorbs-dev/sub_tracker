import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/features/subscription/data/mapper/location_mapper.dart';
import '../../../shared/presentation/widgets/center_text.dart';
import '../cubit/sub_history_cubit.dart';
import '../widgets/sub_info_card.dart';

class SubHistoryScreen extends StatelessWidget{
  const SubHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubHistoryCubit(context.read()),
      child: const SubHistoryView(),
    );
  }
}

class SubHistoryView extends StatelessWidget{
  const SubHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Locations'),
        backgroundColor: context.theme.colors.background,
        foregroundColor: context.theme.colors.foreground,
      ),
      body: BlocBuilder<SubHistoryCubit, SubHistoryState>(
        builder: (context, state) =>
            switch(state){
              Initial() => const Center(child: CircularProgressIndicator()),
              Loaded() => state.subscriptions.isEmpty
                ? const SizedBox.expand(child: CenterText('No Subscriptions Found'))
                : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 260, alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      context.theme.colors.foreground,
                                      context.theme.colors.mutedForeground
                                    ]
                                )
                            ),
                            child: state.locationColorMap.isEmpty
                                ? Text(
                                'No location data', style: context.theme.textTheme.bodySmall
                                .withColor(context.theme.colors.sidebarBorder)
                            )
                                : GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      state.locationColorMap.keys.first.latitude,
                                      state.locationColorMap.keys.first.longitude
                                  )
                              ),
                              markers: state.markers,
                              onMapCreated: (controller){
                                final bounds = state.locationColorMap.keys.getLatLngBounds();
                                if (bounds == null) return;
                                controller.animateCamera(
                                    CameraUpdate.newLatLngBounds(bounds, 60)
                                );
                              },
                            ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28, bottom: 4),
                        child: Text(
                          'Subscription History',
                          style: context.theme.textTheme.titleLarge
                              .withColor(context.theme.colors.foreground),
                        ),
                      ),
                      Expanded(child: ListView.builder(
                        itemCount: state.subscriptions.length,
                        itemBuilder: (context, index){
                          final loc = state.subscriptions[index].location;
                          return SubInfoCard(
                              sub: state.subscriptions[index],
                              color: state.locationColorMap[loc]
                                  ?? context.theme.colors.sidebarForeground
                          );
                        },
                      ))
                    ],
                  )
              ),
            }
      )
    );
  }
  
}
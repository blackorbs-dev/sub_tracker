import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/core/util/extensions.dart';
import 'package:sub_tracker/core/util/formatter.dart';
import 'package:sub_tracker/features/dashboard/domain/subscription_overview.dart';
import 'package:sub_tracker/features/dashboard/presentation/widgets/outlined_button.dart';
import 'package:sub_tracker/features/dashboard/presentation/widgets/overview_item.dart';
import 'package:sub_tracker/features/dashboard/presentation/widgets/current_sub_card.dart';
import 'package:sub_tracker/features/dashboard/presentation/widgets/theme_toggle_switch.dart';
import 'package:sub_tracker/router/routes.dart';
import '../../../shared/presentation/widgets/center_text.dart';
import '../../../shared/presentation/widgets/svg_icon.dart';
import '../cubit/dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocProvider(
        create: (context) => DashboardCubit(
          context.read(), context.read(), context.read()
        ),
        child: const DashboardView(),
      );
}

class DashboardView extends StatelessWidget{
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.colors.background,
        title: BlocSelector<DashboardCubit, DashboardState, String?>(
            selector: (state) => state is Loaded ? state.userName : null,
            builder: (context, username) => Text(
              'Welcome back, $username',
              style: context.theme.textTheme.bodyMedium
                  .withColor(context.theme.colors.foreground),
            )
        ),
        actions: const [ThemeToggleSwitch()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
        child: Column(
          children: [
            const CurrentSubCard(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: context.theme.colors.foreground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SvgIcon(
                      'assets/icons/wallet.svg',
                      size: 28,
                      color: context.theme.colors.background,
                    )
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Wallet Balance',
                          style: context.theme.textTheme.bodyMedium
                              .withColor(context.theme.colors.foreground),
                        ),
                        BlocSelector<DashboardCubit, DashboardState, double?>(
                            selector: (state) => state is Loaded ? state.walletBalance : null,
                            builder: (context, balance) => Text(
                              '${balance?.formatPrice()}',
                              style: context.theme.textTheme.headlineSmall
                                  .withColor(context.theme.colors.foreground),
                            )
                        ),
                      ],
                    )
                  ),),
                  OutlinedButtonSmall(
                      text: 'Manage',
                      onPressed: (){ context.safePush(Screen.wallet); }
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButtonLarge(
                      text: 'Manage Plan',
                      iconAsset: 'assets/icons/credit-card.svg',
                      onPressed: (){ context.safePush(Screen.subscribe); }
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButtonLarge(
                      text: 'View Locations',
                      iconAsset: 'assets/icons/map-pin.svg',
                      onPressed: (){ context.safePush(Screen.subHistory); }
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28, bottom: 6),
              child: Row(
                children: [
                  SvgIcon('assets/icons/trending-up.svg', color: context.theme.colors.foreground,),
                  const SizedBox(width: 6),
                  Text(
                    'Usage Overview', style: context.theme.textTheme.titleMedium
                      .withColor(context.theme.colors.foreground),
                  )
                ],
              ),
            ),
            BlocSelector<DashboardCubit, DashboardState, SubscriptionOverview?>(
                selector: (state) => state is Loaded ? state.subscriptionOverview : null,
                builder: (context, subOverview) => subOverview == null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 36),
                      child: CenterText('No usage statistics at the moment',),
                    )
                    : Column(
                        children: [
                          OverviewItem(
                              title: 'Subscription History',
                              text: '${subOverview.totalLocations} Locations'
                          ),
                          OverviewItem(
                              title: 'Auto-renewals',
                              text: '${subOverview.totalRenewals} successful',
                              textColor: context.theme.colors.success,
                          ),
                          OverviewItem(
                              title: 'Next billing',
                              text: '${subOverview.daysLeft} days'
                          ),
                        ],
                    )
            )
          ],
        ),
      ),
    );
  }

}
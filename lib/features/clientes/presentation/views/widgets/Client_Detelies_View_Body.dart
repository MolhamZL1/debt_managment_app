import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../domain/entities/client_entity.dart';
import '../DebtsClientView.dart';
import '../PaidClientsView.dart';
import '../TransactionClientsView.dart';
import 'ClientDetailsHeaderCard.dart';

class ClientDeteliesViewBody extends StatelessWidget {
  const ClientDeteliesViewBody({super.key, required this.clientEntity});
  final ClientEntity clientEntity;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: ClientDetailsHeaderCard(clientEntity: clientEntity),
              ),
              // SliverToBoxAdapter(
              //   child: ActionButtonsClientDetails(
              //     onAddDebt: () {
              //       adddebtBottomSheet(context);
              //     },
              //     onAddPayment: () {
              //       addpaymentBottomSheet(context);
              //     },
              //   ),
              // ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    tabs: [
                      Tab(text: l10n.debts),
                      Tab(text: l10n.payments),
                      Tab(text: l10n.accountStatement),
                    ],
                  ),
                ),
              ),
            ],
        body: TabBarView(
          children: [
            DebtsClientView(clientId: clientEntity.id),
            PaidClientsView(clientId: clientEntity.id),
            TransactionClientsView(clientId: clientEntity.id),
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Divider(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
          ),
          _tabBar,
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

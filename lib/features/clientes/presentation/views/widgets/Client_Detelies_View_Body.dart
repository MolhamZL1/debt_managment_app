import 'package:debt_managment_app/features/main/presntation/views/widgets/adddebtBottomSheet.dart';
import 'package:debt_managment_app/features/main/presntation/views/widgets/addpaymentBottomSheet.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/client_entity.dart';
import '../DebtsClientView.dart';
import '../PaidClientsView.dart';
import '../TransactionClientsView.dart';
import 'ActionButtonsClientDetails.dart';
import 'ClientDetailsHeaderCard.dart';

class ClientDeteliesViewBody extends StatelessWidget {
  const ClientDeteliesViewBody({super.key, required this.clientEntity});
  final ClientEntity clientEntity;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: ClientDetailsHeaderCard(clientEntity: clientEntity),
              ),
              SliverToBoxAdapter(
                child: ActionButtonsClientDetails(
                  onAddDebt: () {
                    adddebtBottomSheet(context);
                  },
                  onAddPayment: () {
                    addpaymentBottomSheet(context);
                  },
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverTabBarDelegate(
                  const TabBar(
                    tabs: [
                      Tab(text: 'الديون'),
                      Tab(text: 'الدفعات'),
                      Tab(text: 'كشف الحساب'),
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

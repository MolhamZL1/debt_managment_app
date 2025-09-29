import 'package:flutter/material.dart';

import '../../../domain/entities/client_entity.dart';
import 'Action_Buttons_Row.dart';
import 'Debt_Item_Card.dart';
import 'contact_header_card.dart';

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
                child: ActionButtonsRow(onAddDebt: () {}, onAddPayment: () {}),
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
        body: const TabBarView(
          children: [
            _DebtsClientView(),
            _PaidClientsView(),
            _TransactionClientsView(),
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
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

class _DebtsClientView extends StatefulWidget {
  const _DebtsClientView();

  @override
  State<_DebtsClientView> createState() => _DebtsClientViewState();
}

class _DebtsClientViewState extends State<_DebtsClientView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return DebtItemCard(
          debt: Debt(
            amount: 5000,
            dueHijri: "1445/07/05 هـ",
            invoiceNo: "1234",
          ),
          onDelete: () {},
          onEdit: () {},
        );
      },
    );
  }
}

class _PaidClientsView extends StatefulWidget {
  const _PaidClientsView();

  @override
  State<_PaidClientsView> createState() => _PaidClientsViewState();
}

class _PaidClientsViewState extends State<_PaidClientsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Center(child: Text('لا توجد دفعات بعد'));
  }
}

class _TransactionClientsView extends StatefulWidget {
  const _TransactionClientsView();

  @override
  State<_TransactionClientsView> createState() =>
      _TransactionClientsViewState();
}

class _TransactionClientsViewState extends State<_TransactionClientsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const Center(child: Text('لا يوجد كشف حساب بعد'));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/CustomLoading.dart';
import '../../../../main/domain/entities/ClientSearchDropDownEntity.dart';
import '../../cubits/search/search_cubit.dart';

class ClientSearchDelegate extends SearchDelegate {
  ClientSearchDelegate({required this.cubit});
  final SearchCubit cubit;

  Timer? _debounce;
  String _lastQueried = '';

  @override
  String get searchFieldLabel => 'ابحث بالاسم …';
  @override
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.grey[200],

    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
  );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            _cancelDebounce();

            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        _cancelDebounce();
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _triggerSearchLive();
    return _ResultsList(cubit: cubit, onPick: (c) => close(context, c));
  }

  @override
  Widget buildResults(BuildContext context) {
    _triggerSearchLive(force: true);
    return _ResultsList(cubit: cubit, onPick: (c) => close(context, c));
  }

  void _triggerSearchLive({bool force = false}) {
    final q = query.trim();
    if (!force && q == _lastQueried) return;

    _cancelDebounce();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      _lastQueried = q;
      if (q.isEmpty) {
      } else {
        cubit.fetchSearchDropDownData(q);
      }
    });
  }

  void _cancelDebounce() {
    _debounce?.cancel();
    _debounce = null;
  }
}

class _ResultsList extends StatelessWidget {
  final SearchCubit cubit;
  final ValueChanged<ClientSearchDropDownEntity> onPick;
  const _ResultsList({required this.cubit, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is SearchLoading) {
          return CustomLoading();
        } else if (state is SearchFailure) {
          return Center(child: Text(state.message));
        } else if (state is SearchSuccess) {
          final results = state.results;
          if (results.isEmpty) {
            return const Center(child: Text('لا يوجد عملاء بهذا الاسم'));
          }
          return ListView.separated(
            itemCount: results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final c = results[i];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(c.name),
                onTap: () => onPick(c),
              );
            },
          );
        }
        return const Center(child: Text('اكتب للبدء بالبحث…'));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../domain/entities/ClientSearchDropDownEntity.dart';
import '../../../domain/repo/ClientSearchDropDown_repo.dart';
import '../../../../../core/services/get_it_service.dart';

class ClientSearchField extends StatefulWidget {
  const ClientSearchField({super.key});

  @override
  State<ClientSearchField> createState() => _ClientSearchFieldState();
}

class _ClientSearchFieldState extends State<ClientSearchField> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<ClientSearchDropDownEntity>(
      name: 'client',
      validator: (v) => v == null ? 'يرجى اختيار عميل من القائمة' : null,
      builder: (field) {
        final v = field.value;
        if (v != null && _ctrl.text != v.name) {
          _ctrl.text = v.name;
          _ctrl.selection = TextSelection.collapsed(offset: _ctrl.text.length);
        }

        return TypeAheadField<ClientSearchDropDownEntity>(
          controller: _ctrl,
          suggestionsCallback: (pattern) async {
            final q = pattern.trim();
            if (q.length < 2) return const <ClientSearchDropDownEntity>[];
            return await getIt<ClientSearchDropDownRepo>().searchClients(q);
          },
          builder: (context, controller, focusNode) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'ابحث عن اسم العميل',
                prefixIcon: const Icon(Icons.person_outline),
                errorText: field.errorText,
                suffixIcon:
                    controller.text.isNotEmpty
                        ? IconButton(
                          onPressed: () {
                            controller.clear();
                            if (field.value != null) field.didChange(null);
                          },
                          icon: const Icon(Icons.clear),
                          tooltip: 'مسح',
                        )
                        : null,
              ),
              onChanged: (txt) {
                if (field.value != null && txt != field.value!.name) {
                  field.didChange(null);
                }
              },
            );
          },

          itemBuilder:
              (context, s) => ListTile(
                leading: const Icon(Icons.person),
                title: Text(s.name),
              ),

          emptyBuilder:
              (_) => const Padding(
                padding: EdgeInsets.all(12),
                child: Text('لا يوجد عميل بهذا الاسم'),
              ),
          loadingBuilder:
              (_) => SizedBox(
                height: 80,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: LoadingIndicator(indicatorType: Indicator.lineScale),
                  ),
                ),
              ),
          errorBuilder:
              (_, __) => const Padding(
                padding: EdgeInsets.all(12),
                child: Text('حدث خطأ أثناء البحث'),
              ),

          onSelected: (s) {
            _ctrl.text = s.name;
            field.didChange(s);
            FocusScope.of(context).unfocus();
          },
        );
      },
    );
  }
}

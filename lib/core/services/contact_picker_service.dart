import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

enum ContactPickerFailure {
  permissionDenied,
  permissionPermanentlyDenied,
  canceled,
  noPhoneNumber,
  unsupported,
  unknown,
}

class PickedContactData {
  const PickedContactData({required this.name, required this.phone});

  final String name;
  final String phone;
}

class ContactPickerResult {
  const ContactPickerResult._({this.contact, this.failure});

  const ContactPickerResult.success(PickedContactData contact)
    : this._(contact: contact);

  const ContactPickerResult.failure(ContactPickerFailure failure)
    : this._(failure: failure);

  final PickedContactData? contact;
  final ContactPickerFailure? failure;

  bool get isSuccess => contact != null;
}

class ContactPickerService {
  const ContactPickerService();

  Future<ContactPickerResult> pickContact() async {
    try {
      final permissionStatus = await FlutterContacts.permissions.request(
        PermissionType.read,
      );

      if (!_isPermissionGranted(permissionStatus)) {
        return ContactPickerResult.failure(
          _permissionFailure(permissionStatus),
        );
      }

      final contact = await FlutterContacts.native.showPicker(
        properties: {ContactProperty.phone},
      );

      if (contact == null) {
        return const ContactPickerResult.failure(ContactPickerFailure.canceled);
      }

      final phone = _phoneFrom(contact);
      if (phone == null) {
        return const ContactPickerResult.failure(
          ContactPickerFailure.noPhoneNumber,
        );
      }

      return ContactPickerResult.success(
        PickedContactData(name: _nameFrom(contact), phone: phone),
      );
    } on PlatformException catch (error) {
      return ContactPickerResult.failure(_platformFailure(error));
    } catch (_) {
      return const ContactPickerResult.failure(ContactPickerFailure.unknown);
    }
  }

  bool _isPermissionGranted(PermissionStatus status) {
    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }

  ContactPickerFailure _permissionFailure(PermissionStatus status) {
    return switch (status) {
      PermissionStatus.permanentlyDenied || PermissionStatus.restricted =>
        ContactPickerFailure.permissionPermanentlyDenied,
      _ => ContactPickerFailure.permissionDenied,
    };
  }

  ContactPickerFailure _platformFailure(PlatformException error) {
    return switch (error.code) {
      'not_available' => ContactPickerFailure.unsupported,
      'permission_denied' ||
      'PERMISSION_DENIED' => ContactPickerFailure.permissionDenied,
      _ => ContactPickerFailure.unknown,
    };
  }

  String? _phoneFrom(Contact contact) {
    final phone = contact.phones.firstOrNull?.number;
    final normalized = phone?.replaceAll(RegExp(r'\D'), '');
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  String _nameFrom(Contact contact) {
    final name = contact.displayName?.trim();
    return name == null || name.isEmpty ? 'عميل جديد' : name;
  }
}

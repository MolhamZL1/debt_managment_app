// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get Sign_in {
    return Intl.message('Sign In', name: 'Sign_in', desc: '', args: []);
  }

  /// `Sajilha`
  String get appName {
    return Intl.message('Sajilha', name: 'appName', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Clients`
  String get clients {
    return Intl.message('Clients', name: 'clients', desc: '', args: []);
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `App`
  String get settingsAppSection {
    return Intl.message('App', name: 'settingsAppSection', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Arabic`
  String get languageArabic {
    return Intl.message('Arabic', name: 'languageArabic', desc: '', args: []);
  }

  /// `English`
  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  /// `System`
  String get languageSystem {
    return Intl.message('System', name: 'languageSystem', desc: '', args: []);
  }

  /// `Choose the app language`
  String get languageSubtitle {
    return Intl.message(
      'Choose the app language',
      name: 'languageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get languageDialogTitle {
    return Intl.message(
      'Change language',
      name: 'languageDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `Dark mode enabled`
  String get darkModeEnabled {
    return Intl.message(
      'Dark mode enabled',
      name: 'darkModeEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Light mode enabled`
  String get lightModeEnabled {
    return Intl.message(
      'Light mode enabled',
      name: 'lightModeEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Help and information`
  String get settingsHelpSection {
    return Intl.message(
      'Help and information',
      name: 'settingsHelpSection',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Usage steps and support contact`
  String get helpSubtitle {
    return Intl.message(
      'Usage steps and support contact',
      name: 'helpSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message('About us', name: 'aboutUs', desc: '', args: []);
  }

  /// `The app idea, mission, and contact details`
  String get aboutUsSubtitle {
    return Intl.message(
      'The app idea, mission, and contact details',
      name: 'aboutUsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `How the app keeps your data local`
  String get privacyPolicySubtitle {
    return Intl.message(
      'How the app keeps your data local',
      name: 'privacyPolicySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Usage rules and responsibility`
  String get termsAndConditionsSubtitle {
    return Intl.message(
      'Usage rules and responsibility',
      name: 'termsAndConditionsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sajilha version 1.0.0`
  String get versionLabel {
    return Intl.message(
      'Sajilha version 1.0.0',
      name: 'versionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add new client`
  String get addNewClient {
    return Intl.message(
      'Add new client',
      name: 'addNewClient',
      desc: '',
      args: [],
    );
  }

  /// `Register a client to track debts`
  String get addClientSubtitle {
    return Intl.message(
      'Register a client to track debts',
      name: 'addClientSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add new debt`
  String get addNewDebt {
    return Intl.message('Add new debt', name: 'addNewDebt', desc: '', args: []);
  }

  /// `Register a new debt for a client`
  String get addDebtSubtitle {
    return Intl.message(
      'Register a new debt for a client',
      name: 'addDebtSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add new payment`
  String get addNewPayment {
    return Intl.message(
      'Add new payment',
      name: 'addNewPayment',
      desc: '',
      args: [],
    );
  }

  /// `Register a new payment for a client`
  String get addPaymentSubtitle {
    return Intl.message(
      'Register a new payment for a client',
      name: 'addPaymentSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get client {
    return Intl.message('Client', name: 'client', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Note`
  String get note {
    return Intl.message('Note', name: 'note', desc: '', args: []);
  }

  /// `Note (optional)`
  String get optionalNote {
    return Intl.message(
      'Note (optional)',
      name: 'optionalNote',
      desc: '',
      args: [],
    );
  }

  /// `Client name`
  String get clientName {
    return Intl.message('Client name', name: 'clientName', desc: '', args: []);
  }

  /// `Mobile number`
  String get phoneNumber {
    return Intl.message(
      'Mobile number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `(optional)`
  String get optional {
    return Intl.message('(optional)', name: 'optional', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Pay`
  String get pay {
    return Intl.message('Pay', name: 'pay', desc: '', args: []);
  }

  /// `Debt saved successfully`
  String get debtSavedSuccessfully {
    return Intl.message(
      'Debt saved successfully',
      name: 'debtSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Payment added successfully`
  String get paymentAddedSuccessfully {
    return Intl.message(
      'Payment added successfully',
      name: 'paymentAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Client added successfully`
  String get clientAddedSuccessfully {
    return Intl.message(
      'Client added successfully',
      name: 'clientAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add debt`
  String get addDebtFailed {
    return Intl.message(
      'Failed to add debt',
      name: 'addDebtFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add payment`
  String get addPaymentFailed {
    return Intl.message(
      'Failed to add payment',
      name: 'addPaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add client`
  String get addClientFailed {
    return Intl.message(
      'Failed to add client',
      name: 'addClientFailed',
      desc: '',
      args: [],
    );
  }

  /// `Total debts`
  String get totalDebts {
    return Intl.message('Total debts', name: 'totalDebts', desc: '', args: []);
  }

  /// `SYP`
  String get currencySyp {
    return Intl.message('SYP', name: 'currencySyp', desc: '', args: []);
  }

  /// `Recent debts`
  String get recentDebts {
    return Intl.message(
      'Recent debts',
      name: 'recentDebts',
      desc: '',
      args: [],
    );
  }

  /// `Recent payments`
  String get recentPayments {
    return Intl.message(
      'Recent payments',
      name: 'recentPayments',
      desc: '',
      args: [],
    );
  }

  /// `Indebted`
  String get indebtedClients {
    return Intl.message(
      'Indebted',
      name: 'indebtedClients',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get nonIndebtedClients {
    return Intl.message(
      'Clear',
      name: 'nonIndebtedClients',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Welcome to Sajilha`
  String get emptyHomeTitle {
    return Intl.message(
      'Welcome to Sajilha',
      name: 'emptyHomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start by adding your first client or debt using the (+) button below.`
  String get emptyHomeSubtitle {
    return Intl.message(
      'Start by adding your first client or debt using the (+) button below.',
      name: 'emptyHomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Search by name or phone number...`
  String get searchClientsHint {
    return Intl.message(
      'Search by name or phone number...',
      name: 'searchClientsHint',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Debt`
  String get debt {
    return Intl.message('Debt', name: 'debt', desc: '', args: []);
  }

  /// `Debts`
  String get debts {
    return Intl.message('Debts', name: 'debts', desc: '', args: []);
  }

  /// `Payments`
  String get payments {
    return Intl.message('Payments', name: 'payments', desc: '', args: []);
  }

  /// `Late`
  String get late {
    return Intl.message('Late', name: 'late', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `No clients`
  String get noClients {
    return Intl.message('No clients', name: 'noClients', desc: '', args: []);
  }

  /// `No transactions`
  String get noTransactions {
    return Intl.message(
      'No transactions',
      name: 'noTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Please choose a client from the list`
  String get chooseClientValidation {
    return Intl.message(
      'Please choose a client from the list',
      name: 'chooseClientValidation',
      desc: '',
      args: [],
    );
  }

  /// `Search client name`
  String get searchClientNameHint {
    return Intl.message(
      'Search client name',
      name: 'searchClientNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clearField {
    return Intl.message('Clear', name: 'clearField', desc: '', args: []);
  }

  /// `No client found with this name`
  String get noClientWithName {
    return Intl.message(
      'No client found with this name',
      name: 'noClientWithName',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while searching`
  String get clientSearchError {
    return Intl.message(
      'An error occurred while searching',
      name: 'clientSearchError',
      desc: '',
      args: [],
    );
  }

  /// `client`
  String get clientUnit {
    return Intl.message('client', name: 'clientUnit', desc: '', args: []);
  }

  /// `No registered debts`
  String get noRegisteredDebts {
    return Intl.message(
      'No registered debts',
      name: 'noRegisteredDebts',
      desc: '',
      args: [],
    );
  }

  /// `No registered payments`
  String get noRegisteredPayments {
    return Intl.message(
      'No registered payments',
      name: 'noRegisteredPayments',
      desc: '',
      args: [],
    );
  }

  /// `No debts or payments registered`
  String get noClientTransactions {
    return Intl.message(
      'No debts or payments registered',
      name: 'noClientTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Statement`
  String get accountStatement {
    return Intl.message(
      'Statement',
      name: 'accountStatement',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message('Balance', name: 'balance', desc: '', args: []);
  }

  /// `Indebted`
  String get indebted {
    return Intl.message('Indebted', name: 'indebted', desc: '', args: []);
  }

  /// `Not indebted`
  String get notIndebted {
    return Intl.message(
      'Not indebted',
      name: 'notIndebted',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Last activity`
  String get lastActivity {
    return Intl.message(
      'Last activity',
      name: 'lastActivity',
      desc: '',
      args: [],
    );
  }

  /// `No activity yet`
  String get noActivityYet {
    return Intl.message(
      'No activity yet',
      name: 'noActivityYet',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message('Call', name: 'call', desc: '', args: []);
  }

  /// `WhatsApp`
  String get whatsapp {
    return Intl.message('WhatsApp', name: 'whatsapp', desc: '', args: []);
  }

  /// `Confirm delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this client?`
  String get deleteClientQuestion {
    return Intl.message(
      'Are you sure you want to delete this client?',
      name: 'deleteClientQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `An error occurred`
  String get genericError {
    return Intl.message(
      'An error occurred',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Client deleted successfully`
  String get clientDeletedSuccessfully {
    return Intl.message(
      'Client deleted successfully',
      name: 'clientDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Search by name …`
  String get searchByName {
    return Intl.message(
      'Search by name …',
      name: 'searchByName',
      desc: '',
      args: [],
    );
  }

  /// `Type to start searching…`
  String get startSearchTyping {
    return Intl.message(
      'Type to start searching…',
      name: 'startSearchTyping',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again`
  String get searchGenericError {
    return Intl.message(
      'Something went wrong, please try again',
      name: 'searchGenericError',
      desc: '',
      args: [],
    );
  }

  /// `How to use the app?`
  String get helpHowToUse {
    return Intl.message(
      'How to use the app?',
      name: 'helpHowToUse',
      desc: '',
      args: [],
    );
  }

  /// `Add a client`
  String get helpStepAddClientTitle {
    return Intl.message(
      'Add a client',
      name: 'helpStepAddClientTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap the add button at the bottom and choose Add new client.`
  String get helpStepAddClientDescription {
    return Intl.message(
      'Tap the add button at the bottom and choose Add new client.',
      name: 'helpStepAddClientDescription',
      desc: '',
      args: [],
    );
  }

  /// `Register a debt or payment`
  String get helpStepAddDebtPaymentTitle {
    return Intl.message(
      'Register a debt or payment',
      name: 'helpStepAddDebtPaymentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose the client, then enter the amount and note if needed.`
  String get helpStepAddDebtPaymentDescription {
    return Intl.message(
      'Choose the client, then enter the amount and note if needed.',
      name: 'helpStepAddDebtPaymentDescription',
      desc: '',
      args: [],
    );
  }

  /// `Review the statement`
  String get helpStepReviewStatementTitle {
    return Intl.message(
      'Review the statement',
      name: 'helpStepReviewStatementTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open client details to track debts and payments.`
  String get helpStepReviewStatementDescription {
    return Intl.message(
      'Open client details to track debts and payments.',
      name: 'helpStepReviewStatementDescription',
      desc: '',
      args: [],
    );
  }

  /// `Technical support`
  String get technicalSupport {
    return Intl.message(
      'Technical support',
      name: 'technicalSupport',
      desc: '',
      args: [],
    );
  }

  /// `For any question or suggestion, contact us on WhatsApp.`
  String get technicalSupportDescription {
    return Intl.message(
      'For any question or suggestion, contact us on WhatsApp.',
      name: 'technicalSupportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Contact us on WhatsApp`
  String get contactUsWhatsapp {
    return Intl.message(
      'Contact us on WhatsApp',
      name: 'contactUsWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Help center`
  String get helpCenter {
    return Intl.message('Help center', name: 'helpCenter', desc: '', args: []);
  }

  /// `Quick guidance for using Sajilha efficiently.`
  String get helpHeroSubtitle {
    return Intl.message(
      'Quick guidance for using Sajilha efficiently.',
      name: 'helpHeroSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sajilha currently works locally, so client, debt, and payment data stays on your device.`
  String get privacyIntro {
    return Intl.message(
      'Sajilha currently works locally, so client, debt, and payment data stays on your device.',
      name: 'privacyIntro',
      desc: '',
      args: [],
    );
  }

  /// `Local storage`
  String get localStorage {
    return Intl.message(
      'Local storage',
      name: 'localStorage',
      desc: '',
      args: [],
    );
  }

  /// `Data is saved in a local database on the device and the app does not need a server to show or edit it.`
  String get localStorageBody {
    return Intl.message(
      'Data is saved in a local database on the device and the app does not need a server to show or edit it.',
      name: 'localStorageBody',
      desc: '',
      args: [],
    );
  }

  /// `No login`
  String get noLogin {
    return Intl.message('No login', name: 'noLogin', desc: '', args: []);
  }

  /// `Accounts, access tokens, and authentication sessions are not used in the current local flow.`
  String get noLoginBody {
    return Intl.message(
      'Accounts, access tokens, and authentication sessions are not used in the current local flow.',
      name: 'noLoginBody',
      desc: '',
      args: [],
    );
  }

  /// `Backup responsibility`
  String get backupResponsibility {
    return Intl.message(
      'Backup responsibility',
      name: 'backupResponsibility',
      desc: '',
      args: [],
    );
  }

  /// `Deleting the app or its data from system settings may delete local records.`
  String get backupResponsibilityBody {
    return Intl.message(
      'Deleting the app or its data from system settings may delete local records.',
      name: 'backupResponsibilityBody',
      desc: '',
      args: [],
    );
  }

  /// `Personal use`
  String get termsPersonalUse {
    return Intl.message(
      'Personal use',
      name: 'termsPersonalUse',
      desc: '',
      args: [],
    );
  }

  /// `The app is for recording and tracking debts and payments for organization only and is not a substitute for legal or accounting advice.`
  String get termsPersonalUseBody {
    return Intl.message(
      'The app is for recording and tracking debts and payments for organization only and is not a substitute for legal or accounting advice.',
      name: 'termsPersonalUseBody',
      desc: '',
      args: [],
    );
  }

  /// `Data accuracy`
  String get termsDataAccuracy {
    return Intl.message(
      'Data accuracy',
      name: 'termsDataAccuracy',
      desc: '',
      args: [],
    );
  }

  /// `The user is responsible for entering and reviewing data and checking amounts and dates.`
  String get termsDataAccuracyBody {
    return Intl.message(
      'The user is responsible for entering and reviewing data and checking amounts and dates.',
      name: 'termsDataAccuracyBody',
      desc: '',
      args: [],
    );
  }

  /// `Local data`
  String get termsLocalData {
    return Intl.message(
      'Local data',
      name: 'termsLocalData',
      desc: '',
      args: [],
    );
  }

  /// `Because the app works without a server, protecting the device and backing up data is the user's responsibility.`
  String get termsLocalDataBody {
    return Intl.message(
      'Because the app works without a server, protecting the device and backing up data is the user\'s responsibility.',
      name: 'termsLocalDataBody',
      desc: '',
      args: [],
    );
  }

  /// `By using Sajilha, you agree to use it as a local organization tool for your records.`
  String get termsIntro {
    return Intl.message(
      'By using Sajilha, you agree to use it as a local organization tool for your records.',
      name: 'termsIntro',
      desc: '',
      args: [],
    );
  }

  /// `Manage debts and payments simply`
  String get brandTagline {
    return Intl.message(
      'Manage debts and payments simply',
      name: 'brandTagline',
      desc: '',
      args: [],
    );
  }

  /// `We help individuals and small businesses record debts and payments quickly, and track balances clearly without complexity.`
  String get brandMission {
    return Intl.message(
      'We help individuals and small businesses record debts and payments quickly, and track balances clearly without complexity.',
      name: 'brandMission',
      desc: '',
      args: [],
    );
  }

  /// `Privacy first`
  String get brandValuePrivacy {
    return Intl.message(
      'Privacy first',
      name: 'brandValuePrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Simple Arabic interface`
  String get brandValueArabicUi {
    return Intl.message(
      'Simple Arabic interface',
      name: 'brandValueArabicUi',
      desc: '',
      args: [],
    );
  }

  /// `Local offline work`
  String get brandValueOffline {
    return Intl.message(
      'Local offline work',
      name: 'brandValueOffline',
      desc: '',
      args: [],
    );
  }

  /// `Clear numbers that are easy to review`
  String get brandValueClearNumbers {
    return Intl.message(
      'Clear numbers that are easy to review',
      name: 'brandValueClearNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Our mission`
  String get ourMission {
    return Intl.message('Our mission', name: 'ourMission', desc: '', args: []);
  }

  /// `What makes the app different`
  String get whatMakesAppDifferent {
    return Intl.message(
      'What makes the app different',
      name: 'whatMakesAppDifferent',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message('Contact us', name: 'contactUs', desc: '', args: []);
  }

  /// `Version`
  String get versionShort {
    return Intl.message('Version', name: 'versionShort', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

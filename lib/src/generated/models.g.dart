// ignore_for_file: sort_constructors_first

/// This file is used for `Data Class` generation.
///
/// Modify this file at your own risk!
///
/// See: https://pub.dev/packages/generators#data-class-generator
///

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
import 'package:meta/meta.dart';

/// The enum for the [CompanyContactModel.type].
enum CompanyContactType {
  /// The `DIRECTOR` property of this [CompanyContactType].
  director,

  /// The `ACCOUNTANT` property of this [CompanyContactType].
  accountant,

  /// The `MANAGER` property of this [CompanyContactType].
  manager;

  /// The name of the enum value.
  String get name {
    switch (this) {
      case CompanyContactType.director:
        return 'DIRECTOR';
      case CompanyContactType.accountant:
        return 'ACCOUNTANT';
      case CompanyContactType.manager:
        return 'MANAGER';
    }
  }
}

/// The enum for the [GroupMemberModel.rights].
enum GroupMemberRights {
  /// The `OPEN_CONTAINERS` property of this [GroupMemberRights].
  openContainers,

  /// The `SCAN_BONUSES` property of this [GroupMemberRights].
  scanBonuses,

  /// The `EDIT_BONUSES` property of this [GroupMemberRights].
  editBonuses,

  /// The `MANAGE_MEMBERS` property of this [GroupMemberRights].
  manageMembers;

  /// The name of the enum value.
  String get name {
    switch (this) {
      case GroupMemberRights.openContainers:
        return 'OPEN_CONTAINERS';
      case GroupMemberRights.scanBonuses:
        return 'SCAN_BONUSES';
      case GroupMemberRights.editBonuses:
        return 'EDIT_BONUSES';
      case GroupMemberRights.manageMembers:
        return 'MANAGE_MEMBERS';
    }
  }
}

/// The optional converter of the [AddressModel].
const OptionalAddressConverter optionalAddressConverter =
    OptionalAddressConverter._();

/// The optional converter of the [AddressModel].
@sealed
@immutable
class OptionalAddressConverter
    implements JsonConverter<AddressModel?, Map<String, Object?>?> {
  const OptionalAddressConverter._();

  @override
  AddressModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : AddressModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final AddressModel? value) => value?.toMap();
}

/// The converter of the [AddressModel].
const AddressConverter addressConverter = AddressConverter._();

/// The converter of the [AddressModel].
@sealed
@immutable
class AddressConverter
    implements JsonConverter<AddressModel, Map<String, Object?>> {
  const AddressConverter._();

  @override
  AddressModel fromJson(final Map<String, Object?> value) =>
      AddressModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final AddressModel value) => value.toMap();
}

/// The optional converter of the [BankModel].
const OptionalBankConverter optionalBankConverter = OptionalBankConverter._();

/// The optional converter of the [BankModel].
@sealed
@immutable
class OptionalBankConverter
    implements JsonConverter<BankModel?, Map<String, Object?>?> {
  const OptionalBankConverter._();

  @override
  BankModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : BankModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final BankModel? value) => value?.toMap();
}

/// The converter of the [BankModel].
const BankConverter bankConverter = BankConverter._();

/// The converter of the [BankModel].
@sealed
@immutable
class BankConverter implements JsonConverter<BankModel, Map<String, Object?>> {
  const BankConverter._();

  @override
  BankModel fromJson(final Map<String, Object?> value) =>
      BankModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final BankModel value) => value.toMap();
}

/// The optional converter of the [ImageModel].
const OptionalImageConverter optionalImageConverter =
    OptionalImageConverter._();

/// The optional converter of the [ImageModel].
@sealed
@immutable
class OptionalImageConverter
    implements JsonConverter<ImageModel?, Map<String, Object?>?> {
  const OptionalImageConverter._();

  @override
  ImageModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ImageModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ImageModel? value) => value?.toMap();
}

/// The converter of the [ImageModel].
const ImageConverter imageConverter = ImageConverter._();

/// The converter of the [ImageModel].
@sealed
@immutable
class ImageConverter
    implements JsonConverter<ImageModel, Map<String, Object?>> {
  const ImageConverter._();

  @override
  ImageModel fromJson(final Map<String, Object?> value) =>
      ImageModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ImageModel value) => value.toMap();
}

/// The optional converter of the [MeasurementModel].
const OptionalMeasurementConverter optionalMeasurementConverter =
    OptionalMeasurementConverter._();

/// The optional converter of the [MeasurementModel].
@sealed
@immutable
class OptionalMeasurementConverter
    implements JsonConverter<MeasurementModel?, Map<String, Object?>?> {
  const OptionalMeasurementConverter._();

  @override
  MeasurementModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : MeasurementModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final MeasurementModel? value) => value?.toMap();
}

/// The converter of the [MeasurementModel].
const MeasurementConverter measurementConverter = MeasurementConverter._();

/// The converter of the [MeasurementModel].
@sealed
@immutable
class MeasurementConverter
    implements JsonConverter<MeasurementModel, Map<String, Object?>> {
  const MeasurementConverter._();

  @override
  MeasurementModel fromJson(final Map<String, Object?> value) =>
      MeasurementModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final MeasurementModel value) => value.toMap();
}

/// The optional converter of the [PriceModel].
const OptionalPriceConverter optionalPriceConverter =
    OptionalPriceConverter._();

/// The optional converter of the [PriceModel].
@sealed
@immutable
class OptionalPriceConverter
    implements JsonConverter<PriceModel?, Map<String, Object?>?> {
  const OptionalPriceConverter._();

  @override
  PriceModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : PriceModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final PriceModel? value) => value?.toMap();
}

/// The converter of the [PriceModel].
const PriceConverter priceConverter = PriceConverter._();

/// The converter of the [PriceModel].
@sealed
@immutable
class PriceConverter
    implements JsonConverter<PriceModel, Map<String, Object?>> {
  const PriceConverter._();

  @override
  PriceModel fromJson(final Map<String, Object?> value) =>
      PriceModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final PriceModel value) => value.toMap();
}

/// The optional converter of the [LocaleModel].
const OptionalLocaleConverter optionalLocaleConverter =
    OptionalLocaleConverter._();

/// The optional converter of the [LocaleModel].
@sealed
@immutable
class OptionalLocaleConverter
    implements JsonConverter<LocaleModel?, Map<String, Object?>?> {
  const OptionalLocaleConverter._();

  @override
  LocaleModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : LocaleModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final LocaleModel? value) => value?.toMap();
}

/// The converter of the [LocaleModel].
const LocaleConverter localeConverter = LocaleConverter._();

/// The converter of the [LocaleModel].
@sealed
@immutable
class LocaleConverter
    implements JsonConverter<LocaleModel, Map<String, Object?>> {
  const LocaleConverter._();

  @override
  LocaleModel fromJson(final Map<String, Object?> value) =>
      LocaleModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final LocaleModel value) => value.toMap();
}

/// The optional converter of the [TextModel].
const OptionalTextConverter optionalTextConverter = OptionalTextConverter._();

/// The optional converter of the [TextModel].
@sealed
@immutable
class OptionalTextConverter
    implements JsonConverter<TextModel?, Map<String, Object?>?> {
  const OptionalTextConverter._();

  @override
  TextModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : TextModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final TextModel? value) => value?.toMap();
}

/// The converter of the [TextModel].
const TextConverter textConverter = TextConverter._();

/// The converter of the [TextModel].
@sealed
@immutable
class TextConverter implements JsonConverter<TextModel, Map<String, Object?>> {
  const TextConverter._();

  @override
  TextModel fromJson(final Map<String, Object?> value) =>
      TextModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final TextModel value) => value.toMap();
}

/// The optional converter of the [LocaleTextModel].
const OptionalLocaleTextConverter optionalLocaleTextConverter =
    OptionalLocaleTextConverter._();

/// The optional converter of the [LocaleTextModel].
@sealed
@immutable
class OptionalLocaleTextConverter
    implements JsonConverter<LocaleTextModel?, Map<String, Object?>?> {
  const OptionalLocaleTextConverter._();

  @override
  LocaleTextModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : LocaleTextModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final LocaleTextModel? value) => value?.toMap();
}

/// The converter of the [LocaleTextModel].
const LocaleTextConverter localeTextConverter = LocaleTextConverter._();

/// The converter of the [LocaleTextModel].
@sealed
@immutable
class LocaleTextConverter
    implements JsonConverter<LocaleTextModel, Map<String, Object?>> {
  const LocaleTextConverter._();

  @override
  LocaleTextModel fromJson(final Map<String, Object?> value) =>
      LocaleTextModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final LocaleTextModel value) => value.toMap();
}

/// The optional converter of the [SettingsModel].
const OptionalSettingsConverter optionalSettingsConverter =
    OptionalSettingsConverter._();

/// The optional converter of the [SettingsModel].
@sealed
@immutable
class OptionalSettingsConverter
    implements JsonConverter<SettingsModel?, Map<String, Object?>?> {
  const OptionalSettingsConverter._();

  @override
  SettingsModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : SettingsModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final SettingsModel? value) => value?.toMap();
}

/// The converter of the [SettingsModel].
const SettingsConverter settingsConverter = SettingsConverter._();

/// The converter of the [SettingsModel].
@sealed
@immutable
class SettingsConverter
    implements JsonConverter<SettingsModel, Map<String, Object?>> {
  const SettingsConverter._();

  @override
  SettingsModel fromJson(final Map<String, Object?> value) =>
      SettingsModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final SettingsModel value) => value.toMap();
}

/// The optional converter of the [UserModel].
const OptionalUserConverter optionalUserConverter = OptionalUserConverter._();

/// The optional converter of the [UserModel].
@sealed
@immutable
class OptionalUserConverter
    implements JsonConverter<UserModel?, Map<String, Object?>?> {
  const OptionalUserConverter._();

  @override
  UserModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : UserModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final UserModel? value) => value?.toMap();
}

/// The converter of the [UserModel].
const UserConverter userConverter = UserConverter._();

/// The converter of the [UserModel].
@sealed
@immutable
class UserConverter implements JsonConverter<UserModel, Map<String, Object?>> {
  const UserConverter._();

  @override
  UserModel fromJson(final Map<String, Object?> value) =>
      UserModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final UserModel value) => value.toMap();
}

/// The optional converter of the [CompanyModel].
const OptionalCompanyConverter optionalCompanyConverter =
    OptionalCompanyConverter._();

/// The optional converter of the [CompanyModel].
@sealed
@immutable
class OptionalCompanyConverter
    implements JsonConverter<CompanyModel?, Map<String, Object?>?> {
  const OptionalCompanyConverter._();

  @override
  CompanyModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : CompanyModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final CompanyModel? value) => value?.toMap();
}

/// The converter of the [CompanyModel].
const CompanyConverter companyConverter = CompanyConverter._();

/// The converter of the [CompanyModel].
@sealed
@immutable
class CompanyConverter
    implements JsonConverter<CompanyModel, Map<String, Object?>> {
  const CompanyConverter._();

  @override
  CompanyModel fromJson(final Map<String, Object?> value) =>
      CompanyModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final CompanyModel value) => value.toMap();
}

/// The optional converter of the [CompanyContactModel].
const OptionalCompanyContactConverter optionalCompanyContactConverter =
    OptionalCompanyContactConverter._();

/// The optional converter of the [CompanyContactModel].
@sealed
@immutable
class OptionalCompanyContactConverter
    implements JsonConverter<CompanyContactModel?, Map<String, Object?>?> {
  const OptionalCompanyContactConverter._();

  @override
  CompanyContactModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : CompanyContactModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final CompanyContactModel? value) =>
      value?.toMap();
}

/// The converter of the [CompanyContactModel].
const CompanyContactConverter companyContactConverter =
    CompanyContactConverter._();

/// The converter of the [CompanyContactModel].
@sealed
@immutable
class CompanyContactConverter
    implements JsonConverter<CompanyContactModel, Map<String, Object?>> {
  const CompanyContactConverter._();

  @override
  CompanyContactModel fromJson(final Map<String, Object?> value) =>
      CompanyContactModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final CompanyContactModel value) => value.toMap();
}

/// The optional converter of the [DealModel].
const OptionalDealConverter optionalDealConverter = OptionalDealConverter._();

/// The optional converter of the [DealModel].
@sealed
@immutable
class OptionalDealConverter
    implements JsonConverter<DealModel?, Map<String, Object?>?> {
  const OptionalDealConverter._();

  @override
  DealModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : DealModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final DealModel? value) => value?.toMap();
}

/// The converter of the [DealModel].
const DealConverter dealConverter = DealConverter._();

/// The converter of the [DealModel].
@sealed
@immutable
class DealConverter implements JsonConverter<DealModel, Map<String, Object?>> {
  const DealConverter._();

  @override
  DealModel fromJson(final Map<String, Object?> value) =>
      DealModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final DealModel value) => value.toMap();
}

/// The optional converter of the [ServiceModel].
const OptionalServiceConverter optionalServiceConverter =
    OptionalServiceConverter._();

/// The optional converter of the [ServiceModel].
@sealed
@immutable
class OptionalServiceConverter
    implements JsonConverter<ServiceModel?, Map<String, Object?>?> {
  const OptionalServiceConverter._();

  @override
  ServiceModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ServiceModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ServiceModel? value) => value?.toMap();
}

/// The converter of the [ServiceModel].
const ServiceConverter serviceConverter = ServiceConverter._();

/// The converter of the [ServiceModel].
@sealed
@immutable
class ServiceConverter
    implements JsonConverter<ServiceModel, Map<String, Object?>> {
  const ServiceConverter._();

  @override
  ServiceModel fromJson(final Map<String, Object?> value) =>
      ServiceModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ServiceModel value) => value.toMap();
}

/// The optional converter of the [DealServiceModel].
const OptionalDealServiceConverter optionalDealServiceConverter =
    OptionalDealServiceConverter._();

/// The optional converter of the [DealServiceModel].
@sealed
@immutable
class OptionalDealServiceConverter
    implements JsonConverter<DealServiceModel?, Map<String, Object?>?> {
  const OptionalDealServiceConverter._();

  @override
  DealServiceModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : DealServiceModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final DealServiceModel? value) => value?.toMap();
}

/// The converter of the [DealServiceModel].
const DealServiceConverter dealServiceConverter = DealServiceConverter._();

/// The converter of the [DealServiceModel].
@sealed
@immutable
class DealServiceConverter
    implements JsonConverter<DealServiceModel, Map<String, Object?>> {
  const DealServiceConverter._();

  @override
  DealServiceModel fromJson(final Map<String, Object?> value) =>
      DealServiceModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final DealServiceModel value) => value.toMap();
}

/// The optional converter of the [GroupModel].
const OptionalGroupConverter optionalGroupConverter =
    OptionalGroupConverter._();

/// The optional converter of the [GroupModel].
@sealed
@immutable
class OptionalGroupConverter
    implements JsonConverter<GroupModel?, Map<String, Object?>?> {
  const OptionalGroupConverter._();

  @override
  GroupModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : GroupModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final GroupModel? value) => value?.toMap();
}

/// The converter of the [GroupModel].
const GroupConverter groupConverter = GroupConverter._();

/// The converter of the [GroupModel].
@sealed
@immutable
class GroupConverter
    implements JsonConverter<GroupModel, Map<String, Object?>> {
  const GroupConverter._();

  @override
  GroupModel fromJson(final Map<String, Object?> value) =>
      GroupModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final GroupModel value) => value.toMap();
}

/// The optional converter of the [GroupMemberModel].
const OptionalGroupMemberConverter optionalGroupMemberConverter =
    OptionalGroupMemberConverter._();

/// The optional converter of the [GroupMemberModel].
@sealed
@immutable
class OptionalGroupMemberConverter
    implements JsonConverter<GroupMemberModel?, Map<String, Object?>?> {
  const OptionalGroupMemberConverter._();

  @override
  GroupMemberModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : GroupMemberModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final GroupMemberModel? value) => value?.toMap();
}

/// The converter of the [GroupMemberModel].
const GroupMemberConverter groupMemberConverter = GroupMemberConverter._();

/// The converter of the [GroupMemberModel].
@sealed
@immutable
class GroupMemberConverter
    implements JsonConverter<GroupMemberModel, Map<String, Object?>> {
  const GroupMemberConverter._();

  @override
  GroupMemberModel fromJson(final Map<String, Object?> value) =>
      GroupMemberModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final GroupMemberModel value) => value.toMap();
}

/// The optional converter of the [PersonModel].
const OptionalPersonConverter optionalPersonConverter =
    OptionalPersonConverter._();

/// The optional converter of the [PersonModel].
@sealed
@immutable
class OptionalPersonConverter
    implements JsonConverter<PersonModel?, Map<String, Object?>?> {
  const OptionalPersonConverter._();

  @override
  PersonModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : PersonModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final PersonModel? value) => value?.toMap();
}

/// The converter of the [PersonModel].
const PersonConverter personConverter = PersonConverter._();

/// The converter of the [PersonModel].
@sealed
@immutable
class PersonConverter
    implements JsonConverter<PersonModel, Map<String, Object?>> {
  const PersonConverter._();

  @override
  PersonModel fromJson(final Map<String, Object?> value) =>
      PersonModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final PersonModel value) => value.toMap();
}

/// The optional converter of the [ServicePriceModel].
const OptionalServicePriceConverter optionalServicePriceConverter =
    OptionalServicePriceConverter._();

/// The optional converter of the [ServicePriceModel].
@sealed
@immutable
class OptionalServicePriceConverter
    implements JsonConverter<ServicePriceModel?, Map<String, Object?>?> {
  const OptionalServicePriceConverter._();

  @override
  ServicePriceModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ServicePriceModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ServicePriceModel? value) =>
      value?.toMap();
}

/// The converter of the [ServicePriceModel].
const ServicePriceConverter servicePriceConverter = ServicePriceConverter._();

/// The converter of the [ServicePriceModel].
@sealed
@immutable
class ServicePriceConverter
    implements JsonConverter<ServicePriceModel, Map<String, Object?>> {
  const ServicePriceConverter._();

  @override
  ServicePriceModel fromJson(final Map<String, Object?> value) =>
      ServicePriceModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ServicePriceModel value) => value.toMap();
}

/// The optional converter of the [BonusModel].
const OptionalBonusConverter optionalBonusConverter =
    OptionalBonusConverter._();

/// The optional converter of the [BonusModel].
@sealed
@immutable
class OptionalBonusConverter
    implements JsonConverter<BonusModel?, Map<String, Object?>?> {
  const OptionalBonusConverter._();

  @override
  BonusModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : BonusModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final BonusModel? value) => value?.toMap();
}

/// The converter of the [BonusModel].
const BonusConverter bonusConverter = BonusConverter._();

/// The converter of the [BonusModel].
@sealed
@immutable
class BonusConverter
    implements JsonConverter<BonusModel, Map<String, Object?>> {
  const BonusConverter._();

  @override
  BonusModel fromJson(final Map<String, Object?> value) =>
      BonusModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final BonusModel value) => value.toMap();
}

/// The optional converter of the [BonusCouponModel].
const OptionalBonusCouponConverter optionalBonusCouponConverter =
    OptionalBonusCouponConverter._();

/// The optional converter of the [BonusCouponModel].
@sealed
@immutable
class OptionalBonusCouponConverter
    implements JsonConverter<BonusCouponModel?, Map<String, Object?>?> {
  const OptionalBonusCouponConverter._();

  @override
  BonusCouponModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : BonusCouponModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final BonusCouponModel? value) => value?.toMap();
}

/// The converter of the [BonusCouponModel].
const BonusCouponConverter bonusCouponConverter = BonusCouponConverter._();

/// The converter of the [BonusCouponModel].
@sealed
@immutable
class BonusCouponConverter
    implements JsonConverter<BonusCouponModel, Map<String, Object?>> {
  const BonusCouponConverter._();

  @override
  BonusCouponModel fromJson(final Map<String, Object?> value) =>
      BonusCouponModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final BonusCouponModel value) => value.toMap();
}

/// The optional converter of the [BonusImageModel].
const OptionalBonusImageConverter optionalBonusImageConverter =
    OptionalBonusImageConverter._();

/// The optional converter of the [BonusImageModel].
@sealed
@immutable
class OptionalBonusImageConverter
    implements JsonConverter<BonusImageModel?, Map<String, Object?>?> {
  const OptionalBonusImageConverter._();

  @override
  BonusImageModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : BonusImageModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final BonusImageModel? value) => value?.toMap();
}

/// The converter of the [BonusImageModel].
const BonusImageConverter bonusImageConverter = BonusImageConverter._();

/// The converter of the [BonusImageModel].
@sealed
@immutable
class BonusImageConverter
    implements JsonConverter<BonusImageModel, Map<String, Object?>> {
  const BonusImageConverter._();

  @override
  BonusImageModel fromJson(final Map<String, Object?> value) =>
      BonusImageModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final BonusImageModel value) => value.toMap();
}

/// The optional converter of the [BonusPriceModel].
const OptionalBonusPriceConverter optionalBonusPriceConverter =
    OptionalBonusPriceConverter._();

/// The optional converter of the [BonusPriceModel].
@sealed
@immutable
class OptionalBonusPriceConverter
    implements JsonConverter<BonusPriceModel?, Map<String, Object?>?> {
  const OptionalBonusPriceConverter._();

  @override
  BonusPriceModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : BonusPriceModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final BonusPriceModel? value) => value?.toMap();
}

/// The converter of the [BonusPriceModel].
const BonusPriceConverter bonusPriceConverter = BonusPriceConverter._();

/// The converter of the [BonusPriceModel].
@sealed
@immutable
class BonusPriceConverter
    implements JsonConverter<BonusPriceModel, Map<String, Object?>> {
  const BonusPriceConverter._();

  @override
  BonusPriceModel fromJson(final Map<String, Object?> value) =>
      BonusPriceModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final BonusPriceModel value) => value.toMap();
}

/// The optional converter of the [ContainerModel].
const OptionalContainerConverter optionalContainerConverter =
    OptionalContainerConverter._();

/// The optional converter of the [ContainerModel].
@sealed
@immutable
class OptionalContainerConverter
    implements JsonConverter<ContainerModel?, Map<String, Object?>?> {
  const OptionalContainerConverter._();

  @override
  ContainerModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ContainerModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ContainerModel? value) => value?.toMap();
}

/// The converter of the [ContainerModel].
const ContainerConverter containerConverter = ContainerConverter._();

/// The converter of the [ContainerModel].
@sealed
@immutable
class ContainerConverter
    implements JsonConverter<ContainerModel, Map<String, Object?>> {
  const ContainerConverter._();

  @override
  ContainerModel fromJson(final Map<String, Object?> value) =>
      ContainerModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ContainerModel value) => value.toMap();
}

/// The optional converter of the [ContainerReportTypeModel].
const OptionalContainerReportTypeConverter
    optionalContainerReportTypeConverter =
    OptionalContainerReportTypeConverter._();

/// The optional converter of the [ContainerReportTypeModel].
@sealed
@immutable
class OptionalContainerReportTypeConverter
    implements JsonConverter<ContainerReportTypeModel?, Map<String, Object?>?> {
  const OptionalContainerReportTypeConverter._();

  @override
  ContainerReportTypeModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ContainerReportTypeModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ContainerReportTypeModel? value) =>
      value?.toMap();
}

/// The converter of the [ContainerReportTypeModel].
const ContainerReportTypeConverter containerReportTypeConverter =
    ContainerReportTypeConverter._();

/// The converter of the [ContainerReportTypeModel].
@sealed
@immutable
class ContainerReportTypeConverter
    implements JsonConverter<ContainerReportTypeModel, Map<String, Object?>> {
  const ContainerReportTypeConverter._();

  @override
  ContainerReportTypeModel fromJson(final Map<String, Object?> value) =>
      ContainerReportTypeModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ContainerReportTypeModel value) =>
      value.toMap();
}

/// The optional converter of the [ContainerTankTypeModel].
const OptionalContainerTankTypeConverter optionalContainerTankTypeConverter =
    OptionalContainerTankTypeConverter._();

/// The optional converter of the [ContainerTankTypeModel].
@sealed
@immutable
class OptionalContainerTankTypeConverter
    implements JsonConverter<ContainerTankTypeModel?, Map<String, Object?>?> {
  const OptionalContainerTankTypeConverter._();

  @override
  ContainerTankTypeModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ContainerTankTypeModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ContainerTankTypeModel? value) =>
      value?.toMap();
}

/// The converter of the [ContainerTankTypeModel].
const ContainerTankTypeConverter containerTankTypeConverter =
    ContainerTankTypeConverter._();

/// The converter of the [ContainerTankTypeModel].
@sealed
@immutable
class ContainerTankTypeConverter
    implements JsonConverter<ContainerTankTypeModel, Map<String, Object?>> {
  const ContainerTankTypeConverter._();

  @override
  ContainerTankTypeModel fromJson(final Map<String, Object?> value) =>
      ContainerTankTypeModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ContainerTankTypeModel value) =>
      value.toMap();
}

/// The optional converter of the [ContainerTankModel].
const OptionalContainerTankConverter optionalContainerTankConverter =
    OptionalContainerTankConverter._();

/// The optional converter of the [ContainerTankModel].
@sealed
@immutable
class OptionalContainerTankConverter
    implements JsonConverter<ContainerTankModel?, Map<String, Object?>?> {
  const OptionalContainerTankConverter._();

  @override
  ContainerTankModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ContainerTankModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ContainerTankModel? value) =>
      value?.toMap();
}

/// The converter of the [ContainerTankModel].
const ContainerTankConverter containerTankConverter =
    ContainerTankConverter._();

/// The converter of the [ContainerTankModel].
@sealed
@immutable
class ContainerTankConverter
    implements JsonConverter<ContainerTankModel, Map<String, Object?>> {
  const ContainerTankConverter._();

  @override
  ContainerTankModel fromJson(final Map<String, Object?> value) =>
      ContainerTankModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ContainerTankModel value) => value.toMap();
}

/// The optional converter of the [ContainerReportModel].
const OptionalContainerReportConverter optionalContainerReportConverter =
    OptionalContainerReportConverter._();

/// The optional converter of the [ContainerReportModel].
@sealed
@immutable
class OptionalContainerReportConverter
    implements JsonConverter<ContainerReportModel?, Map<String, Object?>?> {
  const OptionalContainerReportConverter._();

  @override
  ContainerReportModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ContainerReportModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ContainerReportModel? value) =>
      value?.toMap();
}

/// The converter of the [ContainerReportModel].
const ContainerReportConverter containerReportConverter =
    ContainerReportConverter._();

/// The converter of the [ContainerReportModel].
@sealed
@immutable
class ContainerReportConverter
    implements JsonConverter<ContainerReportModel, Map<String, Object?>> {
  const ContainerReportConverter._();

  @override
  ContainerReportModel fromJson(final Map<String, Object?> value) =>
      ContainerReportModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ContainerReportModel value) =>
      value.toMap();
}

/// The optional converter of the [ContainerTankClearingModel].
const OptionalContainerTankClearingConverter
    optionalContainerTankClearingConverter =
    OptionalContainerTankClearingConverter._();

/// The optional converter of the [ContainerTankClearingModel].
@sealed
@immutable
class OptionalContainerTankClearingConverter
    implements
        JsonConverter<ContainerTankClearingModel?, Map<String, Object?>?> {
  const OptionalContainerTankClearingConverter._();

  @override
  ContainerTankClearingModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ContainerTankClearingModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ContainerTankClearingModel? value) =>
      value?.toMap();
}

/// The converter of the [ContainerTankClearingModel].
const ContainerTankClearingConverter containerTankClearingConverter =
    ContainerTankClearingConverter._();

/// The converter of the [ContainerTankClearingModel].
@sealed
@immutable
class ContainerTankClearingConverter
    implements JsonConverter<ContainerTankClearingModel, Map<String, Object?>> {
  const ContainerTankClearingConverter._();

  @override
  ContainerTankClearingModel fromJson(final Map<String, Object?> value) =>
      ContainerTankClearingModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ContainerTankClearingModel value) =>
      value.toMap();
}

/// The optional converter of the [ContainerTankOpeningModel].
const OptionalContainerTankOpeningConverter
    optionalContainerTankOpeningConverter =
    OptionalContainerTankOpeningConverter._();

/// The optional converter of the [ContainerTankOpeningModel].
@sealed
@immutable
class OptionalContainerTankOpeningConverter
    implements
        JsonConverter<ContainerTankOpeningModel?, Map<String, Object?>?> {
  const OptionalContainerTankOpeningConverter._();

  @override
  ContainerTankOpeningModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ContainerTankOpeningModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ContainerTankOpeningModel? value) =>
      value?.toMap();
}

/// The converter of the [ContainerTankOpeningModel].
const ContainerTankOpeningConverter containerTankOpeningConverter =
    ContainerTankOpeningConverter._();

/// The converter of the [ContainerTankOpeningModel].
@sealed
@immutable
class ContainerTankOpeningConverter
    implements JsonConverter<ContainerTankOpeningModel, Map<String, Object?>> {
  const ContainerTankOpeningConverter._();

  @override
  ContainerTankOpeningModel fromJson(final Map<String, Object?> value) =>
      ContainerTankOpeningModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ContainerTankOpeningModel value) =>
      value.toMap();
}

/// The optional converter of the [ContainerTankOpeningDropModel].
const OptionalContainerTankOpeningDropConverter
    optionalContainerTankOpeningDropConverter =
    OptionalContainerTankOpeningDropConverter._();

/// The optional converter of the [ContainerTankOpeningDropModel].
@sealed
@immutable
class OptionalContainerTankOpeningDropConverter
    implements
        JsonConverter<ContainerTankOpeningDropModel?, Map<String, Object?>?> {
  const OptionalContainerTankOpeningDropConverter._();

  @override
  ContainerTankOpeningDropModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : ContainerTankOpeningDropModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final ContainerTankOpeningDropModel? value) =>
      value?.toMap();
}

/// The converter of the [ContainerTankOpeningDropModel].
const ContainerTankOpeningDropConverter containerTankOpeningDropConverter =
    ContainerTankOpeningDropConverter._();

/// The converter of the [ContainerTankOpeningDropModel].
@sealed
@immutable
class ContainerTankOpeningDropConverter
    implements
        JsonConverter<ContainerTankOpeningDropModel, Map<String, Object?>> {
  const ContainerTankOpeningDropConverter._();

  @override
  ContainerTankOpeningDropModel fromJson(final Map<String, Object?> value) =>
      ContainerTankOpeningDropModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final ContainerTankOpeningDropModel value) =>
      value.toMap();
}

/// The optional converter of the [DeliveryModel].
const OptionalDeliveryConverter optionalDeliveryConverter =
    OptionalDeliveryConverter._();

/// The optional converter of the [DeliveryModel].
@sealed
@immutable
class OptionalDeliveryConverter
    implements JsonConverter<DeliveryModel?, Map<String, Object?>?> {
  const OptionalDeliveryConverter._();

  @override
  DeliveryModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : DeliveryModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final DeliveryModel? value) => value?.toMap();
}

/// The converter of the [DeliveryModel].
const DeliveryConverter deliveryConverter = DeliveryConverter._();

/// The converter of the [DeliveryModel].
@sealed
@immutable
class DeliveryConverter
    implements JsonConverter<DeliveryModel, Map<String, Object?>> {
  const DeliveryConverter._();

  @override
  DeliveryModel fromJson(final Map<String, Object?> value) =>
      DeliveryModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final DeliveryModel value) => value.toMap();
}

/// The optional converter of the [DeliveryServiceModel].
const OptionalDeliveryServiceConverter optionalDeliveryServiceConverter =
    OptionalDeliveryServiceConverter._();

/// The optional converter of the [DeliveryServiceModel].
@sealed
@immutable
class OptionalDeliveryServiceConverter
    implements JsonConverter<DeliveryServiceModel?, Map<String, Object?>?> {
  const OptionalDeliveryServiceConverter._();

  @override
  DeliveryServiceModel? fromJson(final Map<String, Object?>? value) =>
      value == null ? null : DeliveryServiceModel.fromMap(value);

  @override
  Map<String, Object?>? toJson(final DeliveryServiceModel? value) =>
      value?.toMap();
}

/// The converter of the [DeliveryServiceModel].
const DeliveryServiceConverter deliveryServiceConverter =
    DeliveryServiceConverter._();

/// The converter of the [DeliveryServiceModel].
@sealed
@immutable
class DeliveryServiceConverter
    implements JsonConverter<DeliveryServiceModel, Map<String, Object?>> {
  const DeliveryServiceConverter._();

  @override
  DeliveryServiceModel fromJson(final Map<String, Object?> value) =>
      DeliveryServiceModel.fromMap(value);

  @override
  Map<String, Object?> toJson(final DeliveryServiceModel value) =>
      value.toMap();
}

/// The model of a AddressModel.
@sealed
@immutable
class AddressModel implements Comparable<AddressModel> {
  /// The model of a AddressModel.
  const AddressModel({
    required this.state,
    required this.city,
    required this.street,
    required this.building,
    required this.postalCode,
    this.id,
    this.country = 'Ukraine',
    this.appartment,
    this.banks = const Iterable<BankModel>.empty(),
    this.companies = const Iterable<CompanyModel>.empty(),
    this.containers = const Iterable<ContainerModel>.empty(),
    this.deliveries = const Iterable<DeliveryModel>.empty(),
  });

  /// The `id` property of this [AddressModel].
  final int? id;

  /// The `country` property of this [AddressModel].
  final String country;

  /// The `state` property of this [AddressModel].
  final String state;

  /// The `city` property of this [AddressModel].
  final String city;

  /// The `street` property of this [AddressModel].
  final String street;

  /// The `building` property of this [AddressModel].
  final int building;

  /// The `appartment` property of this [AddressModel].
  final int? appartment;

  /// The `postal_code` property of this [AddressModel].
  final int postalCode;

  /// The `banks` property of this [AddressModel].
  final Iterable<BankModel> banks;

  /// The `companies` property of this [AddressModel].
  final Iterable<CompanyModel> companies;

  /// The `containers` property of this [AddressModel].
  final Iterable<ContainerModel> containers;

  /// The `deliveries` property of this [AddressModel].
  final Iterable<DeliveryModel> deliveries;

  /// Return the copy of this model.
  AddressModel copyWith({
    final int? id,
    final String? country,
    final String? state,
    final String? city,
    final String? street,
    final int? building,
    final int? appartment,
    final int? postalCode,
    final Iterable<BankModel>? banks,
    final Iterable<CompanyModel>? companies,
    final Iterable<ContainerModel>? containers,
    final Iterable<DeliveryModel>? deliveries,
  }) =>
      AddressModel(
        id: id ?? this.id,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        street: street ?? this.street,
        building: building ?? this.building,
        appartment: appartment ?? this.appartment,
        postalCode: postalCode ?? this.postalCode,
        banks: banks ?? this.banks,
        companies: companies ?? this.companies,
        containers: containers ?? this.containers,
        deliveries: deliveries ?? this.deliveries,
      );

  /// Return the copy of this model with nullable fields.
  AddressModel copyWithNull({
    final bool id = false,
    final bool appartment = false,
  }) =>
      AddressModel(
        id: id ? null : this.id,
        country: country,
        state: state,
        city: city,
        street: street,
        building: building,
        appartment: appartment ? null : this.appartment,
        postalCode: postalCode,
        banks: banks,
        companies: companies,
        containers: containers,
        deliveries: deliveries,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (id != null) 'id': id,
        'country': country,
        'state': state,
        'city': city,
        'street': street,
        'building': building,
        if (appartment != null) 'appartment': appartment,
        'postal_code': postalCode,
        'banks': const IterableConverter<BankModel, Map<String, Object?>>(
          bankConverter,
        ).toJson(banks).toList(growable: false),
        'companies':
            const IterableConverter<CompanyModel, Map<String, Object?>>(
          companyConverter,
        ).toJson(companies).toList(growable: false),
        'containers':
            const IterableConverter<ContainerModel, Map<String, Object?>>(
          containerConverter,
        ).toJson(containers).toList(growable: false),
        'deliveries':
            const IterableConverter<DeliveryModel, Map<String, Object?>>(
          deliveryConverter,
        ).toJson(deliveries).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory AddressModel.fromMap(final Map<String, Object?> map) => AddressModel(
        id: map['id'] as int?,
        country: map['country']! as String,
        state: map['state']! as String,
        city: map['city']! as String,
        street: map['street']! as String,
        building: map['building']! as int,
        appartment: map['appartment'] as int?,
        postalCode: map['postal_code']! as int,
        banks: const IterableConverter<BankModel, Map<String, Object?>>(
          bankConverter,
        ).fromJson(
          (map['banks'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        companies: const IterableConverter<CompanyModel, Map<String, Object?>>(
          companyConverter,
        ).fromJson(
          (map['companies'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        containers:
            const IterableConverter<ContainerModel, Map<String, Object?>>(
          containerConverter,
        ).fromJson(
          (map['containers'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        deliveries:
            const IterableConverter<DeliveryModel, Map<String, Object?>>(
          deliveryConverter,
        ).fromJson(
          (map['deliveries'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory AddressModel.fromJson(final String source) =>
      AddressModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final AddressModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is AddressModel &&
          other.id == id &&
          other.country == country &&
          other.state == state &&
          other.city == city &&
          other.street == street &&
          other.building == building &&
          other.appartment == appartment &&
          other.postalCode == postalCode;

  @override
  int get hashCode =>
      id.hashCode ^
      country.hashCode ^
      state.hashCode ^
      city.hashCode ^
      street.hashCode ^
      building.hashCode ^
      appartment.hashCode ^
      postalCode.hashCode;

  @override
  String toString() =>
      'AddressModel(id: $id, country: $country, state: $state, city: $city, '
      'street: $street, building: $building, appartment: $appartment, '
      'postalCode: $postalCode, banks: $banks, companies: $companies, '
      'containers: $containers, deliveries: $deliveries)';
}

/// The model of a BankModel.
@sealed
@immutable
class BankModel implements Comparable<BankModel> {
  /// The model of a BankModel.
  const BankModel({
    required this.code,
    required this.name,
    this.addressId,
    this.address,
    this.companies = const Iterable<CompanyModel>.empty(),
  });

  /// The `code` property of this [BankModel].
  final int code;

  /// The `name` property of this [BankModel].
  final String name;

  /// The `address_id` property of this [BankModel].
  final int? addressId;

  /// The `address` property of this [BankModel].
  final AddressModel? address;

  /// The `companies` property of this [BankModel].
  final Iterable<CompanyModel> companies;

  /// Return the copy of this model.
  BankModel copyWith({
    final int? code,
    final String? name,
    final int? addressId,
    final AddressModel? address,
    final Iterable<CompanyModel>? companies,
  }) =>
      BankModel(
        code: code ?? this.code,
        name: name ?? this.name,
        addressId: addressId ?? this.addressId,
        address: address ?? this.address,
        companies: companies ?? this.companies,
      );

  /// Return the copy of this model with nullable fields.
  BankModel copyWithNull({
    final bool addressId = false,
    final bool address = false,
  }) =>
      BankModel(
        code: code,
        name: name,
        addressId: addressId ? null : this.addressId,
        address: address ? null : this.address,
        companies: companies,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        'code': code,
        'name': name,
        if (addressId != null) 'address_id': addressId,
        if (address != null)
          'address': optionalAddressConverter.toJson(address),
        'companies':
            const IterableConverter<CompanyModel, Map<String, Object?>>(
          companyConverter,
        ).toJson(companies).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory BankModel.fromMap(final Map<String, Object?> map) => BankModel(
        code: map['code']! as int,
        name: map['name']! as String,
        addressId: map['address_id'] as int?,
        address: optionalAddressConverter
            .fromJson(map['address'] as Map<String, Object?>?),
        companies: const IterableConverter<CompanyModel, Map<String, Object?>>(
          companyConverter,
        ).fromJson(
          (map['companies'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory BankModel.fromJson(final String source) =>
      BankModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final BankModel other) => code.compareTo(other.code);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is BankModel &&
          other.code == code &&
          other.name == name &&
          other.addressId == addressId;

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ addressId.hashCode;

  @override
  String toString() =>
      'BankModel(code: $code, name: $name, addressId: $addressId, '
      'address: $address, companies: $companies)';
}

/// The model of a ImageModel.
@sealed
@immutable
class ImageModel implements Comparable<ImageModel> {
  /// The model of a ImageModel.
  const ImageModel({
    required this.url,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.bonuses = const Iterable<BonusImageModel>.empty(),
  });

  /// The `id` property of this [ImageModel].
  final int? id;

  /// The `url` property of this [ImageModel].
  final String url;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `bonuses` property of this [ImageModel].
  final Iterable<BonusImageModel> bonuses;

  /// Return the copy of this model.
  ImageModel copyWith({
    final int? id,
    final String? url,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Iterable<BonusImageModel>? bonuses,
  }) =>
      ImageModel(
        id: id ?? this.id,
        url: url ?? this.url,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        bonuses: bonuses ?? this.bonuses,
      );

  /// Return the copy of this model with nullable fields.
  ImageModel copyWithNull({
    final bool id = false,
    final bool createdAt = false,
    final bool updatedAt = false,
  }) =>
      ImageModel(
        id: id ? null : this.id,
        url: url,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        bonuses: bonuses,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (id != null) 'id': id,
        'url': url,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        'bonuses':
            const IterableConverter<BonusImageModel, Map<String, Object?>>(
          bonusImageConverter,
        ).toJson(bonuses).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory ImageModel.fromMap(final Map<String, Object?> map) => ImageModel(
        id: map['id'] as int?,
        url: map['url']! as String,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        bonuses: const IterableConverter<BonusImageModel, Map<String, Object?>>(
          bonusImageConverter,
        ).fromJson(
          (map['bonuses'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ImageModel.fromJson(final String source) =>
      ImageModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final ImageModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ImageModel && other.id == id && other.url == url;

  @override
  int get hashCode => id.hashCode ^ url.hashCode;

  @override
  String toString() => 'ImageModel(id: $id, url: $url, createdAt: $createdAt, '
      'updatedAt: $updatedAt, bonuses: $bonuses)';
}

/// The model of a MeasurementModel.
@sealed
@immutable
class MeasurementModel implements Comparable<MeasurementModel> {
  /// The model of a MeasurementModel.
  const MeasurementModel({
    required this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.containerTankTypes = const Iterable<ContainerTankTypeModel>.empty(),
    this.services = const Iterable<ServiceModel>.empty(),
  });

  /// The `id` property of this [MeasurementModel].
  final int? id;

  /// The `name` property of this [MeasurementModel].
  final String name;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `container_tank_types` property of this [MeasurementModel].
  final Iterable<ContainerTankTypeModel> containerTankTypes;

  /// The `services` property of this [MeasurementModel].
  final Iterable<ServiceModel> services;

  /// Return the copy of this model.
  MeasurementModel copyWith({
    final int? id,
    final String? name,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Iterable<ContainerTankTypeModel>? containerTankTypes,
    final Iterable<ServiceModel>? services,
  }) =>
      MeasurementModel(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        containerTankTypes: containerTankTypes ?? this.containerTankTypes,
        services: services ?? this.services,
      );

  /// Return the copy of this model with nullable fields.
  MeasurementModel copyWithNull({
    final bool id = false,
    final bool createdAt = false,
    final bool updatedAt = false,
  }) =>
      MeasurementModel(
        id: id ? null : this.id,
        name: name,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        containerTankTypes: containerTankTypes,
        services: services,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (id != null) 'id': id,
        'name': name,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        'container_tank_types': const IterableConverter<ContainerTankTypeModel,
            Map<String, Object?>>(
          containerTankTypeConverter,
        ).toJson(containerTankTypes).toList(growable: false),
        'services': const IterableConverter<ServiceModel, Map<String, Object?>>(
          serviceConverter,
        ).toJson(services).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory MeasurementModel.fromMap(final Map<String, Object?> map) =>
      MeasurementModel(
        id: map['id'] as int?,
        name: map['name']! as String,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        containerTankTypes: const IterableConverter<ContainerTankTypeModel,
            Map<String, Object?>>(
          containerTankTypeConverter,
        ).fromJson(
          (map['container_tank_types'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        services: const IterableConverter<ServiceModel, Map<String, Object?>>(
          serviceConverter,
        ).fromJson(
          (map['services'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory MeasurementModel.fromJson(final String source) =>
      MeasurementModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final MeasurementModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is MeasurementModel && other.id == id && other.name == name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() =>
      'MeasurementModel(id: $id, name: $name, createdAt: $createdAt, '
      'updatedAt: $updatedAt, containerTankTypes: $containerTankTypes, '
      'services: $services)';
}

/// The model of a PriceModel.
@sealed
@immutable
class PriceModel implements Comparable<PriceModel> {
  /// The model of a PriceModel.
  const PriceModel({
    required this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deals = const Iterable<DealModel>.empty(),
    this.bonuses = const Iterable<BonusPriceModel>.empty(),
    this.services = const Iterable<ServicePriceModel>.empty(),
  });

  /// The `id` property of this [PriceModel].
  final int? id;

  /// The `name` property of this [PriceModel].
  final String name;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `deals` property of this [PriceModel].
  final Iterable<DealModel> deals;

  /// The `bonuses` property of this [PriceModel].
  final Iterable<BonusPriceModel> bonuses;

  /// The `services` property of this [PriceModel].
  final Iterable<ServicePriceModel> services;

  /// Return the copy of this model.
  PriceModel copyWith({
    final int? id,
    final String? name,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Iterable<DealModel>? deals,
    final Iterable<BonusPriceModel>? bonuses,
    final Iterable<ServicePriceModel>? services,
  }) =>
      PriceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deals: deals ?? this.deals,
        bonuses: bonuses ?? this.bonuses,
        services: services ?? this.services,
      );

  /// Return the copy of this model with nullable fields.
  PriceModel copyWithNull({
    final bool id = false,
    final bool createdAt = false,
    final bool updatedAt = false,
  }) =>
      PriceModel(
        id: id ? null : this.id,
        name: name,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        deals: deals,
        bonuses: bonuses,
        services: services,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (id != null) 'id': id,
        'name': name,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        'deals': const IterableConverter<DealModel, Map<String, Object?>>(
          dealConverter,
        ).toJson(deals).toList(growable: false),
        'bonuses':
            const IterableConverter<BonusPriceModel, Map<String, Object?>>(
          bonusPriceConverter,
        ).toJson(bonuses).toList(growable: false),
        'services':
            const IterableConverter<ServicePriceModel, Map<String, Object?>>(
          servicePriceConverter,
        ).toJson(services).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory PriceModel.fromMap(final Map<String, Object?> map) => PriceModel(
        id: map['id'] as int?,
        name: map['name']! as String,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        deals: const IterableConverter<DealModel, Map<String, Object?>>(
          dealConverter,
        ).fromJson(
          (map['deals'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        bonuses: const IterableConverter<BonusPriceModel, Map<String, Object?>>(
          bonusPriceConverter,
        ).fromJson(
          (map['bonuses'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        services:
            const IterableConverter<ServicePriceModel, Map<String, Object?>>(
          servicePriceConverter,
        ).fromJson(
          (map['services'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory PriceModel.fromJson(final String source) =>
      PriceModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final PriceModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is PriceModel && other.id == id && other.name == name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() =>
      'PriceModel(id: $id, name: $name, createdAt: $createdAt, '
      'updatedAt: $updatedAt, deals: $deals, bonuses: $bonuses, '
      'services: $services)';
}

/// The model of a LocaleModel.
@sealed
@immutable
class LocaleModel implements Comparable<LocaleModel> {
  /// The model of a LocaleModel.
  const LocaleModel({
    required this.localeAlpha2,
    this.createdAt,
    this.updatedAt,
    this.texts = const Iterable<LocaleTextModel>.empty(),
  });

  /// The `locale_alpha_2` property of this [LocaleModel].
  final String localeAlpha2;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `texts` property of this [LocaleModel].
  final Iterable<LocaleTextModel> texts;

  /// Return the copy of this model.
  LocaleModel copyWith({
    final String? localeAlpha2,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Iterable<LocaleTextModel>? texts,
  }) =>
      LocaleModel(
        localeAlpha2: localeAlpha2 ?? this.localeAlpha2,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        texts: texts ?? this.texts,
      );

  /// Return the copy of this model with nullable fields.
  LocaleModel copyWithNull({
    final bool createdAt = false,
    final bool updatedAt = false,
  }) =>
      LocaleModel(
        localeAlpha2: localeAlpha2,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        texts: texts,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        'locale_alpha_2': localeAlpha2,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        'texts': const IterableConverter<LocaleTextModel, Map<String, Object?>>(
          localeTextConverter,
        ).toJson(texts).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory LocaleModel.fromMap(final Map<String, Object?> map) => LocaleModel(
        localeAlpha2: map['locale_alpha_2']! as String,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        texts: const IterableConverter<LocaleTextModel, Map<String, Object?>>(
          localeTextConverter,
        ).fromJson(
          (map['texts'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory LocaleModel.fromJson(final String source) =>
      LocaleModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final LocaleModel other) =>
      localeAlpha2.compareTo(other.localeAlpha2);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is LocaleModel && other.localeAlpha2 == localeAlpha2;

  @override
  int get hashCode => localeAlpha2.hashCode;

  @override
  String toString() =>
      'LocaleModel(localeAlpha2: $localeAlpha2, createdAt: $createdAt, '
      'updatedAt: $updatedAt, texts: $texts)';
}

/// The model of a TextModel.
@sealed
@immutable
class TextModel implements Comparable<TextModel> {
  /// The model of a TextModel.
  const TextModel({
    required this.key,
    required this.text,
    this.createdAt,
    this.updatedAt,
    this.locales = const Iterable<LocaleTextModel>.empty(),
  });

  /// The `key` property of this [TextModel].
  final String key;

  /// The `text` property of this [TextModel].
  final String text;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `locales` property of this [TextModel].
  final Iterable<LocaleTextModel> locales;

  /// Return the copy of this model.
  TextModel copyWith({
    final String? key,
    final String? text,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Iterable<LocaleTextModel>? locales,
  }) =>
      TextModel(
        key: key ?? this.key,
        text: text ?? this.text,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        locales: locales ?? this.locales,
      );

  /// Return the copy of this model with nullable fields.
  TextModel copyWithNull({
    final bool createdAt = false,
    final bool updatedAt = false,
  }) =>
      TextModel(
        key: key,
        text: text,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        locales: locales,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        'key': key,
        'text': text,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        'locales':
            const IterableConverter<LocaleTextModel, Map<String, Object?>>(
          localeTextConverter,
        ).toJson(locales).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory TextModel.fromMap(final Map<String, Object?> map) => TextModel(
        key: map['key']! as String,
        text: map['text']! as String,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        locales: const IterableConverter<LocaleTextModel, Map<String, Object?>>(
          localeTextConverter,
        ).fromJson(
          (map['locales'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory TextModel.fromJson(final String source) =>
      TextModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final TextModel other) => key.compareTo(other.key);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is TextModel && other.key == key && other.text == text;

  @override
  int get hashCode => key.hashCode ^ text.hashCode;

  @override
  String toString() =>
      'TextModel(key: $key, text: $text, createdAt: $createdAt, '
      'updatedAt: $updatedAt, locales: $locales)';
}

/// The model of a LocaleTextModel.
@sealed
@immutable
class LocaleTextModel implements Comparable<LocaleTextModel> {
  /// The model of a LocaleTextModel.
  const LocaleTextModel({
    required this.fallbackText,
    this.key,
    this.localeAlpha2,
    this.createdAt,
    this.updatedAt,
    this.locale,
    this.text,
  });

  /// The `key` property of this [LocaleTextModel].
  final String? key;

  /// The `locale_alpha_2` property of this [LocaleTextModel].
  final String? localeAlpha2;

  /// The `fallback_text` property of this [LocaleTextModel].
  final String fallbackText;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `locale` property of this [LocaleTextModel].
  final LocaleModel? locale;

  /// The `text` property of this [LocaleTextModel].
  final TextModel? text;

  /// Return the copy of this model.
  LocaleTextModel copyWith({
    final String? key,
    final String? localeAlpha2,
    final String? fallbackText,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final LocaleModel? locale,
    final TextModel? text,
  }) =>
      LocaleTextModel(
        key: key ?? this.key,
        localeAlpha2: localeAlpha2 ?? this.localeAlpha2,
        fallbackText: fallbackText ?? this.fallbackText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        locale: locale ?? this.locale,
        text: text ?? this.text,
      );

  /// Return the copy of this model with nullable fields.
  LocaleTextModel copyWithNull({
    final bool key = false,
    final bool localeAlpha2 = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool locale = false,
    final bool text = false,
  }) =>
      LocaleTextModel(
        key: key ? null : this.key,
        localeAlpha2: localeAlpha2 ? null : this.localeAlpha2,
        fallbackText: fallbackText,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        locale: locale ? null : this.locale,
        text: text ? null : this.text,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (key != null) 'key': key,
        if (localeAlpha2 != null) 'locale_alpha_2': localeAlpha2,
        'fallback_text': fallbackText,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (locale != null) 'locale': optionalLocaleConverter.toJson(locale),
        if (text != null) 'text': optionalTextConverter.toJson(text),
      };

  /// Convert the map with string keys to this model.
  factory LocaleTextModel.fromMap(final Map<String, Object?> map) =>
      LocaleTextModel(
        key: map['key'] as String?,
        localeAlpha2: map['locale_alpha_2'] as String?,
        fallbackText: map['fallback_text']! as String,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        locale: optionalLocaleConverter
            .fromJson(map['locale'] as Map<String, Object?>?),
        text: optionalTextConverter
            .fromJson(map['text'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory LocaleTextModel.fromJson(final String source) =>
      LocaleTextModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final LocaleTextModel other) {
    int value;
    if ((value = key != null && other.key != null
            ? key!.compareTo(other.key!)
            : 0) !=
        0) {
    } else if ((value = localeAlpha2 != null && other.localeAlpha2 != null
            ? localeAlpha2!.compareTo(other.localeAlpha2!)
            : 0) !=
        0) {}
    return value;
  }

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is LocaleTextModel &&
          other.key == key &&
          other.localeAlpha2 == localeAlpha2 &&
          other.fallbackText == fallbackText;

  @override
  int get hashCode =>
      key.hashCode ^ localeAlpha2.hashCode ^ fallbackText.hashCode;

  @override
  String toString() =>
      'LocaleTextModel(key: $key, localeAlpha2: $localeAlpha2, '
      'fallbackText: $fallbackText, createdAt: $createdAt, '
      'updatedAt: $updatedAt, locale: $locale, text: $text)';
}

/// The model of a SettingsModel.
@sealed
@immutable
class SettingsModel {
  /// The model of a SettingsModel.
  const SettingsModel({
    this.id = true,
    this.fallbackLocaleAlpha2 = 'UA',
    this.createdAt,
    this.updatedAt,
  });

  /// The `id` property of this [SettingsModel].
  final bool id;

  /// The `fallback_locale_alpha_2` property of this [SettingsModel].
  final String? fallbackLocaleAlpha2;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// Return the copy of this model.
  SettingsModel copyWith({
    final bool? id,
    final String? fallbackLocaleAlpha2,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) =>
      SettingsModel(
        id: id ?? this.id,
        fallbackLocaleAlpha2: fallbackLocaleAlpha2 ?? this.fallbackLocaleAlpha2,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  /// Return the copy of this model with nullable fields.
  SettingsModel copyWithNull({
    final bool fallbackLocaleAlpha2 = false,
    final bool createdAt = false,
    final bool updatedAt = false,
  }) =>
      SettingsModel(
        id: id,
        fallbackLocaleAlpha2:
            fallbackLocaleAlpha2 ? null : this.fallbackLocaleAlpha2,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        'id': id,
        if (fallbackLocaleAlpha2 != null)
          'fallback_locale_alpha_2': fallbackLocaleAlpha2,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
      };

  /// Convert the map with string keys to this model.
  factory SettingsModel.fromMap(final Map<String, Object?> map) =>
      SettingsModel(
        id: map['id']! as bool,
        fallbackLocaleAlpha2: map['fallback_locale_alpha_2'] as String?,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory SettingsModel.fromJson(final String source) =>
      SettingsModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is SettingsModel &&
          other.id == id &&
          other.fallbackLocaleAlpha2 == fallbackLocaleAlpha2;

  @override
  int get hashCode => id.hashCode ^ fallbackLocaleAlpha2.hashCode;

  @override
  String toString() =>
      'SettingsModel(id: $id, fallbackLocaleAlpha2: $fallbackLocaleAlpha2, '
      'createdAt: $createdAt, updatedAt: $updatedAt)';
}

/// The model of a UserModel.
@sealed
@immutable
class UserModel implements Comparable<UserModel> {
  /// The model of a UserModel.
  const UserModel({
    required this.firstName,
    required this.phoneNumber,
    this.id,
    this.lastName,
    this.email,
    this.birthday,
    this.createdAt,
    this.updatedAt,
    this.deals = const Iterable<DealModel>.empty(),
    this.activeDeal,
    this.company,
    this.person,
    this.group,
    this.bonuses = const Iterable<BonusModel>.empty(),
    this.containers = const Iterable<ContainerModel>.empty(),
    this.openings = const Iterable<ContainerTankOpeningModel>.empty(),
    this.clearings = const Iterable<ContainerTankClearingModel>.empty(),
  });

  /// The `id` property of this [UserModel].
  final int? id;

  /// The `first_name` property of this [UserModel].
  final String firstName;

  /// The `last_name` property of this [UserModel].
  final String? lastName;

  /// The `phone_number` property of this [UserModel].
  final int phoneNumber;

  /// The `email` property of this [UserModel].
  final String? email;

  /// The `birthday` property of this [UserModel].
  final DateTime? birthday;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `deals` property of this [UserModel].
  final Iterable<DealModel> deals;

  /// The `active_deal` property of this [UserModel].
  final DealModel? activeDeal;

  /// The `company` property of this [UserModel].
  final CompanyModel? company;

  /// The `person` property of this [UserModel].
  final PersonModel? person;

  /// The `group` property of this [UserModel].
  final GroupModel? group;

  /// The `bonuses` property of this [UserModel].
  final Iterable<BonusModel> bonuses;

  /// The `containers` property of this [UserModel].
  final Iterable<ContainerModel> containers;

  /// The `openings` property of this [UserModel].
  final Iterable<ContainerTankOpeningModel> openings;

  /// The `clearings` property of this [UserModel].
  final Iterable<ContainerTankClearingModel> clearings;

  /// Return the copy of this model.
  UserModel copyWith({
    final int? id,
    final String? firstName,
    final String? lastName,
    final int? phoneNumber,
    final String? email,
    final DateTime? birthday,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Iterable<DealModel>? deals,
    final DealModel? activeDeal,
    final CompanyModel? company,
    final PersonModel? person,
    final GroupModel? group,
    final Iterable<BonusModel>? bonuses,
    final Iterable<ContainerModel>? containers,
    final Iterable<ContainerTankOpeningModel>? openings,
    final Iterable<ContainerTankClearingModel>? clearings,
  }) =>
      UserModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deals: deals ?? this.deals,
        activeDeal: activeDeal ?? this.activeDeal,
        company: company ?? this.company,
        person: person ?? this.person,
        group: group ?? this.group,
        bonuses: bonuses ?? this.bonuses,
        containers: containers ?? this.containers,
        openings: openings ?? this.openings,
        clearings: clearings ?? this.clearings,
      );

  /// Return the copy of this model with nullable fields.
  UserModel copyWithNull({
    final bool id = false,
    final bool lastName = false,
    final bool email = false,
    final bool birthday = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool activeDeal = false,
    final bool company = false,
    final bool person = false,
    final bool group = false,
  }) =>
      UserModel(
        id: id ? null : this.id,
        firstName: firstName,
        lastName: lastName ? null : this.lastName,
        phoneNumber: phoneNumber,
        email: email ? null : this.email,
        birthday: birthday ? null : this.birthday,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        deals: deals,
        activeDeal: activeDeal ? null : this.activeDeal,
        company: company ? null : this.company,
        person: person ? null : this.person,
        group: group ? null : this.group,
        bonuses: bonuses,
        containers: containers,
        openings: openings,
        clearings: clearings,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (id != null) 'id': id,
        'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        'phone_number': phoneNumber,
        if (email != null) 'email': email,
        if (birthday != null)
          'birthday': optionalDateTimeConverter.toJson(birthday),
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        'deals': const IterableConverter<DealModel, Map<String, Object?>>(
          dealConverter,
        ).toJson(deals).toList(growable: false),
        if (activeDeal != null)
          'active_deal': optionalDealConverter.toJson(activeDeal),
        if (company != null)
          'company': optionalCompanyConverter.toJson(company),
        if (person != null) 'person': optionalPersonConverter.toJson(person),
        if (group != null) 'group': optionalGroupConverter.toJson(group),
        'bonuses': const IterableConverter<BonusModel, Map<String, Object?>>(
          bonusConverter,
        ).toJson(bonuses).toList(growable: false),
        'containers':
            const IterableConverter<ContainerModel, Map<String, Object?>>(
          containerConverter,
        ).toJson(containers).toList(growable: false),
        'openings': const IterableConverter<ContainerTankOpeningModel,
            Map<String, Object?>>(
          containerTankOpeningConverter,
        ).toJson(openings).toList(growable: false),
        'clearings': const IterableConverter<ContainerTankClearingModel,
            Map<String, Object?>>(
          containerTankClearingConverter,
        ).toJson(clearings).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory UserModel.fromMap(final Map<String, Object?> map) => UserModel(
        id: map['id'] as int?,
        firstName: map['first_name']! as String,
        lastName: map['last_name'] as String?,
        phoneNumber: map['phone_number']! as int,
        email: map['email'] as String?,
        birthday:
            optionalDateTimeConverter.fromJson(map['birthday'] as String?),
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        deals: const IterableConverter<DealModel, Map<String, Object?>>(
          dealConverter,
        ).fromJson(
          (map['deals'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        activeDeal: optionalDealConverter
            .fromJson(map['active_deal'] as Map<String, Object?>?),
        company: optionalCompanyConverter
            .fromJson(map['company'] as Map<String, Object?>?),
        person: optionalPersonConverter
            .fromJson(map['person'] as Map<String, Object?>?),
        group: optionalGroupConverter
            .fromJson(map['group'] as Map<String, Object?>?),
        bonuses: const IterableConverter<BonusModel, Map<String, Object?>>(
          bonusConverter,
        ).fromJson(
          (map['bonuses'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        containers:
            const IterableConverter<ContainerModel, Map<String, Object?>>(
          containerConverter,
        ).fromJson(
          (map['containers'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        openings: const IterableConverter<ContainerTankOpeningModel,
            Map<String, Object?>>(
          containerTankOpeningConverter,
        ).fromJson(
          (map['openings'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        clearings: const IterableConverter<ContainerTankClearingModel,
            Map<String, Object?>>(
          containerTankClearingConverter,
        ).fromJson(
          (map['clearings'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory UserModel.fromJson(final String source) =>
      UserModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final UserModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is UserModel &&
          other.id == id &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.phoneNumber == phoneNumber &&
          other.email == email &&
          other.birthday == birthday;

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      birthday.hashCode;

  @override
  String toString() =>
      'UserModel(id: $id, firstName: $firstName, lastName: $lastName, '
      'phoneNumber: $phoneNumber, email: $email, birthday: $birthday, '
      'createdAt: $createdAt, updatedAt: $updatedAt, deals: $deals, '
      'activeDeal: $activeDeal, company: $company, person: $person, '
      'group: $group, bonuses: $bonuses, containers: $containers, '
      'openings: $openings, clearings: $clearings)';
}

/// The model of a CompanyModel.
@sealed
@immutable
class CompanyModel implements Comparable<CompanyModel> {
  /// The model of a CompanyModel.
  const CompanyModel({
    required this.bankAccountNumber,
    this.registryNumber,
    this.taxNumber,
    this.addressId,
    this.realAddressId,
    this.bankCode,
    this.bank,
    this.address,
    this.realAddress,
    this.contacts = const Iterable<CompanyContactModel>.empty(),
    this.user,
  });

  /// The `registry_number` property of this [CompanyModel].
  final int? registryNumber;

  /// The `tax_number` property of this [CompanyModel].
  final int? taxNumber;

  /// The `address_id` property of this [CompanyModel].
  final int? addressId;

  /// The `real_address_id` property of this [CompanyModel].
  final int? realAddressId;

  /// The `bank_code` property of this [CompanyModel].
  final int? bankCode;

  /// The `bank_account_number` property of this [CompanyModel].
  final String bankAccountNumber;

  /// The `bank` property of this [CompanyModel].
  final BankModel? bank;

  /// The `address` property of this [CompanyModel].
  final AddressModel? address;

  /// The `real_address` property of this [CompanyModel].
  final AddressModel? realAddress;

  /// The `contacts` property of this [CompanyModel].
  final Iterable<CompanyContactModel> contacts;

  /// The `user` property of this [CompanyModel].
  final UserModel? user;

  /// Return the copy of this model.
  CompanyModel copyWith({
    final int? registryNumber,
    final int? taxNumber,
    final int? addressId,
    final int? realAddressId,
    final int? bankCode,
    final String? bankAccountNumber,
    final BankModel? bank,
    final AddressModel? address,
    final AddressModel? realAddress,
    final Iterable<CompanyContactModel>? contacts,
    final UserModel? user,
  }) =>
      CompanyModel(
        registryNumber: registryNumber ?? this.registryNumber,
        taxNumber: taxNumber ?? this.taxNumber,
        addressId: addressId ?? this.addressId,
        realAddressId: realAddressId ?? this.realAddressId,
        bankCode: bankCode ?? this.bankCode,
        bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
        bank: bank ?? this.bank,
        address: address ?? this.address,
        realAddress: realAddress ?? this.realAddress,
        contacts: contacts ?? this.contacts,
        user: user ?? this.user,
      );

  /// Return the copy of this model with nullable fields.
  CompanyModel copyWithNull({
    final bool registryNumber = false,
    final bool taxNumber = false,
    final bool addressId = false,
    final bool realAddressId = false,
    final bool bankCode = false,
    final bool bank = false,
    final bool address = false,
    final bool realAddress = false,
    final bool user = false,
  }) =>
      CompanyModel(
        registryNumber: registryNumber ? null : this.registryNumber,
        taxNumber: taxNumber ? null : this.taxNumber,
        addressId: addressId ? null : this.addressId,
        realAddressId: realAddressId ? null : this.realAddressId,
        bankCode: bankCode ? null : this.bankCode,
        bankAccountNumber: bankAccountNumber,
        bank: bank ? null : this.bank,
        address: address ? null : this.address,
        realAddress: realAddress ? null : this.realAddress,
        contacts: contacts,
        user: user ? null : this.user,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (registryNumber != null) 'registry_number': registryNumber,
        if (taxNumber != null) 'tax_number': taxNumber,
        if (addressId != null) 'address_id': addressId,
        if (realAddressId != null) 'real_address_id': realAddressId,
        if (bankCode != null) 'bank_code': bankCode,
        'bank_account_number': bankAccountNumber,
        if (bank != null) 'bank': optionalBankConverter.toJson(bank),
        if (address != null)
          'address': optionalAddressConverter.toJson(address),
        if (realAddress != null)
          'real_address': optionalAddressConverter.toJson(realAddress),
        'contacts':
            const IterableConverter<CompanyContactModel, Map<String, Object?>>(
          companyContactConverter,
        ).toJson(contacts).toList(growable: false),
        if (user != null) 'user': optionalUserConverter.toJson(user),
      };

  /// Convert the map with string keys to this model.
  factory CompanyModel.fromMap(final Map<String, Object?> map) => CompanyModel(
        registryNumber: map['registry_number'] as int?,
        taxNumber: map['tax_number'] as int?,
        addressId: map['address_id'] as int?,
        realAddressId: map['real_address_id'] as int?,
        bankCode: map['bank_code'] as int?,
        bankAccountNumber: map['bank_account_number']! as String,
        bank: optionalBankConverter
            .fromJson(map['bank'] as Map<String, Object?>?),
        address: optionalAddressConverter
            .fromJson(map['address'] as Map<String, Object?>?),
        realAddress: optionalAddressConverter
            .fromJson(map['real_address'] as Map<String, Object?>?),
        contacts:
            const IterableConverter<CompanyContactModel, Map<String, Object?>>(
          companyContactConverter,
        ).fromJson(
          (map['contacts'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        user: optionalUserConverter
            .fromJson(map['user'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory CompanyModel.fromJson(final String source) =>
      CompanyModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final CompanyModel other) =>
      registryNumber != null && other.registryNumber != null
          ? registryNumber!.compareTo(other.registryNumber!)
          : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is CompanyModel &&
          other.registryNumber == registryNumber &&
          other.taxNumber == taxNumber &&
          other.addressId == addressId &&
          other.realAddressId == realAddressId &&
          other.bankCode == bankCode &&
          other.bankAccountNumber == bankAccountNumber;

  @override
  int get hashCode =>
      registryNumber.hashCode ^
      taxNumber.hashCode ^
      addressId.hashCode ^
      realAddressId.hashCode ^
      bankCode.hashCode ^
      bankAccountNumber.hashCode;

  @override
  String toString() =>
      'CompanyModel(registryNumber: $registryNumber, taxNumber: $taxNumber, '
      'addressId: $addressId, realAddressId: $realAddressId, '
      'bankCode: $bankCode, bankAccountNumber: $bankAccountNumber, '
      'bank: $bank, address: $address, realAddress: $realAddress, '
      'contacts: $contacts, user: $user)';
}

/// The model of a CompanyContactModel.
@sealed
@immutable
class CompanyContactModel implements Comparable<CompanyContactModel> {
  /// The model of a CompanyContactModel.
  const CompanyContactModel({
    required this.firstName,
    required this.phoneNumber,
    this.companyRegistryNumber,
    this.id,
    this.type = CompanyContactType.director,
    this.lastName,
    this.email,
    this.birthday,
    this.company,
  });

  /// The `company_registry_number` property of this [CompanyContactModel].
  final int? companyRegistryNumber;

  /// The `id` property of this [CompanyContactModel].
  final int? id;

  /// The `type` property of this [CompanyContactModel].
  final CompanyContactType type;

  /// The `first_name` property of this [CompanyContactModel].
  final String firstName;

  /// The `last_name` property of this [CompanyContactModel].
  final String? lastName;

  /// The `phone_number` property of this [CompanyContactModel].
  final int phoneNumber;

  /// The `email` property of this [CompanyContactModel].
  final String? email;

  /// The `birthday` property of this [CompanyContactModel].
  final DateTime? birthday;

  /// The `company` property of this [CompanyContactModel].
  final CompanyModel? company;

  /// Return the copy of this model.
  CompanyContactModel copyWith({
    final int? companyRegistryNumber,
    final int? id,
    final CompanyContactType? type,
    final String? firstName,
    final String? lastName,
    final int? phoneNumber,
    final String? email,
    final DateTime? birthday,
    final CompanyModel? company,
  }) =>
      CompanyContactModel(
        companyRegistryNumber:
            companyRegistryNumber ?? this.companyRegistryNumber,
        id: id ?? this.id,
        type: type ?? this.type,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        company: company ?? this.company,
      );

  /// Return the copy of this model with nullable fields.
  CompanyContactModel copyWithNull({
    final bool companyRegistryNumber = false,
    final bool id = false,
    final bool lastName = false,
    final bool email = false,
    final bool birthday = false,
    final bool company = false,
  }) =>
      CompanyContactModel(
        companyRegistryNumber:
            companyRegistryNumber ? null : this.companyRegistryNumber,
        id: id ? null : this.id,
        type: type,
        firstName: firstName,
        lastName: lastName ? null : this.lastName,
        phoneNumber: phoneNumber,
        email: email ? null : this.email,
        birthday: birthday ? null : this.birthday,
        company: company ? null : this.company,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (companyRegistryNumber != null)
          'company_registry_number': companyRegistryNumber,
        if (id != null) 'id': id,
        'type': const EnumConverter<CompanyContactType>(
          CompanyContactType.values,
        ).toJson(type),
        'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        'phone_number': phoneNumber,
        if (email != null) 'email': email,
        if (birthday != null)
          'birthday': optionalDateTimeConverter.toJson(birthday),
        if (company != null)
          'company': optionalCompanyConverter.toJson(company),
      };

  /// Convert the map with string keys to this model.
  factory CompanyContactModel.fromMap(final Map<String, Object?> map) =>
      CompanyContactModel(
        companyRegistryNumber: map['company_registry_number'] as int?,
        id: map['id'] as int?,
        type: const EnumConverter<CompanyContactType>(
          CompanyContactType.values,
        ).fromJson(map['type']! as String),
        firstName: map['first_name']! as String,
        lastName: map['last_name'] as String?,
        phoneNumber: map['phone_number']! as int,
        email: map['email'] as String?,
        birthday:
            optionalDateTimeConverter.fromJson(map['birthday'] as String?),
        company: optionalCompanyConverter
            .fromJson(map['company'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory CompanyContactModel.fromJson(final String source) =>
      CompanyContactModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final CompanyContactModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is CompanyContactModel &&
          other.companyRegistryNumber == companyRegistryNumber &&
          other.id == id &&
          other.type == type &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.phoneNumber == phoneNumber &&
          other.email == email &&
          other.birthday == birthday;

  @override
  int get hashCode =>
      companyRegistryNumber.hashCode ^
      id.hashCode ^
      type.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      birthday.hashCode;

  @override
  String toString() =>
      'CompanyContactModel(companyRegistryNumber: $companyRegistryNumber, '
      'id: $id, type: $type, firstName: $firstName, lastName: $lastName, '
      'phoneNumber: $phoneNumber, email: $email, birthday: $birthday, '
      'company: $company)';
}

/// The model of a DealModel.
@sealed
@immutable
class DealModel implements Comparable<DealModel> {
  /// The model of a DealModel.
  const DealModel({
    required this.activeTill,
    this.ownerId,
    this.id,
    this.priceId,
    this.paymentType = false,
    this.refferalDiscount = 0.0,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.price,
    this.services = const Iterable<DealServiceModel>.empty(),
  });

  /// The `owner_id` property of this [DealModel].
  final int? ownerId;

  /// The `id` property of this [DealModel].
  final int? id;

  /// The `price_id` property of this [DealModel].
  final int? priceId;

  /// The `payment_type` property of this [DealModel].
  final bool paymentType;

  /// The `refferal_discount` property of this [DealModel].
  final double refferalDiscount;

  /// The `active_till` property of this [DealModel].
  final DateTime activeTill;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `owner` property of this [DealModel].
  final UserModel? owner;

  /// The `price` property of this [DealModel].
  final PriceModel? price;

  /// The `services` property of this [DealModel].
  final Iterable<DealServiceModel> services;

  /// Return the copy of this model.
  DealModel copyWith({
    final int? ownerId,
    final int? id,
    final int? priceId,
    final bool? paymentType,
    final double? refferalDiscount,
    final DateTime? activeTill,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final UserModel? owner,
    final PriceModel? price,
    final Iterable<DealServiceModel>? services,
  }) =>
      DealModel(
        ownerId: ownerId ?? this.ownerId,
        id: id ?? this.id,
        priceId: priceId ?? this.priceId,
        paymentType: paymentType ?? this.paymentType,
        refferalDiscount: refferalDiscount ?? this.refferalDiscount,
        activeTill: activeTill ?? this.activeTill,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        owner: owner ?? this.owner,
        price: price ?? this.price,
        services: services ?? this.services,
      );

  /// Return the copy of this model with nullable fields.
  DealModel copyWithNull({
    final bool ownerId = false,
    final bool id = false,
    final bool priceId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool owner = false,
    final bool price = false,
  }) =>
      DealModel(
        ownerId: ownerId ? null : this.ownerId,
        id: id ? null : this.id,
        priceId: priceId ? null : this.priceId,
        paymentType: paymentType,
        refferalDiscount: refferalDiscount,
        activeTill: activeTill,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        owner: owner ? null : this.owner,
        price: price ? null : this.price,
        services: services,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (ownerId != null) 'owner_id': ownerId,
        if (id != null) 'id': id,
        if (priceId != null) 'price_id': priceId,
        'payment_type': paymentType,
        'refferal_discount': refferalDiscount,
        'active_till': dateTimeConverter.toJson(activeTill),
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (owner != null) 'owner': optionalUserConverter.toJson(owner),
        if (price != null) 'price': optionalPriceConverter.toJson(price),
        'services':
            const IterableConverter<DealServiceModel, Map<String, Object?>>(
          dealServiceConverter,
        ).toJson(services).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory DealModel.fromMap(final Map<String, Object?> map) => DealModel(
        ownerId: map['owner_id'] as int?,
        id: map['id'] as int?,
        priceId: map['price_id'] as int?,
        paymentType: map['payment_type']! as bool,
        refferalDiscount: map['refferal_discount']! as double,
        activeTill: dateTimeConverter.fromJson(map['active_till']! as String),
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        owner: optionalUserConverter
            .fromJson(map['owner'] as Map<String, Object?>?),
        price: optionalPriceConverter
            .fromJson(map['price'] as Map<String, Object?>?),
        services:
            const IterableConverter<DealServiceModel, Map<String, Object?>>(
          dealServiceConverter,
        ).fromJson(
          (map['services'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory DealModel.fromJson(final String source) =>
      DealModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final DealModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is DealModel &&
          other.ownerId == ownerId &&
          other.id == id &&
          other.priceId == priceId &&
          other.paymentType == paymentType &&
          other.refferalDiscount == refferalDiscount &&
          other.activeTill == activeTill;

  @override
  int get hashCode =>
      ownerId.hashCode ^
      id.hashCode ^
      priceId.hashCode ^
      paymentType.hashCode ^
      refferalDiscount.hashCode ^
      activeTill.hashCode;

  @override
  String toString() =>
      'DealModel(ownerId: $ownerId, id: $id, priceId: $priceId, '
      'paymentType: $paymentType, refferalDiscount: $refferalDiscount, '
      'activeTill: $activeTill, createdAt: $createdAt, updatedAt: $updatedAt, '
      'owner: $owner, price: $price, services: $services)';
}

/// The model of a ServiceModel.
@sealed
@immutable
class ServiceModel implements Comparable<ServiceModel> {
  /// The model of a ServiceModel.
  const ServiceModel({
    required this.name,
    required this.description,
    this.id,
    this.measurementId,
    this.measurement,
    this.prices = const Iterable<ServicePriceModel>.empty(),
    this.deals = const Iterable<DealServiceModel>.empty(),
  });

  /// The `id` property of this [ServiceModel].
  final int? id;

  /// The `name` property of this [ServiceModel].
  final String name;

  /// The `description` property of this [ServiceModel].
  final String description;

  /// The `measurement_id` property of this [ServiceModel].
  final int? measurementId;

  /// The `measurement` property of this [ServiceModel].
  final MeasurementModel? measurement;

  /// The `prices` property of this [ServiceModel].
  final Iterable<ServicePriceModel> prices;

  /// The `deals` property of this [ServiceModel].
  final Iterable<DealServiceModel> deals;

  /// Return the copy of this model.
  ServiceModel copyWith({
    final int? id,
    final String? name,
    final String? description,
    final int? measurementId,
    final MeasurementModel? measurement,
    final Iterable<ServicePriceModel>? prices,
    final Iterable<DealServiceModel>? deals,
  }) =>
      ServiceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        measurementId: measurementId ?? this.measurementId,
        measurement: measurement ?? this.measurement,
        prices: prices ?? this.prices,
        deals: deals ?? this.deals,
      );

  /// Return the copy of this model with nullable fields.
  ServiceModel copyWithNull({
    final bool id = false,
    final bool measurementId = false,
    final bool measurement = false,
  }) =>
      ServiceModel(
        id: id ? null : this.id,
        name: name,
        description: description,
        measurementId: measurementId ? null : this.measurementId,
        measurement: measurement ? null : this.measurement,
        prices: prices,
        deals: deals,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (id != null) 'id': id,
        'name': name,
        'description': description,
        if (measurementId != null) 'measurement_id': measurementId,
        if (measurement != null)
          'measurement': optionalMeasurementConverter.toJson(measurement),
        'prices':
            const IterableConverter<ServicePriceModel, Map<String, Object?>>(
          servicePriceConverter,
        ).toJson(prices).toList(growable: false),
        'deals':
            const IterableConverter<DealServiceModel, Map<String, Object?>>(
          dealServiceConverter,
        ).toJson(deals).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory ServiceModel.fromMap(final Map<String, Object?> map) => ServiceModel(
        id: map['id'] as int?,
        name: map['name']! as String,
        description: map['description']! as String,
        measurementId: map['measurement_id'] as int?,
        measurement: optionalMeasurementConverter
            .fromJson(map['measurement'] as Map<String, Object?>?),
        prices:
            const IterableConverter<ServicePriceModel, Map<String, Object?>>(
          servicePriceConverter,
        ).fromJson(
          (map['prices'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        deals: const IterableConverter<DealServiceModel, Map<String, Object?>>(
          dealServiceConverter,
        ).fromJson(
          (map['deals'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ServiceModel.fromJson(final String source) =>
      ServiceModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final ServiceModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ServiceModel &&
          other.id == id &&
          other.name == name &&
          other.description == description &&
          other.measurementId == measurementId;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      measurementId.hashCode;

  @override
  String toString() =>
      'ServiceModel(id: $id, name: $name, description: $description, '
      'measurementId: $measurementId, measurement: $measurement, '
      'prices: $prices, deals: $deals)';
}

/// The model of a DealServiceModel.
@sealed
@immutable
class DealServiceModel implements Comparable<DealServiceModel> {
  /// The model of a DealServiceModel.
  const DealServiceModel({
    required this.amount,
    this.dealId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.deal,
    this.service,
    this.openings = const Iterable<ContainerTankOpeningModel>.empty(),
  });

  /// The `deal_id` property of this [DealServiceModel].
  final int? dealId;

  /// The `service_id` property of this [DealServiceModel].
  final int? serviceId;

  /// The `amount` property of this [DealServiceModel].
  final double amount;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `deal` property of this [DealServiceModel].
  final DealModel? deal;

  /// The `service` property of this [DealServiceModel].
  final ServiceModel? service;

  /// The `openings` property of this [DealServiceModel].
  final Iterable<ContainerTankOpeningModel> openings;

  /// Return the copy of this model.
  DealServiceModel copyWith({
    final int? dealId,
    final int? serviceId,
    final double? amount,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DealModel? deal,
    final ServiceModel? service,
    final Iterable<ContainerTankOpeningModel>? openings,
  }) =>
      DealServiceModel(
        dealId: dealId ?? this.dealId,
        serviceId: serviceId ?? this.serviceId,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deal: deal ?? this.deal,
        service: service ?? this.service,
        openings: openings ?? this.openings,
      );

  /// Return the copy of this model with nullable fields.
  DealServiceModel copyWithNull({
    final bool dealId = false,
    final bool serviceId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool deal = false,
    final bool service = false,
  }) =>
      DealServiceModel(
        dealId: dealId ? null : this.dealId,
        serviceId: serviceId ? null : this.serviceId,
        amount: amount,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        deal: deal ? null : this.deal,
        service: service ? null : this.service,
        openings: openings,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (dealId != null) 'deal_id': dealId,
        if (serviceId != null) 'service_id': serviceId,
        'amount': amount,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (deal != null) 'deal': optionalDealConverter.toJson(deal),
        if (service != null)
          'service': optionalServiceConverter.toJson(service),
        'openings': const IterableConverter<ContainerTankOpeningModel,
            Map<String, Object?>>(
          containerTankOpeningConverter,
        ).toJson(openings).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory DealServiceModel.fromMap(final Map<String, Object?> map) =>
      DealServiceModel(
        dealId: map['deal_id'] as int?,
        serviceId: map['service_id'] as int?,
        amount: map['amount']! as double,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        deal: optionalDealConverter
            .fromJson(map['deal'] as Map<String, Object?>?),
        service: optionalServiceConverter
            .fromJson(map['service'] as Map<String, Object?>?),
        openings: const IterableConverter<ContainerTankOpeningModel,
            Map<String, Object?>>(
          containerTankOpeningConverter,
        ).fromJson(
          (map['openings'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory DealServiceModel.fromJson(final String source) =>
      DealServiceModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final DealServiceModel other) {
    int value;
    if ((value = dealId != null && other.dealId != null
            ? dealId!.compareTo(other.dealId!)
            : 0) !=
        0) {
    } else if ((value = serviceId != null && other.serviceId != null
            ? serviceId!.compareTo(other.serviceId!)
            : 0) !=
        0) {}
    return value;
  }

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is DealServiceModel &&
          other.dealId == dealId &&
          other.serviceId == serviceId &&
          other.amount == amount;

  @override
  int get hashCode => dealId.hashCode ^ serviceId.hashCode ^ amount.hashCode;

  @override
  String toString() =>
      'DealServiceModel(dealId: $dealId, serviceId: $serviceId, '
      'amount: $amount, createdAt: $createdAt, updatedAt: $updatedAt, '
      'deal: $deal, service: $service, openings: $openings)';
}

/// The model of a GroupModel.
@sealed
@immutable
class GroupModel implements Comparable<GroupModel> {
  /// The model of a GroupModel.
  const GroupModel({
    this.ownerId,
    this.name = '',
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.members = const Iterable<GroupMemberModel>.empty(),
  });

  /// The `owner_id` property of this [GroupModel].
  final int? ownerId;

  /// The `name` property of this [GroupModel].
  final String name;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `owner` property of this [GroupModel].
  final UserModel? owner;

  /// The `members` property of this [GroupModel].
  final Iterable<GroupMemberModel> members;

  /// Return the copy of this model.
  GroupModel copyWith({
    final int? ownerId,
    final String? name,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final UserModel? owner,
    final Iterable<GroupMemberModel>? members,
  }) =>
      GroupModel(
        ownerId: ownerId ?? this.ownerId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        owner: owner ?? this.owner,
        members: members ?? this.members,
      );

  /// Return the copy of this model with nullable fields.
  GroupModel copyWithNull({
    final bool ownerId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool owner = false,
  }) =>
      GroupModel(
        ownerId: ownerId ? null : this.ownerId,
        name: name,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        owner: owner ? null : this.owner,
        members: members,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (ownerId != null) 'owner_id': ownerId,
        'name': name,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (owner != null) 'owner': optionalUserConverter.toJson(owner),
        'members':
            const IterableConverter<GroupMemberModel, Map<String, Object?>>(
          groupMemberConverter,
        ).toJson(members).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory GroupModel.fromMap(final Map<String, Object?> map) => GroupModel(
        ownerId: map['owner_id'] as int?,
        name: map['name']! as String,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        owner: optionalUserConverter
            .fromJson(map['owner'] as Map<String, Object?>?),
        members:
            const IterableConverter<GroupMemberModel, Map<String, Object?>>(
          groupMemberConverter,
        ).fromJson(
          (map['members'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory GroupModel.fromJson(final String source) =>
      GroupModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final GroupModel other) =>
      ownerId != null && other.ownerId != null
          ? ownerId!.compareTo(other.ownerId!)
          : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is GroupModel && other.ownerId == ownerId && other.name == name;

  @override
  int get hashCode => ownerId.hashCode ^ name.hashCode;

  @override
  String toString() =>
      'GroupModel(ownerId: $ownerId, name: $name, createdAt: $createdAt, '
      'updatedAt: $updatedAt, owner: $owner, members: $members)';
}

/// The model of a GroupMemberModel.
@sealed
@immutable
class GroupMemberModel implements Comparable<GroupMemberModel> {
  /// The model of a GroupMemberModel.
  const GroupMemberModel({
    this.groupOwnerId,
    this.userId,
    this.accepted,
    this.rights = const Iterable<GroupMemberRights>.empty(),
    this.createdAt,
    this.updatedAt,
    this.group,
  });

  /// The `group_owner_id` property of this [GroupMemberModel].
  final int? groupOwnerId;

  /// The `user_id` property of this [GroupMemberModel].
  final int? userId;

  /// The `accepted` property of this [GroupMemberModel].
  final bool? accepted;

  /// The `rights` property of this [GroupMemberModel].
  final Iterable<GroupMemberRights> rights;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `group` property of this [GroupMemberModel].
  final GroupModel? group;

  /// Return the copy of this model.
  GroupMemberModel copyWith({
    final int? groupOwnerId,
    final int? userId,
    final bool? accepted,
    final Iterable<GroupMemberRights>? rights,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final GroupModel? group,
  }) =>
      GroupMemberModel(
        groupOwnerId: groupOwnerId ?? this.groupOwnerId,
        userId: userId ?? this.userId,
        accepted: accepted ?? this.accepted,
        rights: rights ?? this.rights,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        group: group ?? this.group,
      );

  /// Return the copy of this model with nullable fields.
  GroupMemberModel copyWithNull({
    final bool groupOwnerId = false,
    final bool userId = false,
    final bool accepted = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool group = false,
  }) =>
      GroupMemberModel(
        groupOwnerId: groupOwnerId ? null : this.groupOwnerId,
        userId: userId ? null : this.userId,
        accepted: accepted ? null : this.accepted,
        rights: rights,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        group: group ? null : this.group,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (groupOwnerId != null) 'group_owner_id': groupOwnerId,
        if (userId != null) 'user_id': userId,
        if (accepted != null) 'accepted': accepted,
        'rights': const IterableConverter<GroupMemberRights, String>(
          EnumConverter<GroupMemberRights>(
            GroupMemberRights.values,
          ),
        ).toJson(rights).toList(growable: false),
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (group != null) 'group': optionalGroupConverter.toJson(group),
      };

  /// Convert the map with string keys to this model.
  factory GroupMemberModel.fromMap(final Map<String, Object?> map) =>
      GroupMemberModel(
        groupOwnerId: map['group_owner_id'] as int?,
        userId: map['user_id'] as int?,
        accepted: map['accepted'] as bool?,
        rights: const IterableConverter<GroupMemberRights, String>(
          EnumConverter<GroupMemberRights>(
            GroupMemberRights.values,
          ),
        ).fromJson(
          (map['rights'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<String>(),
        ),
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        group: optionalGroupConverter
            .fromJson(map['group'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory GroupMemberModel.fromJson(final String source) =>
      GroupMemberModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final GroupMemberModel other) {
    int value;
    if ((value = groupOwnerId != null && other.groupOwnerId != null
            ? groupOwnerId!.compareTo(other.groupOwnerId!)
            : 0) !=
        0) {
    } else if ((value = userId != null && other.userId != null
            ? userId!.compareTo(other.userId!)
            : 0) !=
        0) {}
    return value;
  }

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is GroupMemberModel &&
          other.groupOwnerId == groupOwnerId &&
          other.userId == userId &&
          other.accepted == accepted &&
          const IterableEquality<GroupMemberRights>()
              .equals(other.rights, rights);

  @override
  int get hashCode =>
      groupOwnerId.hashCode ^
      userId.hashCode ^
      accepted.hashCode ^
      rights.hashCode;

  @override
  String toString() =>
      'GroupMemberModel(groupOwnerId: $groupOwnerId, userId: $userId, '
      'accepted: $accepted, rights: $rights, createdAt: $createdAt, '
      'updatedAt: $updatedAt, group: $group)';
}

/// The model of a PersonModel.
@sealed
@immutable
class PersonModel implements Comparable<PersonModel> {
  /// The model of a PersonModel.
  const PersonModel({
    this.userId,
    this.gender = false,
    this.familyCount = 1,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  /// The `user_id` property of this [PersonModel].
  final int? userId;

  /// The `gender` property of this [PersonModel].
  final bool gender;

  /// The `family_count` property of this [PersonModel].
  final int familyCount;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `user` property of this [PersonModel].
  final UserModel? user;

  /// Return the copy of this model.
  PersonModel copyWith({
    final int? userId,
    final bool? gender,
    final int? familyCount,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final UserModel? user,
  }) =>
      PersonModel(
        userId: userId ?? this.userId,
        gender: gender ?? this.gender,
        familyCount: familyCount ?? this.familyCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
      );

  /// Return the copy of this model with nullable fields.
  PersonModel copyWithNull({
    final bool userId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool user = false,
  }) =>
      PersonModel(
        userId: userId ? null : this.userId,
        gender: gender,
        familyCount: familyCount,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        user: user ? null : this.user,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (userId != null) 'user_id': userId,
        'gender': gender,
        'family_count': familyCount,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (user != null) 'user': optionalUserConverter.toJson(user),
      };

  /// Convert the map with string keys to this model.
  factory PersonModel.fromMap(final Map<String, Object?> map) => PersonModel(
        userId: map['user_id'] as int?,
        gender: map['gender']! as bool,
        familyCount: map['family_count']! as int,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        user: optionalUserConverter
            .fromJson(map['user'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory PersonModel.fromJson(final String source) =>
      PersonModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final PersonModel other) =>
      userId != null && other.userId != null
          ? userId!.compareTo(other.userId!)
          : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is PersonModel &&
          other.userId == userId &&
          other.gender == gender &&
          other.familyCount == familyCount;

  @override
  int get hashCode => userId.hashCode ^ gender.hashCode ^ familyCount.hashCode;

  @override
  String toString() => 'PersonModel(userId: $userId, gender: $gender, '
      'familyCount: $familyCount, createdAt: $createdAt, '
      'updatedAt: $updatedAt, user: $user)';
}

/// The model of a ServicePriceModel.
@sealed
@immutable
class ServicePriceModel implements Comparable<ServicePriceModel> {
  /// The model of a ServicePriceModel.
  const ServicePriceModel({
    required this.value,
    this.serviceId,
    this.priceId,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.price,
  });

  /// The `service_id` property of this [ServicePriceModel].
  final int? serviceId;

  /// The `price_id` property of this [ServicePriceModel].
  final int? priceId;

  /// The `value` property of this [ServicePriceModel].
  final double value;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `service` property of this [ServicePriceModel].
  final ServiceModel? service;

  /// The `price` property of this [ServicePriceModel].
  final PriceModel? price;

  /// Return the copy of this model.
  ServicePriceModel copyWith({
    final int? serviceId,
    final int? priceId,
    final double? value,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final ServiceModel? service,
    final PriceModel? price,
  }) =>
      ServicePriceModel(
        serviceId: serviceId ?? this.serviceId,
        priceId: priceId ?? this.priceId,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        service: service ?? this.service,
        price: price ?? this.price,
      );

  /// Return the copy of this model with nullable fields.
  ServicePriceModel copyWithNull({
    final bool serviceId = false,
    final bool priceId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool service = false,
    final bool price = false,
  }) =>
      ServicePriceModel(
        serviceId: serviceId ? null : this.serviceId,
        priceId: priceId ? null : this.priceId,
        value: value,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        service: service ? null : this.service,
        price: price ? null : this.price,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (serviceId != null) 'service_id': serviceId,
        if (priceId != null) 'price_id': priceId,
        'value': value,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (service != null)
          'service': optionalServiceConverter.toJson(service),
        if (price != null) 'price': optionalPriceConverter.toJson(price),
      };

  /// Convert the map with string keys to this model.
  factory ServicePriceModel.fromMap(final Map<String, Object?> map) =>
      ServicePriceModel(
        serviceId: map['service_id'] as int?,
        priceId: map['price_id'] as int?,
        value: map['value']! as double,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        service: optionalServiceConverter
            .fromJson(map['service'] as Map<String, Object?>?),
        price: optionalPriceConverter
            .fromJson(map['price'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ServicePriceModel.fromJson(final String source) =>
      ServicePriceModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final ServicePriceModel other) {
    int value;
    if ((value = serviceId != null && other.serviceId != null
            ? serviceId!.compareTo(other.serviceId!)
            : 0) !=
        0) {
    } else if ((value = priceId != null && other.priceId != null
            ? priceId!.compareTo(other.priceId!)
            : 0) !=
        0) {}
    return value;
  }

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ServicePriceModel &&
          other.serviceId == serviceId &&
          other.priceId == priceId &&
          other.value == value;

  @override
  int get hashCode => serviceId.hashCode ^ priceId.hashCode ^ value.hashCode;

  @override
  String toString() =>
      'ServicePriceModel(serviceId: $serviceId, priceId: $priceId, '
      'value: $value, createdAt: $createdAt, updatedAt: $updatedAt, '
      'service: $service, price: $price)';
}

/// The model of a BonusModel.
@sealed
@immutable
class BonusModel implements Comparable<BonusModel> {
  /// The model of a BonusModel.
  const BonusModel({
    required this.name,
    this.ownerId,
    this.id,
    this.description = '',
    this.userLimit = 0,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.images = const Iterable<BonusImageModel>.empty(),
    this.coupons = const Iterable<BonusCouponModel>.empty(),
    this.prices = const Iterable<BonusPriceModel>.empty(),
  });

  /// The `owner_id` property of this [BonusModel].
  final int? ownerId;

  /// The `id` property of this [BonusModel].
  final int? id;

  /// The `name` property of this [BonusModel].
  final String name;

  /// The `description` property of this [BonusModel].
  final String description;

  /// The `user_limit` property of this [BonusModel].
  final int userLimit;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `owner` property of this [BonusModel].
  final UserModel? owner;

  /// The `images` property of this [BonusModel].
  final Iterable<BonusImageModel> images;

  /// The `coupons` property of this [BonusModel].
  final Iterable<BonusCouponModel> coupons;

  /// The `prices` property of this [BonusModel].
  final Iterable<BonusPriceModel> prices;

  /// Return the copy of this model.
  BonusModel copyWith({
    final int? ownerId,
    final int? id,
    final String? name,
    final String? description,
    final int? userLimit,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final UserModel? owner,
    final Iterable<BonusImageModel>? images,
    final Iterable<BonusCouponModel>? coupons,
    final Iterable<BonusPriceModel>? prices,
  }) =>
      BonusModel(
        ownerId: ownerId ?? this.ownerId,
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        userLimit: userLimit ?? this.userLimit,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        owner: owner ?? this.owner,
        images: images ?? this.images,
        coupons: coupons ?? this.coupons,
        prices: prices ?? this.prices,
      );

  /// Return the copy of this model with nullable fields.
  BonusModel copyWithNull({
    final bool ownerId = false,
    final bool id = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool owner = false,
  }) =>
      BonusModel(
        ownerId: ownerId ? null : this.ownerId,
        id: id ? null : this.id,
        name: name,
        description: description,
        userLimit: userLimit,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        owner: owner ? null : this.owner,
        images: images,
        coupons: coupons,
        prices: prices,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (ownerId != null) 'owner_id': ownerId,
        if (id != null) 'id': id,
        'name': name,
        'description': description,
        'user_limit': userLimit,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (owner != null) 'owner': optionalUserConverter.toJson(owner),
        'images':
            const IterableConverter<BonusImageModel, Map<String, Object?>>(
          bonusImageConverter,
        ).toJson(images).toList(growable: false),
        'coupons':
            const IterableConverter<BonusCouponModel, Map<String, Object?>>(
          bonusCouponConverter,
        ).toJson(coupons).toList(growable: false),
        'prices':
            const IterableConverter<BonusPriceModel, Map<String, Object?>>(
          bonusPriceConverter,
        ).toJson(prices).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory BonusModel.fromMap(final Map<String, Object?> map) => BonusModel(
        ownerId: map['owner_id'] as int?,
        id: map['id'] as int?,
        name: map['name']! as String,
        description: map['description']! as String,
        userLimit: map['user_limit']! as int,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        owner: optionalUserConverter
            .fromJson(map['owner'] as Map<String, Object?>?),
        images: const IterableConverter<BonusImageModel, Map<String, Object?>>(
          bonusImageConverter,
        ).fromJson(
          (map['images'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        coupons:
            const IterableConverter<BonusCouponModel, Map<String, Object?>>(
          bonusCouponConverter,
        ).fromJson(
          (map['coupons'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        prices: const IterableConverter<BonusPriceModel, Map<String, Object?>>(
          bonusPriceConverter,
        ).fromJson(
          (map['prices'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory BonusModel.fromJson(final String source) =>
      BonusModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final BonusModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is BonusModel &&
          other.ownerId == ownerId &&
          other.id == id &&
          other.name == name &&
          other.description == description &&
          other.userLimit == userLimit;

  @override
  int get hashCode =>
      ownerId.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      userLimit.hashCode;

  @override
  String toString() => 'BonusModel(ownerId: $ownerId, id: $id, name: $name, '
      'description: $description, userLimit: $userLimit, '
      'createdAt: $createdAt, updatedAt: $updatedAt, owner: $owner, '
      'images: $images, coupons: $coupons, prices: $prices)';
}

/// The model of a BonusCouponModel.
@sealed
@immutable
class BonusCouponModel implements Comparable<BonusCouponModel> {
  /// The model of a BonusCouponModel.
  const BonusCouponModel({
    required this.hash,
    this.bonusId,
    this.active = true,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.bonus,
  });

  /// The `bonus_id` property of this [BonusCouponModel].
  final int? bonusId;

  /// The `hash` property of this [BonusCouponModel].
  final String hash;

  /// The `active` property of this [BonusCouponModel].
  final bool active;

  /// The `owner_id` property of this [BonusCouponModel].
  final int? ownerId;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `bonus` property of this [BonusCouponModel].
  final BonusModel? bonus;

  /// Return the copy of this model.
  BonusCouponModel copyWith({
    final int? bonusId,
    final String? hash,
    final bool? active,
    final int? ownerId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final BonusModel? bonus,
  }) =>
      BonusCouponModel(
        bonusId: bonusId ?? this.bonusId,
        hash: hash ?? this.hash,
        active: active ?? this.active,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        bonus: bonus ?? this.bonus,
      );

  /// Return the copy of this model with nullable fields.
  BonusCouponModel copyWithNull({
    final bool bonusId = false,
    final bool ownerId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool bonus = false,
  }) =>
      BonusCouponModel(
        bonusId: bonusId ? null : this.bonusId,
        hash: hash,
        active: active,
        ownerId: ownerId ? null : this.ownerId,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        bonus: bonus ? null : this.bonus,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (bonusId != null) 'bonus_id': bonusId,
        'hash': hash,
        'active': active,
        if (ownerId != null) 'owner_id': ownerId,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (bonus != null) 'bonus': optionalBonusConverter.toJson(bonus),
      };

  /// Convert the map with string keys to this model.
  factory BonusCouponModel.fromMap(final Map<String, Object?> map) =>
      BonusCouponModel(
        bonusId: map['bonus_id'] as int?,
        hash: map['hash']! as String,
        active: map['active']! as bool,
        ownerId: map['owner_id'] as int?,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        bonus: optionalBonusConverter
            .fromJson(map['bonus'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory BonusCouponModel.fromJson(final String source) =>
      BonusCouponModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final BonusCouponModel other) =>
      bonusId != null && other.bonusId != null
          ? bonusId!.compareTo(other.bonusId!)
          : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is BonusCouponModel &&
          other.bonusId == bonusId &&
          other.hash == hash &&
          other.active == active &&
          other.ownerId == ownerId;

  @override
  int get hashCode =>
      bonusId.hashCode ^ hash.hashCode ^ active.hashCode ^ ownerId.hashCode;

  @override
  String toString() =>
      'BonusCouponModel(bonusId: $bonusId, hash: $hash, active: $active, '
      'ownerId: $ownerId, createdAt: $createdAt, updatedAt: $updatedAt, '
      'bonus: $bonus)';
}

/// The model of a BonusImageModel.
@sealed
@immutable
class BonusImageModel implements Comparable<BonusImageModel> {
  /// The model of a BonusImageModel.
  const BonusImageModel({
    this.bonusId,
    this.imageId,
    this.createdAt,
    this.updatedAt,
    this.bonus,
    this.image,
  });

  /// The `bonus_id` property of this [BonusImageModel].
  final int? bonusId;

  /// The `image_id` property of this [BonusImageModel].
  final int? imageId;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `bonus` property of this [BonusImageModel].
  final BonusModel? bonus;

  /// The `image` property of this [BonusImageModel].
  final ImageModel? image;

  /// Return the copy of this model.
  BonusImageModel copyWith({
    final int? bonusId,
    final int? imageId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final BonusModel? bonus,
    final ImageModel? image,
  }) =>
      BonusImageModel(
        bonusId: bonusId ?? this.bonusId,
        imageId: imageId ?? this.imageId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        bonus: bonus ?? this.bonus,
        image: image ?? this.image,
      );

  /// Return the copy of this model with nullable fields.
  BonusImageModel copyWithNull({
    final bool bonusId = false,
    final bool imageId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool bonus = false,
    final bool image = false,
  }) =>
      BonusImageModel(
        bonusId: bonusId ? null : this.bonusId,
        imageId: imageId ? null : this.imageId,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        bonus: bonus ? null : this.bonus,
        image: image ? null : this.image,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (bonusId != null) 'bonus_id': bonusId,
        if (imageId != null) 'image_id': imageId,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (bonus != null) 'bonus': optionalBonusConverter.toJson(bonus),
        if (image != null) 'image': optionalImageConverter.toJson(image),
      };

  /// Convert the map with string keys to this model.
  factory BonusImageModel.fromMap(final Map<String, Object?> map) =>
      BonusImageModel(
        bonusId: map['bonus_id'] as int?,
        imageId: map['image_id'] as int?,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        bonus: optionalBonusConverter
            .fromJson(map['bonus'] as Map<String, Object?>?),
        image: optionalImageConverter
            .fromJson(map['image'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory BonusImageModel.fromJson(final String source) =>
      BonusImageModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final BonusImageModel other) {
    int value;
    if ((value = bonusId != null && other.bonusId != null
            ? bonusId!.compareTo(other.bonusId!)
            : 0) !=
        0) {
    } else if ((value = imageId != null && other.imageId != null
            ? imageId!.compareTo(other.imageId!)
            : 0) !=
        0) {}
    return value;
  }

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is BonusImageModel &&
          other.bonusId == bonusId &&
          other.imageId == imageId;

  @override
  int get hashCode => bonusId.hashCode ^ imageId.hashCode;

  @override
  String toString() => 'BonusImageModel(bonusId: $bonusId, imageId: $imageId, '
      'createdAt: $createdAt, updatedAt: $updatedAt, bonus: $bonus, '
      'image: $image)';
}

/// The model of a BonusPriceModel.
@sealed
@immutable
class BonusPriceModel implements Comparable<BonusPriceModel> {
  /// The model of a BonusPriceModel.
  const BonusPriceModel({
    required this.value,
    this.bonusId,
    this.priceId,
    this.createdAt,
    this.updatedAt,
    this.bonus,
    this.price,
  });

  /// The `bonus_id` property of this [BonusPriceModel].
  final int? bonusId;

  /// The `price_id` property of this [BonusPriceModel].
  final int? priceId;

  /// The `value` property of this [BonusPriceModel].
  final double value;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `bonus` property of this [BonusPriceModel].
  final BonusModel? bonus;

  /// The `price` property of this [BonusPriceModel].
  final PriceModel? price;

  /// Return the copy of this model.
  BonusPriceModel copyWith({
    final int? bonusId,
    final int? priceId,
    final double? value,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final BonusModel? bonus,
    final PriceModel? price,
  }) =>
      BonusPriceModel(
        bonusId: bonusId ?? this.bonusId,
        priceId: priceId ?? this.priceId,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        bonus: bonus ?? this.bonus,
        price: price ?? this.price,
      );

  /// Return the copy of this model with nullable fields.
  BonusPriceModel copyWithNull({
    final bool bonusId = false,
    final bool priceId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool bonus = false,
    final bool price = false,
  }) =>
      BonusPriceModel(
        bonusId: bonusId ? null : this.bonusId,
        priceId: priceId ? null : this.priceId,
        value: value,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        bonus: bonus ? null : this.bonus,
        price: price ? null : this.price,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (bonusId != null) 'bonus_id': bonusId,
        if (priceId != null) 'price_id': priceId,
        'value': value,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (bonus != null) 'bonus': optionalBonusConverter.toJson(bonus),
        if (price != null) 'price': optionalPriceConverter.toJson(price),
      };

  /// Convert the map with string keys to this model.
  factory BonusPriceModel.fromMap(final Map<String, Object?> map) =>
      BonusPriceModel(
        bonusId: map['bonus_id'] as int?,
        priceId: map['price_id'] as int?,
        value: map['value']! as double,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        bonus: optionalBonusConverter
            .fromJson(map['bonus'] as Map<String, Object?>?),
        price: optionalPriceConverter
            .fromJson(map['price'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory BonusPriceModel.fromJson(final String source) =>
      BonusPriceModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final BonusPriceModel other) {
    int value;
    if ((value = bonusId != null && other.bonusId != null
            ? bonusId!.compareTo(other.bonusId!)
            : 0) !=
        0) {
    } else if ((value = priceId != null && other.priceId != null
            ? priceId!.compareTo(other.priceId!)
            : 0) !=
        0) {}
    return value;
  }

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is BonusPriceModel &&
          other.bonusId == bonusId &&
          other.priceId == priceId &&
          other.value == value;

  @override
  int get hashCode => bonusId.hashCode ^ priceId.hashCode ^ value.hashCode;

  @override
  String toString() =>
      'BonusPriceModel(bonusId: $bonusId, priceId: $priceId, value: $value, '
      'createdAt: $createdAt, updatedAt: $updatedAt, bonus: $bonus, '
      'price: $price)';
}

/// The model of a ContainerModel.
@sealed
@immutable
class ContainerModel implements Comparable<ContainerModel> {
  /// The model of a ContainerModel.
  const ContainerModel({
    required this.latitude,
    required this.longtitude,
    this.ownerId,
    this.id,
    this.addressId,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.owner,
    this.tanks = const Iterable<ContainerTankModel>.empty(),
    this.reports = const Iterable<ContainerReportModel>.empty(),
  });

  /// The `owner_id` property of this [ContainerModel].
  final int? ownerId;

  /// The `id` property of this [ContainerModel].
  final int? id;

  /// The `latitude` property of this [ContainerModel].
  final double latitude;

  /// The `longtitude` property of this [ContainerModel].
  final double longtitude;

  /// The `address_id` property of this [ContainerModel].
  final int? addressId;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `address` property of this [ContainerModel].
  final AddressModel? address;

  /// The `owner` property of this [ContainerModel].
  final UserModel? owner;

  /// The `tanks` property of this [ContainerModel].
  final Iterable<ContainerTankModel> tanks;

  /// The `reports` property of this [ContainerModel].
  final Iterable<ContainerReportModel> reports;

  /// Return the copy of this model.
  ContainerModel copyWith({
    final int? ownerId,
    final int? id,
    final double? latitude,
    final double? longtitude,
    final int? addressId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final AddressModel? address,
    final UserModel? owner,
    final Iterable<ContainerTankModel>? tanks,
    final Iterable<ContainerReportModel>? reports,
  }) =>
      ContainerModel(
        ownerId: ownerId ?? this.ownerId,
        id: id ?? this.id,
        latitude: latitude ?? this.latitude,
        longtitude: longtitude ?? this.longtitude,
        addressId: addressId ?? this.addressId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        address: address ?? this.address,
        owner: owner ?? this.owner,
        tanks: tanks ?? this.tanks,
        reports: reports ?? this.reports,
      );

  /// Return the copy of this model with nullable fields.
  ContainerModel copyWithNull({
    final bool ownerId = false,
    final bool id = false,
    final bool addressId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool address = false,
    final bool owner = false,
  }) =>
      ContainerModel(
        ownerId: ownerId ? null : this.ownerId,
        id: id ? null : this.id,
        latitude: latitude,
        longtitude: longtitude,
        addressId: addressId ? null : this.addressId,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        address: address ? null : this.address,
        owner: owner ? null : this.owner,
        tanks: tanks,
        reports: reports,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (ownerId != null) 'owner_id': ownerId,
        if (id != null) 'id': id,
        'latitude': latitude,
        'longtitude': longtitude,
        if (addressId != null) 'address_id': addressId,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (address != null)
          'address': optionalAddressConverter.toJson(address),
        if (owner != null) 'owner': optionalUserConverter.toJson(owner),
        'tanks':
            const IterableConverter<ContainerTankModel, Map<String, Object?>>(
          containerTankConverter,
        ).toJson(tanks).toList(growable: false),
        'reports':
            const IterableConverter<ContainerReportModel, Map<String, Object?>>(
          containerReportConverter,
        ).toJson(reports).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory ContainerModel.fromMap(final Map<String, Object?> map) =>
      ContainerModel(
        ownerId: map['owner_id'] as int?,
        id: map['id'] as int?,
        latitude: map['latitude']! as double,
        longtitude: map['longtitude']! as double,
        addressId: map['address_id'] as int?,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        address: optionalAddressConverter
            .fromJson(map['address'] as Map<String, Object?>?),
        owner: optionalUserConverter
            .fromJson(map['owner'] as Map<String, Object?>?),
        tanks:
            const IterableConverter<ContainerTankModel, Map<String, Object?>>(
          containerTankConverter,
        ).fromJson(
          (map['tanks'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        reports:
            const IterableConverter<ContainerReportModel, Map<String, Object?>>(
          containerReportConverter,
        ).fromJson(
          (map['reports'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ContainerModel.fromJson(final String source) =>
      ContainerModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final ContainerModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ContainerModel &&
          other.ownerId == ownerId &&
          other.id == id &&
          other.latitude == latitude &&
          other.longtitude == longtitude &&
          other.addressId == addressId;

  @override
  int get hashCode =>
      ownerId.hashCode ^
      id.hashCode ^
      latitude.hashCode ^
      longtitude.hashCode ^
      addressId.hashCode;

  @override
  String toString() =>
      'ContainerModel(ownerId: $ownerId, id: $id, latitude: $latitude, '
      'longtitude: $longtitude, addressId: $addressId, createdAt: $createdAt, '
      'updatedAt: $updatedAt, address: $address, owner: $owner, tanks: $tanks, '
      'reports: $reports)';
}

/// The model of a ContainerReportTypeModel.
@sealed
@immutable
class ContainerReportTypeModel implements Comparable<ContainerReportTypeModel> {
  /// The model of a ContainerReportTypeModel.
  const ContainerReportTypeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.reports = const Iterable<ContainerReportModel>.empty(),
  });

  /// The `id` property of this [ContainerReportTypeModel].
  final int? id;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `reports` property of this [ContainerReportTypeModel].
  final Iterable<ContainerReportModel> reports;

  /// Return the copy of this model.
  ContainerReportTypeModel copyWith({
    final int? id,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Iterable<ContainerReportModel>? reports,
  }) =>
      ContainerReportTypeModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        reports: reports ?? this.reports,
      );

  /// Return the copy of this model with nullable fields.
  ContainerReportTypeModel copyWithNull({
    final bool id = false,
    final bool createdAt = false,
    final bool updatedAt = false,
  }) =>
      ContainerReportTypeModel(
        id: id ? null : this.id,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        reports: reports,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (id != null) 'id': id,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        'reports':
            const IterableConverter<ContainerReportModel, Map<String, Object?>>(
          containerReportConverter,
        ).toJson(reports).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory ContainerReportTypeModel.fromMap(final Map<String, Object?> map) =>
      ContainerReportTypeModel(
        id: map['id'] as int?,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        reports:
            const IterableConverter<ContainerReportModel, Map<String, Object?>>(
          containerReportConverter,
        ).fromJson(
          (map['reports'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ContainerReportTypeModel.fromJson(final String source) =>
      ContainerReportTypeModel.fromMap(
        json.decode(source)! as Map<String, Object?>,
      );

  @override
  int compareTo(final ContainerReportTypeModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ContainerReportTypeModel && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'ContainerReportTypeModel(id: $id, createdAt: $createdAt, '
      'updatedAt: $updatedAt, reports: $reports)';
}

/// The model of a ContainerTankTypeModel.
@sealed
@immutable
class ContainerTankTypeModel implements Comparable<ContainerTankTypeModel> {
  /// The model of a ContainerTankTypeModel.
  const ContainerTankTypeModel({
    required this.name,
    required this.volume,
    this.id,
    this.measurementId,
    this.clearingPeriod = Duration.zero,
    this.createdAt,
    this.updatedAt,
    this.measurement,
    this.tanks = const Iterable<ContainerTankModel>.empty(),
  });

  /// The `id` property of this [ContainerTankTypeModel].
  final int? id;

  /// The `name` property of this [ContainerTankTypeModel].
  final String name;

  /// The `measurement_id` property of this [ContainerTankTypeModel].
  final int? measurementId;

  /// The `volume` property of this [ContainerTankTypeModel].
  final int volume;

  /// The `clearing_period` property of this [ContainerTankTypeModel].
  final Duration clearingPeriod;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `measurement` property of this [ContainerTankTypeModel].
  final MeasurementModel? measurement;

  /// The `tanks` property of this [ContainerTankTypeModel].
  final Iterable<ContainerTankModel> tanks;

  /// Return the copy of this model.
  ContainerTankTypeModel copyWith({
    final int? id,
    final String? name,
    final int? measurementId,
    final int? volume,
    final Duration? clearingPeriod,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final MeasurementModel? measurement,
    final Iterable<ContainerTankModel>? tanks,
  }) =>
      ContainerTankTypeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        measurementId: measurementId ?? this.measurementId,
        volume: volume ?? this.volume,
        clearingPeriod: clearingPeriod ?? this.clearingPeriod,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        measurement: measurement ?? this.measurement,
        tanks: tanks ?? this.tanks,
      );

  /// Return the copy of this model with nullable fields.
  ContainerTankTypeModel copyWithNull({
    final bool id = false,
    final bool measurementId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool measurement = false,
  }) =>
      ContainerTankTypeModel(
        id: id ? null : this.id,
        name: name,
        measurementId: measurementId ? null : this.measurementId,
        volume: volume,
        clearingPeriod: clearingPeriod,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        measurement: measurement ? null : this.measurement,
        tanks: tanks,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (id != null) 'id': id,
        'name': name,
        if (measurementId != null) 'measurement_id': measurementId,
        'volume': volume,
        'clearing_period': durationConverter.toJson(clearingPeriod),
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (measurement != null)
          'measurement': optionalMeasurementConverter.toJson(measurement),
        'tanks':
            const IterableConverter<ContainerTankModel, Map<String, Object?>>(
          containerTankConverter,
        ).toJson(tanks).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory ContainerTankTypeModel.fromMap(final Map<String, Object?> map) =>
      ContainerTankTypeModel(
        id: map['id'] as int?,
        name: map['name']! as String,
        measurementId: map['measurement_id'] as int?,
        volume: map['volume']! as int,
        clearingPeriod:
            durationConverter.fromJson(map['clearing_period']! as num),
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        measurement: optionalMeasurementConverter
            .fromJson(map['measurement'] as Map<String, Object?>?),
        tanks:
            const IterableConverter<ContainerTankModel, Map<String, Object?>>(
          containerTankConverter,
        ).fromJson(
          (map['tanks'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ContainerTankTypeModel.fromJson(final String source) =>
      ContainerTankTypeModel.fromMap(
        json.decode(source)! as Map<String, Object?>,
      );

  @override
  int compareTo(final ContainerTankTypeModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ContainerTankTypeModel &&
          other.id == id &&
          other.name == name &&
          other.measurementId == measurementId &&
          other.volume == volume &&
          other.clearingPeriod == clearingPeriod;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      measurementId.hashCode ^
      volume.hashCode ^
      clearingPeriod.hashCode;

  @override
  String toString() => 'ContainerTankTypeModel(id: $id, name: $name, '
      'measurementId: $measurementId, volume: $volume, '
      'clearingPeriod: $clearingPeriod, createdAt: $createdAt, '
      'updatedAt: $updatedAt, measurement: $measurement, tanks: $tanks)';
}

/// The model of a ContainerTankModel.
@sealed
@immutable
class ContainerTankModel implements Comparable<ContainerTankModel> {
  /// The model of a ContainerTankModel.
  const ContainerTankModel({
    this.containerId,
    this.typeId,
    this.currentVolume = 0.0,
    this.createdAt,
    this.updatedAt,
    this.container,
    this.type,
    this.openings = const Iterable<ContainerTankOpeningModel>.empty(),
    this.clearings = const Iterable<ContainerTankClearingModel>.empty(),
  });

  /// The `container_id` property of this [ContainerTankModel].
  final int? containerId;

  /// The `type_id` property of this [ContainerTankModel].
  final int? typeId;

  /// The `current_volume` property of this [ContainerTankModel].
  final double currentVolume;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `container` property of this [ContainerTankModel].
  final ContainerModel? container;

  /// The `type` property of this [ContainerTankModel].
  final ContainerTankTypeModel? type;

  /// The `openings` property of this [ContainerTankModel].
  final Iterable<ContainerTankOpeningModel> openings;

  /// The `clearings` property of this [ContainerTankModel].
  final Iterable<ContainerTankClearingModel> clearings;

  /// Return the copy of this model.
  ContainerTankModel copyWith({
    final int? containerId,
    final int? typeId,
    final double? currentVolume,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final ContainerModel? container,
    final ContainerTankTypeModel? type,
    final Iterable<ContainerTankOpeningModel>? openings,
    final Iterable<ContainerTankClearingModel>? clearings,
  }) =>
      ContainerTankModel(
        containerId: containerId ?? this.containerId,
        typeId: typeId ?? this.typeId,
        currentVolume: currentVolume ?? this.currentVolume,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        container: container ?? this.container,
        type: type ?? this.type,
        openings: openings ?? this.openings,
        clearings: clearings ?? this.clearings,
      );

  /// Return the copy of this model with nullable fields.
  ContainerTankModel copyWithNull({
    final bool containerId = false,
    final bool typeId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool container = false,
    final bool type = false,
  }) =>
      ContainerTankModel(
        containerId: containerId ? null : this.containerId,
        typeId: typeId ? null : this.typeId,
        currentVolume: currentVolume,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        container: container ? null : this.container,
        type: type ? null : this.type,
        openings: openings,
        clearings: clearings,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (containerId != null) 'container_id': containerId,
        if (typeId != null) 'type_id': typeId,
        'current_volume': currentVolume,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (container != null)
          'container': optionalContainerConverter.toJson(container),
        if (type != null)
          'type': optionalContainerTankTypeConverter.toJson(type),
        'openings': const IterableConverter<ContainerTankOpeningModel,
            Map<String, Object?>>(
          containerTankOpeningConverter,
        ).toJson(openings).toList(growable: false),
        'clearings': const IterableConverter<ContainerTankClearingModel,
            Map<String, Object?>>(
          containerTankClearingConverter,
        ).toJson(clearings).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory ContainerTankModel.fromMap(final Map<String, Object?> map) =>
      ContainerTankModel(
        containerId: map['container_id'] as int?,
        typeId: map['type_id'] as int?,
        currentVolume: map['current_volume']! as double,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        container: optionalContainerConverter
            .fromJson(map['container'] as Map<String, Object?>?),
        type: optionalContainerTankTypeConverter
            .fromJson(map['type'] as Map<String, Object?>?),
        openings: const IterableConverter<ContainerTankOpeningModel,
            Map<String, Object?>>(
          containerTankOpeningConverter,
        ).fromJson(
          (map['openings'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
        clearings: const IterableConverter<ContainerTankClearingModel,
            Map<String, Object?>>(
          containerTankClearingConverter,
        ).fromJson(
          (map['clearings'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ContainerTankModel.fromJson(final String source) =>
      ContainerTankModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final ContainerTankModel other) {
    int value;
    if ((value = containerId != null && other.containerId != null
            ? containerId!.compareTo(other.containerId!)
            : 0) !=
        0) {
    } else if ((value = typeId != null && other.typeId != null
            ? typeId!.compareTo(other.typeId!)
            : 0) !=
        0) {}
    return value;
  }

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ContainerTankModel &&
          other.containerId == containerId &&
          other.typeId == typeId &&
          other.currentVolume == currentVolume;

  @override
  int get hashCode =>
      containerId.hashCode ^ typeId.hashCode ^ currentVolume.hashCode;

  @override
  String toString() =>
      'ContainerTankModel(containerId: $containerId, typeId: $typeId, '
      'currentVolume: $currentVolume, createdAt: $createdAt, '
      'updatedAt: $updatedAt, container: $container, type: $type, '
      'openings: $openings, clearings: $clearings)';
}

/// The model of a ContainerReportModel.
@sealed
@immutable
class ContainerReportModel implements Comparable<ContainerReportModel> {
  /// The model of a ContainerReportModel.
  const ContainerReportModel({
    this.userId,
    this.containerId,
    this.id,
    this.type,
    this.information = '',
    this.createdAt,
    this.updatedAt,
    this.type_,
    this.container,
  });

  /// The `user_id` property of this [ContainerReportModel].
  final int? userId;

  /// The `container_id` property of this [ContainerReportModel].
  final int? containerId;

  /// The `id` property of this [ContainerReportModel].
  final int? id;

  /// The `type` property of this [ContainerReportModel].
  final int? type;

  /// The `information` property of this [ContainerReportModel].
  final String information;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `type_` property of this [ContainerReportModel].
  final ContainerReportTypeModel? type_;

  /// The `container` property of this [ContainerReportModel].
  final ContainerModel? container;

  /// Return the copy of this model.
  ContainerReportModel copyWith({
    final int? userId,
    final int? containerId,
    final int? id,
    final int? type,
    final String? information,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final ContainerReportTypeModel? type_,
    final ContainerModel? container,
  }) =>
      ContainerReportModel(
        userId: userId ?? this.userId,
        containerId: containerId ?? this.containerId,
        id: id ?? this.id,
        type: type ?? this.type,
        information: information ?? this.information,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        type_: type_ ?? this.type_,
        container: container ?? this.container,
      );

  /// Return the copy of this model with nullable fields.
  ContainerReportModel copyWithNull({
    final bool userId = false,
    final bool containerId = false,
    final bool id = false,
    final bool type = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool type_ = false,
    final bool container = false,
  }) =>
      ContainerReportModel(
        userId: userId ? null : this.userId,
        containerId: containerId ? null : this.containerId,
        id: id ? null : this.id,
        type: type ? null : this.type,
        information: information,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        type_: type_ ? null : this.type_,
        container: container ? null : this.container,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (userId != null) 'user_id': userId,
        if (containerId != null) 'container_id': containerId,
        if (id != null) 'id': id,
        if (type != null) 'type': type,
        'information': information,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (type_ != null)
          'type_': optionalContainerReportTypeConverter.toJson(type_),
        if (container != null)
          'container': optionalContainerConverter.toJson(container),
      };

  /// Convert the map with string keys to this model.
  factory ContainerReportModel.fromMap(final Map<String, Object?> map) =>
      ContainerReportModel(
        userId: map['user_id'] as int?,
        containerId: map['container_id'] as int?,
        id: map['id'] as int?,
        type: map['type'] as int?,
        information: map['information']! as String,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        type_: optionalContainerReportTypeConverter
            .fromJson(map['type_'] as Map<String, Object?>?),
        container: optionalContainerConverter
            .fromJson(map['container'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ContainerReportModel.fromJson(final String source) =>
      ContainerReportModel.fromMap(
        json.decode(source)! as Map<String, Object?>,
      );

  @override
  int compareTo(final ContainerReportModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ContainerReportModel &&
          other.userId == userId &&
          other.containerId == containerId &&
          other.id == id &&
          other.type == type &&
          other.information == information;

  @override
  int get hashCode =>
      userId.hashCode ^
      containerId.hashCode ^
      id.hashCode ^
      type.hashCode ^
      information.hashCode;

  @override
  String toString() =>
      'ContainerReportModel(userId: $userId, containerId: $containerId, '
      'id: $id, type: $type, information: $information, createdAt: $createdAt, '
      'updatedAt: $updatedAt, type_: $type_, container: $container)';
}

/// The model of a ContainerTankClearingModel.
@sealed
@immutable
class ContainerTankClearingModel
    implements Comparable<ContainerTankClearingModel> {
  /// The model of a ContainerTankClearingModel.
  const ContainerTankClearingModel({
    required this.volume,
    this.userId,
    this.containerId,
    this.tankTypeId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.tank,
  });

  /// The `user_id` property of this [ContainerTankClearingModel].
  final int? userId;

  /// The `container_id` property of this [ContainerTankClearingModel].
  final int? containerId;

  /// The `tank_type_id` property of this [ContainerTankClearingModel].
  final int? tankTypeId;

  /// The `id` property of this [ContainerTankClearingModel].
  final int? id;

  /// The `volume` property of this [ContainerTankClearingModel].
  final int volume;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `user` property of this [ContainerTankClearingModel].
  final UserModel? user;

  /// The `tank` property of this [ContainerTankClearingModel].
  final ContainerTankModel? tank;

  /// Return the copy of this model.
  ContainerTankClearingModel copyWith({
    final int? userId,
    final int? containerId,
    final int? tankTypeId,
    final int? id,
    final int? volume,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final UserModel? user,
    final ContainerTankModel? tank,
  }) =>
      ContainerTankClearingModel(
        userId: userId ?? this.userId,
        containerId: containerId ?? this.containerId,
        tankTypeId: tankTypeId ?? this.tankTypeId,
        id: id ?? this.id,
        volume: volume ?? this.volume,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        tank: tank ?? this.tank,
      );

  /// Return the copy of this model with nullable fields.
  ContainerTankClearingModel copyWithNull({
    final bool userId = false,
    final bool containerId = false,
    final bool tankTypeId = false,
    final bool id = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool user = false,
    final bool tank = false,
  }) =>
      ContainerTankClearingModel(
        userId: userId ? null : this.userId,
        containerId: containerId ? null : this.containerId,
        tankTypeId: tankTypeId ? null : this.tankTypeId,
        id: id ? null : this.id,
        volume: volume,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        user: user ? null : this.user,
        tank: tank ? null : this.tank,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (userId != null) 'user_id': userId,
        if (containerId != null) 'container_id': containerId,
        if (tankTypeId != null) 'tank_type_id': tankTypeId,
        if (id != null) 'id': id,
        'volume': volume,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (user != null) 'user': optionalUserConverter.toJson(user),
        if (tank != null) 'tank': optionalContainerTankConverter.toJson(tank),
      };

  /// Convert the map with string keys to this model.
  factory ContainerTankClearingModel.fromMap(final Map<String, Object?> map) =>
      ContainerTankClearingModel(
        userId: map['user_id'] as int?,
        containerId: map['container_id'] as int?,
        tankTypeId: map['tank_type_id'] as int?,
        id: map['id'] as int?,
        volume: map['volume']! as int,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        user: optionalUserConverter
            .fromJson(map['user'] as Map<String, Object?>?),
        tank: optionalContainerTankConverter
            .fromJson(map['tank'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ContainerTankClearingModel.fromJson(final String source) =>
      ContainerTankClearingModel.fromMap(
        json.decode(source)! as Map<String, Object?>,
      );

  @override
  int compareTo(final ContainerTankClearingModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ContainerTankClearingModel &&
          other.userId == userId &&
          other.containerId == containerId &&
          other.tankTypeId == tankTypeId &&
          other.id == id &&
          other.volume == volume;

  @override
  int get hashCode =>
      userId.hashCode ^
      containerId.hashCode ^
      tankTypeId.hashCode ^
      id.hashCode ^
      volume.hashCode;

  @override
  String toString() =>
      'ContainerTankClearingModel(userId: $userId, containerId: $containerId, '
      'tankTypeId: $tankTypeId, id: $id, volume: $volume, '
      'createdAt: $createdAt, updatedAt: $updatedAt, user: $user, tank: $tank)';
}

/// The model of a ContainerTankOpeningModel.
@sealed
@immutable
class ContainerTankOpeningModel
    implements Comparable<ContainerTankOpeningModel> {
  /// The model of a ContainerTankOpeningModel.
  const ContainerTankOpeningModel({
    this.userId,
    this.containerId,
    this.tankTypeId,
    this.dealId,
    this.serviceId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.tank,
    this.dealService,
    this.drops = const Iterable<ContainerTankOpeningDropModel>.empty(),
  });

  /// The `user_id` property of this [ContainerTankOpeningModel].
  final int? userId;

  /// The `container_id` property of this [ContainerTankOpeningModel].
  final int? containerId;

  /// The `tank_type_id` property of this [ContainerTankOpeningModel].
  final int? tankTypeId;

  /// The `deal_id` property of this [ContainerTankOpeningModel].
  final int? dealId;

  /// The `service_id` property of this [ContainerTankOpeningModel].
  final int? serviceId;

  /// The `id` property of this [ContainerTankOpeningModel].
  final int? id;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `user` property of this [ContainerTankOpeningModel].
  final UserModel? user;

  /// The `tank` property of this [ContainerTankOpeningModel].
  final ContainerTankModel? tank;

  /// The `deal_service` property of this [ContainerTankOpeningModel].
  final DealServiceModel? dealService;

  /// The `drops` property of this [ContainerTankOpeningModel].
  final Iterable<ContainerTankOpeningDropModel> drops;

  /// Return the copy of this model.
  ContainerTankOpeningModel copyWith({
    final int? userId,
    final int? containerId,
    final int? tankTypeId,
    final int? dealId,
    final int? serviceId,
    final int? id,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final UserModel? user,
    final ContainerTankModel? tank,
    final DealServiceModel? dealService,
    final Iterable<ContainerTankOpeningDropModel>? drops,
  }) =>
      ContainerTankOpeningModel(
        userId: userId ?? this.userId,
        containerId: containerId ?? this.containerId,
        tankTypeId: tankTypeId ?? this.tankTypeId,
        dealId: dealId ?? this.dealId,
        serviceId: serviceId ?? this.serviceId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        tank: tank ?? this.tank,
        dealService: dealService ?? this.dealService,
        drops: drops ?? this.drops,
      );

  /// Return the copy of this model with nullable fields.
  ContainerTankOpeningModel copyWithNull({
    final bool userId = false,
    final bool containerId = false,
    final bool tankTypeId = false,
    final bool dealId = false,
    final bool serviceId = false,
    final bool id = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool user = false,
    final bool tank = false,
    final bool dealService = false,
  }) =>
      ContainerTankOpeningModel(
        userId: userId ? null : this.userId,
        containerId: containerId ? null : this.containerId,
        tankTypeId: tankTypeId ? null : this.tankTypeId,
        dealId: dealId ? null : this.dealId,
        serviceId: serviceId ? null : this.serviceId,
        id: id ? null : this.id,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        user: user ? null : this.user,
        tank: tank ? null : this.tank,
        dealService: dealService ? null : this.dealService,
        drops: drops,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (userId != null) 'user_id': userId,
        if (containerId != null) 'container_id': containerId,
        if (tankTypeId != null) 'tank_type_id': tankTypeId,
        if (dealId != null) 'deal_id': dealId,
        if (serviceId != null) 'service_id': serviceId,
        if (id != null) 'id': id,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (user != null) 'user': optionalUserConverter.toJson(user),
        if (tank != null) 'tank': optionalContainerTankConverter.toJson(tank),
        if (dealService != null)
          'deal_service': optionalDealServiceConverter.toJson(dealService),
        'drops': const IterableConverter<ContainerTankOpeningDropModel,
            Map<String, Object?>>(
          containerTankOpeningDropConverter,
        ).toJson(drops).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory ContainerTankOpeningModel.fromMap(final Map<String, Object?> map) =>
      ContainerTankOpeningModel(
        userId: map['user_id'] as int?,
        containerId: map['container_id'] as int?,
        tankTypeId: map['tank_type_id'] as int?,
        dealId: map['deal_id'] as int?,
        serviceId: map['service_id'] as int?,
        id: map['id'] as int?,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        user: optionalUserConverter
            .fromJson(map['user'] as Map<String, Object?>?),
        tank: optionalContainerTankConverter
            .fromJson(map['tank'] as Map<String, Object?>?),
        dealService: optionalDealServiceConverter
            .fromJson(map['deal_service'] as Map<String, Object?>?),
        drops: const IterableConverter<ContainerTankOpeningDropModel,
            Map<String, Object?>>(
          containerTankOpeningDropConverter,
        ).fromJson(
          (map['drops'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ContainerTankOpeningModel.fromJson(final String source) =>
      ContainerTankOpeningModel.fromMap(
        json.decode(source)! as Map<String, Object?>,
      );

  @override
  int compareTo(final ContainerTankOpeningModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ContainerTankOpeningModel &&
          other.userId == userId &&
          other.containerId == containerId &&
          other.tankTypeId == tankTypeId &&
          other.dealId == dealId &&
          other.serviceId == serviceId &&
          other.id == id;

  @override
  int get hashCode =>
      userId.hashCode ^
      containerId.hashCode ^
      tankTypeId.hashCode ^
      dealId.hashCode ^
      serviceId.hashCode ^
      id.hashCode;

  @override
  String toString() =>
      'ContainerTankOpeningModel(userId: $userId, containerId: $containerId, '
      'tankTypeId: $tankTypeId, dealId: $dealId, serviceId: $serviceId, '
      'id: $id, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, '
      'tank: $tank, dealService: $dealService, drops: $drops)';
}

/// The model of a ContainerTankOpeningDropModel.
@sealed
@immutable
class ContainerTankOpeningDropModel
    implements Comparable<ContainerTankOpeningDropModel> {
  /// The model of a ContainerTankOpeningDropModel.
  const ContainerTankOpeningDropModel({
    required this.volume,
    this.openingId,
    this.createdAt,
    this.updatedAt,
    this.opening,
  });

  /// The `opening_id` property of this [ContainerTankOpeningDropModel].
  final int? openingId;

  /// The `volume` property of this [ContainerTankOpeningDropModel].
  final int volume;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `opening` property of this [ContainerTankOpeningDropModel].
  final ContainerTankOpeningModel? opening;

  /// Return the copy of this model.
  ContainerTankOpeningDropModel copyWith({
    final int? openingId,
    final int? volume,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final ContainerTankOpeningModel? opening,
  }) =>
      ContainerTankOpeningDropModel(
        openingId: openingId ?? this.openingId,
        volume: volume ?? this.volume,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        opening: opening ?? this.opening,
      );

  /// Return the copy of this model with nullable fields.
  ContainerTankOpeningDropModel copyWithNull({
    final bool openingId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool opening = false,
  }) =>
      ContainerTankOpeningDropModel(
        openingId: openingId ? null : this.openingId,
        volume: volume,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        opening: opening ? null : this.opening,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (openingId != null) 'opening_id': openingId,
        'volume': volume,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (opening != null)
          'opening': optionalContainerTankOpeningConverter.toJson(opening),
      };

  /// Convert the map with string keys to this model.
  factory ContainerTankOpeningDropModel.fromMap(
    final Map<String, Object?> map,
  ) =>
      ContainerTankOpeningDropModel(
        openingId: map['opening_id'] as int?,
        volume: map['volume']! as int,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        opening: optionalContainerTankOpeningConverter
            .fromJson(map['opening'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory ContainerTankOpeningDropModel.fromJson(final String source) =>
      ContainerTankOpeningDropModel.fromMap(
        json.decode(source)! as Map<String, Object?>,
      );

  @override
  int compareTo(final ContainerTankOpeningDropModel other) =>
      openingId != null && other.openingId != null
          ? openingId!.compareTo(other.openingId!)
          : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is ContainerTankOpeningDropModel &&
          other.openingId == openingId &&
          other.volume == volume;

  @override
  int get hashCode => openingId.hashCode ^ volume.hashCode;

  @override
  String toString() =>
      'ContainerTankOpeningDropModel(openingId: $openingId, volume: $volume, '
      'createdAt: $createdAt, updatedAt: $updatedAt, opening: $opening)';
}

/// The model of a DeliveryModel.
@sealed
@immutable
class DeliveryModel implements Comparable<DeliveryModel> {
  /// The model of a DeliveryModel.
  const DeliveryModel({
    required this.latitude,
    required this.longtitude,
    this.ownerId,
    this.id,
    this.userId,
    this.addressId,
    this.timestamp,
    this.success,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.services = const Iterable<DeliveryServiceModel>.empty(),
  });

  /// The `owner_id` property of this [DeliveryModel].
  final int? ownerId;

  /// The `id` property of this [DeliveryModel].
  final int? id;

  /// The `user_id` property of this [DeliveryModel].
  final int? userId;

  /// The `latitude` property of this [DeliveryModel].
  final double latitude;

  /// The `longtitude` property of this [DeliveryModel].
  final double longtitude;

  /// The `address_id` property of this [DeliveryModel].
  final int? addressId;

  /// The `timestamp` property of this [DeliveryModel].
  final DateTime? timestamp;

  /// The `success` property of this [DeliveryModel].
  final bool? success;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `address` property of this [DeliveryModel].
  final AddressModel? address;

  /// The `services` property of this [DeliveryModel].
  final Iterable<DeliveryServiceModel> services;

  /// Return the copy of this model.
  DeliveryModel copyWith({
    final int? ownerId,
    final int? id,
    final int? userId,
    final double? latitude,
    final double? longtitude,
    final int? addressId,
    final DateTime? timestamp,
    final bool? success,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final AddressModel? address,
    final Iterable<DeliveryServiceModel>? services,
  }) =>
      DeliveryModel(
        ownerId: ownerId ?? this.ownerId,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        latitude: latitude ?? this.latitude,
        longtitude: longtitude ?? this.longtitude,
        addressId: addressId ?? this.addressId,
        timestamp: timestamp ?? this.timestamp,
        success: success ?? this.success,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        address: address ?? this.address,
        services: services ?? this.services,
      );

  /// Return the copy of this model with nullable fields.
  DeliveryModel copyWithNull({
    final bool ownerId = false,
    final bool id = false,
    final bool userId = false,
    final bool addressId = false,
    final bool timestamp = false,
    final bool success = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool address = false,
  }) =>
      DeliveryModel(
        ownerId: ownerId ? null : this.ownerId,
        id: id ? null : this.id,
        userId: userId ? null : this.userId,
        latitude: latitude,
        longtitude: longtitude,
        addressId: addressId ? null : this.addressId,
        timestamp: timestamp ? null : this.timestamp,
        success: success ? null : this.success,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        address: address ? null : this.address,
        services: services,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (ownerId != null) 'owner_id': ownerId,
        if (id != null) 'id': id,
        if (userId != null) 'user_id': userId,
        'latitude': latitude,
        'longtitude': longtitude,
        if (addressId != null) 'address_id': addressId,
        if (timestamp != null)
          'timestamp': optionalDateTimeConverter.toJson(timestamp),
        if (success != null) 'success': success,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (address != null)
          'address': optionalAddressConverter.toJson(address),
        'services':
            const IterableConverter<DeliveryServiceModel, Map<String, Object?>>(
          deliveryServiceConverter,
        ).toJson(services).toList(growable: false),
      };

  /// Convert the map with string keys to this model.
  factory DeliveryModel.fromMap(final Map<String, Object?> map) =>
      DeliveryModel(
        ownerId: map['owner_id'] as int?,
        id: map['id'] as int?,
        userId: map['user_id'] as int?,
        latitude: map['latitude']! as double,
        longtitude: map['longtitude']! as double,
        addressId: map['address_id'] as int?,
        timestamp:
            optionalDateTimeConverter.fromJson(map['timestamp'] as String?),
        success: map['success'] as bool?,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        address: optionalAddressConverter
            .fromJson(map['address'] as Map<String, Object?>?),
        services:
            const IterableConverter<DeliveryServiceModel, Map<String, Object?>>(
          deliveryServiceConverter,
        ).fromJson(
          (map['services'] as Iterable<Object?>? ??
                  const Iterable<Object?>.empty())
              .cast<Map<String, Object?>>(),
        ),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory DeliveryModel.fromJson(final String source) =>
      DeliveryModel.fromMap(json.decode(source)! as Map<String, Object?>);

  @override
  int compareTo(final DeliveryModel other) =>
      id != null && other.id != null ? id!.compareTo(other.id!) : 0;

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is DeliveryModel &&
          other.ownerId == ownerId &&
          other.id == id &&
          other.userId == userId &&
          other.latitude == latitude &&
          other.longtitude == longtitude &&
          other.addressId == addressId &&
          other.timestamp == timestamp &&
          other.success == success;

  @override
  int get hashCode =>
      ownerId.hashCode ^
      id.hashCode ^
      userId.hashCode ^
      latitude.hashCode ^
      longtitude.hashCode ^
      addressId.hashCode ^
      timestamp.hashCode ^
      success.hashCode;

  @override
  String toString() =>
      'DeliveryModel(ownerId: $ownerId, id: $id, userId: $userId, '
      'latitude: $latitude, longtitude: $longtitude, addressId: $addressId, '
      'timestamp: $timestamp, success: $success, createdAt: $createdAt, '
      'updatedAt: $updatedAt, address: $address, services: $services)';
}

/// The model of a DeliveryServiceModel.
@sealed
@immutable
class DeliveryServiceModel implements Comparable<DeliveryServiceModel> {
  /// The model of a DeliveryServiceModel.
  const DeliveryServiceModel({
    required this.amount,
    this.userId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.delivery,
    this.service,
  });

  /// The `user_id` property of this [DeliveryServiceModel].
  final int? userId;

  /// The `service_id` property of this [DeliveryServiceModel].
  final int? serviceId;

  /// The `amount` property of this [DeliveryServiceModel].
  final double amount;

  /// Set the date and time when the instance was created.
  final DateTime? createdAt;

  /// Set the date and time of the last time the instance was updated.
  final DateTime? updatedAt;

  /// The `delivery` property of this [DeliveryServiceModel].
  final DeliveryModel? delivery;

  /// The `service` property of this [DeliveryServiceModel].
  final ServiceModel? service;

  /// Return the copy of this model.
  DeliveryServiceModel copyWith({
    final int? userId,
    final int? serviceId,
    final double? amount,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DeliveryModel? delivery,
    final ServiceModel? service,
  }) =>
      DeliveryServiceModel(
        userId: userId ?? this.userId,
        serviceId: serviceId ?? this.serviceId,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        delivery: delivery ?? this.delivery,
        service: service ?? this.service,
      );

  /// Return the copy of this model with nullable fields.
  DeliveryServiceModel copyWithNull({
    final bool userId = false,
    final bool serviceId = false,
    final bool createdAt = false,
    final bool updatedAt = false,
    final bool delivery = false,
    final bool service = false,
  }) =>
      DeliveryServiceModel(
        userId: userId ? null : this.userId,
        serviceId: serviceId ? null : this.serviceId,
        amount: amount,
        createdAt: createdAt ? null : this.createdAt,
        updatedAt: updatedAt ? null : this.updatedAt,
        delivery: delivery ? null : this.delivery,
        service: service ? null : this.service,
      );

  /// Convert this model to map with string keys.
  Map<String, Object?> toMap() => <String, Object?>{
        if (userId != null) 'user_id': userId,
        if (serviceId != null) 'service_id': serviceId,
        'amount': amount,
        if (createdAt != null)
          'created_at': optionalDateTimeConverter.toJson(createdAt),
        if (updatedAt != null)
          'updated_at': optionalDateTimeConverter.toJson(updatedAt),
        if (delivery != null)
          'delivery': optionalDeliveryConverter.toJson(delivery),
        if (service != null)
          'service': optionalServiceConverter.toJson(service),
      };

  /// Convert the map with string keys to this model.
  factory DeliveryServiceModel.fromMap(final Map<String, Object?> map) =>
      DeliveryServiceModel(
        userId: map['user_id'] as int?,
        serviceId: map['service_id'] as int?,
        amount: map['amount']! as double,
        createdAt:
            optionalDateTimeConverter.fromJson(map['created_at'] as String?),
        updatedAt:
            optionalDateTimeConverter.fromJson(map['updated_at'] as String?),
        delivery: optionalDeliveryConverter
            .fromJson(map['delivery'] as Map<String, Object?>?),
        service: optionalServiceConverter
            .fromJson(map['service'] as Map<String, Object?>?),
      );

  /// Convert this model to a json string.
  String toJson() => json.encode(toMap());

  /// Convert the json string to this model.
  factory DeliveryServiceModel.fromJson(final String source) =>
      DeliveryServiceModel.fromMap(
        json.decode(source)! as Map<String, Object?>,
      );

  @override
  int compareTo(final DeliveryServiceModel other) {
    int value;
    if ((value = userId != null && other.userId != null
            ? userId!.compareTo(other.userId!)
            : 0) !=
        0) {
    } else if ((value = serviceId != null && other.serviceId != null
            ? serviceId!.compareTo(other.serviceId!)
            : 0) !=
        0) {}
    return value;
  }

  @override
  bool operator ==(final Object? other) =>
      identical(this, other) ||
      other is DeliveryServiceModel &&
          other.userId == userId &&
          other.serviceId == serviceId &&
          other.amount == amount;

  @override
  int get hashCode => userId.hashCode ^ serviceId.hashCode ^ amount.hashCode;

  @override
  String toString() =>
      'DeliveryServiceModel(userId: $userId, serviceId: $serviceId, '
      'amount: $amount, createdAt: $createdAt, updatedAt: $updatedAt, '
      'delivery: $delivery, service: $service)';
}

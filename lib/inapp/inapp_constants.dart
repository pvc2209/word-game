const bool kAutoConsume = true;

const String kConsumableId1 = 'item1';
const String kConsumableId2 = 'item2';
const String kConsumableId3 = 'item3';
const String kConsumableId4 = 'item4';
const String kConsumableId5 = 'item5';
const String kConsumableId6 = 'item6';
const String kConsumableId7 = 'item7';
const String kConsumableId8 = 'item8';
const String kConsumableId9 = 'item9';
const String kConsumableId10 = 'item10';

const String kUpgradeId1 = 'upgrade1';
const String kUpgradeId2 = 'upgrade2';
const String kUpgradeId3 = 'upgrade3';

const String kSilverSubscriptionId = 'subscription_silver';
const String kGoldSubscriptionId = 'subscription_gold';

const List<String> kConsumables = [
  kConsumableId1,
  kConsumableId2,
  kConsumableId3,
  kConsumableId4,
  kConsumableId5,
  kConsumableId6,
  kConsumableId7,
  kConsumableId8,
  kConsumableId9,
  kConsumableId10,
];

const List<String> kNonConsumables = [
  kUpgradeId1,
  kUpgradeId2,
  kUpgradeId3,
];

const List<String> kProductIds = <String>[
  ...kConsumables,
  // ...kNonConsumables,
  // kSilverSubscriptionId,
  // kGoldSubscriptionId,
];

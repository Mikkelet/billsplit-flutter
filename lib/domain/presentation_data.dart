import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';

List<Person> presentationPeople = [
  Person("0", "Michael F",
      pfpUrl:
          "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/FNE6L37WzQT0XNgPpXk0ei3oQDi2%2Fimage%3A1000002330?alt=media&token=76ca61f9-154b-4b48-a48d-fe1b32ef00d3"),
  Person("1", "Camilla M",
      pfpUrl:
          "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/8bmVH3ZBVxXUhSfzP9A0uoT1dbT2%2Fimage_picker_63F7DB73-F890-4327-9787-07650F272A2F-30189-0000053E6320C678.jpg?alt=media&token=fae40182-bc56-40ea-884c-d1181e1706b5"),
  Person("2", "John L",
      pfpUrl:
          "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/8bmVH3ZBVxXUhSfzP9A0uoT1dbT2%2Fimage_picker_5433ACB3-5566-40EB-970E-59AF98B803BA-522-00000076A6B4B48E.jpg?alt=media&token=48f652db-a7d6-4229-8386-bcb106ada56a"),
  Person("3", "May P",
      pfpUrl:
          "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/8bmVH3ZBVxXUhSfzP9A0uoT1dbT2%2Fimage_picker_66529ADD-A5D8-4D4E-A764-1CF8A818230B-36527-00000629C3FBB093.jpg?alt=media&token=e7c05858-18c6-47ce-bc84-531789ad1d76"),
  Person("4", "Kim W",
      pfpUrl:
          "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/8bmVH3ZBVxXUhSfzP9A0uoT1dbT2%2Fimage_picker_7B0FB04C-8EBC-4940-B3FB-AE2657E6D4E1-36527-0000062AF684B905.jpg?alt=media&token=affe1c1b-4099-49ec-b8ec-2afebefd236c"),
];

// GROUPS

List<Group> presentationGroups = [
  Group(
    id: "thailand",
    name: "Thailand",
    coverImageUrl:
        "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/RqqMGkpaD1gkwhdXge5I%2Fimage_picker_C5F14676-05D7-4B4C-B3B5-8B00C15CD187-79544-00000C0D252B3AAF.jpg?alt=media&token=62cc2573-4b95-4dba-bd9b-eea0cbe25e0a",
    people: tripToThailandPeople,
    pastMembers: [],
    invites: [],
    createdBy: tripToThailandPeople.first,
    timestamp: 1,
    lastUpdated: 1,
    defaultCurrency: "USD",
  ),
  Group(
    id: "home",
    name: "Home stuff",
    coverImageUrl:
        "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/4naxrLnpzT8WWKp0YTb5%2Fimage_picker_841A1A37-7F87-4530-A0FF-8130D5FE8A34-53967-00042EC02DC3CEF6.jpg?alt=media&token=93eba777-4bcc-4494-b9d5-9ac7a4261c74",
    people: homeStuffPeople,
    pastMembers: [],
    invites: [],
    createdBy: homeStuffPeople.first,
    timestamp: 4,
    lastUpdated: 2,
    defaultCurrency: "USD",
  ),
  Group(
    id: "hiking",
    name: "Let's go hiking!!",
    coverImageUrl:
        "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/Jz7luiby9l688u1UYJ1x%2Fimage_cropper_3634E549-D290-4EE1-9877-EF05AC32C24B-70232-00042F0F5C438242.jpg?alt=media&token=76d52b7e-9a1e-4d36-9878-ce004bae344f",
    people: hikingPeople,
    pastMembers: [],
    invites: [],
    createdBy: hikingPeople.first,
    timestamp: 3,
    lastUpdated: 3,
    defaultCurrency: "USD",
  ),
  Group(
    id: "bday",
    name: "Cam's bday party",
    coverImageUrl:
        "https://firebasestorage.googleapis.com/v0/b/billsplittapp.appspot.com/o/zfHbuP6Hmw1IEuA2dcr6%2Fimage_cropper_6E1F25A8-A62E-442C-822A-DDBA3540C141-80118-0004325CC6B9D177.jpg?alt=media&token=a87db8da-0ca3-447d-b0a1-c09df02b09af",
    people: bdayPartyPeople,
    pastMembers: [],
    invites: [],
    createdBy: bdayPartyPeople.first,
    timestamp: 2,
    lastUpdated: 4,
    defaultCurrency: "USD",
  ),
];

// HIKING

final List<Person> hikingPeople = presentationPeople;

final List<GroupExpense> hikingExpenses = [
  GroupExpense(
    id: "0",
    createdBy: hikingPeople.first,
    timestamp: 0,
    description: "Gas",
    sharedExpenses: [
      SharedExpense(
        expense: 18,
        participants: hikingPeople,
        description: "gas",
      )
    ],
    payer: hikingPeople.first,
    currency: Currency.USD(),
    tempParticipants: [],
    receiptImageUrl: "",
    date: DateTime.now(),
    syncState: SyncState.synced,
  ),
  GroupExpense(
    id: "1",
    createdBy: hikingPeople[1],
    timestamp: 0,
    description: "snacks for car trip",
    sharedExpenses: [
      SharedExpense(
        expense: 50,
        participants: hikingPeople,
        description: "",
      )
    ],
    payer: hikingPeople[1],
    currency: Currency.USD(),
    tempParticipants: [],
    receiptImageUrl: "",
    date: DateTime.now(),
    syncState: SyncState.synced,
  ),
  GroupExpense(
    id: "2",
    createdBy: hikingPeople[4],
    timestamp: 0,
    description: "Tent",
    sharedExpenses: [
      SharedExpense(
        expense: 300,
        participants: hikingPeople,
        description: "",
      )
    ],
    payer: hikingPeople[4],
    currency: Currency.USD(),
    tempParticipants: [],
    receiptImageUrl: "",
    date: DateTime.now(),
    syncState: SyncState.synced,
  ),
];

// HOME STUFF

final List<Person> homeStuffPeople = [
  presentationPeople[0],
  presentationPeople[1],
  presentationPeople[2],
];


final List<SubscriptionService> homeServices = [
  SubscriptionService(
    id: "0",
    name: "Rent",
    currency: "usd",
    createdBy: homeStuffPeople.first,
    imageUrl: "",
    monthlyExpense: 1500,
    payer: homeStuffPeople.first,
    participants: homeStuffPeople,
  ),
  SubscriptionService(
    id: "0",
    name: "Netflix",
    currency: "usd",
    createdBy: homeStuffPeople.first,
    imageUrl: "",
    monthlyExpense: 20,
    payer: homeStuffPeople[2],
    participants: homeStuffPeople,
  ),
  SubscriptionService(
    id: "0",
    name: "Monthly budget",
    currency: "usd",
    createdBy: homeStuffPeople.first,
    imageUrl: "",
    monthlyExpense: 600,
    payer: homeStuffPeople[1],
    participants: homeStuffPeople,
  ),
];

// CAMS SECRET BDAY PARTY

final List<Person> bdayPartyPeople = [
  presentationPeople[0],
  presentationPeople[2],
  presentationPeople[3],
  presentationPeople[4],
];

// ---- TRIP TO THAILAND ----

final List<Person> tripToThailandPeople = [
  presentationPeople[0],
  presentationPeople[3],
  presentationPeople[4],
];

final List<GroupExpense> thailandExpenses = [
  GroupExpense(
    id: "0",
    createdBy: hikingPeople[2],
    timestamp: 0,
    description: "noodle",
    sharedExpenses: [
      SharedExpense(
        expense: 150,
        participants: [tripToThailandPeople[1]],
        description: "Panang",
      ),
      SharedExpense(
        expense: 90,
        participants: [tripToThailandPeople[1]],
        description: "Drink",
      ),
      SharedExpense(
        expense: 150,
        participants: [tripToThailandPeople[2]],
        description: "noodle with duck",
      ),
      SharedExpense(
        expense: 50,
        participants: [tripToThailandPeople[2]],
        description: "water",
      ),
      SharedExpense(
        expense: 400,
        participants: tripToThailandPeople,
        description: "nuggest",
      ),
    ],
    payer: hikingPeople.first,
    currency: Currency(rate: 35.5, symbol: "thb"),
    tempParticipants: [],
    receiptImageUrl: "",
    date: DateTime.now(),
    syncState: SyncState.synced,
  ),
  GroupExpense(
    id: "1",
    createdBy: hikingPeople[1],
    timestamp: 0,
    description: "snacks for car trip",
    sharedExpenses: [
      SharedExpense(
        expense: 50,
        participants: tripToThailandPeople,
        description: "",
      )
    ],
    payer: hikingPeople.first,
    currency: Currency(rate: 35.5, symbol: "thb"),
    tempParticipants: [],
    receiptImageUrl: "",
    date: DateTime.now(),
    syncState: SyncState.synced,
  ),
  GroupExpense(
    id: "0",
    createdBy: hikingPeople[1],
    timestamp: 0,
    description: "Tent",
    sharedExpenses: [
      SharedExpense(
        expense: 300,
        participants: tripToThailandPeople,
        description: "",
      )
    ],
    payer: hikingPeople.first,
    currency: Currency(rate: 35.5, symbol: "thb"),
    tempParticipants: [],
    receiptImageUrl: "",
    date: DateTime.now(),
    syncState: SyncState.synced,
  ),
];

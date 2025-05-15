import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/data/event_data.dart';
import 'package:event_app/firebase_utils.dart';
import 'package:event_app/modals/event_model.dart';
import 'package:event_app/utils/toastUtils.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';

class EventProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filteredEventList = [];
  List<String> eventNameList = [];
  List<Event> favouriteEvents = [];
  List<String> getEventNameList(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return eventNameList = [
      localizations.all,
      localizations.sports,
      localizations.birthday,
      localizations.meeting,
      localizations.games,
      localizations.work_shop,
      localizations.book_club,
      localizations.exhibition,
      localizations.holiday,
      localizations.eating,
    ];
  }

  int selectedIndex = 0;

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();
    eventList = querySnapshot.docs.map((event) => event.data()).toList();
    filteredEventList = eventList;
    eventList
        .sort((event1, event2) => event1.dateTime.compareTo(event2.dateTime));
    notifyListeners();
  }

  void removeEvent(String id) async {
    // Remove from Firestore
    try {
      await FirebaseFirestore.instance
          .collection(Event.collectionName)
          .doc(id)
          .delete();
      print("Event deleted from Firestore");
      // Remove from local list
      eventList.removeWhere((event) => event.id == id);
      notifyListeners();
    } catch (e) {
      print("Failed to delete event: $e");
    }
  }

  // todo : function to get favourite events
  void getFavouriteEvents(String uId) {
    var querySnapshot = FirebaseUtils.getEventCollection(uId)
        .where('isFavourite', isEqualTo: true)
        .orderBy('dateTime')
        .get();
    querySnapshot.then((value) {
      favouriteEvents = value.docs.map((event) => event.data()).toList();
      notifyListeners();
    });
  }

  void filterEvents() {
    filteredEventList = eventList
        .where((event) =>
            event.eventName.toLowerCase() ==
            eventNameList[selectedIndex].toLowerCase())
        .toList();
    // todo sort all events
    filteredEventList
        .sort((event1, event2) => event1.dateTime.compareTo(event2.dateTime));

    notifyListeners();
  }

  void getFilterEventsFromFirbase(String uId) {
    var querySnapshot = FirebaseUtils.getEventCollection(uId)
        .where('eventName', isEqualTo: eventNameList[selectedIndex])
        .orderBy('dateTime')
        .get();
    querySnapshot.then((value) {
      filteredEventList = value.docs.map((event) => event.data()).toList();
      notifyListeners();
    });
  }

  void toggleFavourite(Event event, BuildContext context, String uId) async {
    final newValue = !event.isFavourite;
    event.isFavourite = newValue;
    notifyListeners();
    try {
      await FirebaseUtils.getEventCollection(uId).doc(event.id).update({
        'isFavourite': newValue,
      });

      ToastUtils.showSuccessToast(
          AppLocalizations.of(context)!.event_updated_successfully);

      if (selectedIndex == 0) getAllEvents(uId);

      getFavouriteEvents(uId);

      if (selectedIndex != 0) {
        getFilterEventsFromFirbase(uId);
      }
    } catch (e) {
      print("Error updating favourite: $e");
    }
  }

  void changeIndex(int index, String uId) {
    selectedIndex = index;
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFirbase(uId);
    getSelectedIndex();
    notifyListeners();
  }

  int getSelectedIndex() {
    return selectedIndex;
  }
}

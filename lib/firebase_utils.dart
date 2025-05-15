import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/modals/auth_model.dart';
import 'package:event_app/modals/event_model.dart';

class FirebaseUtils {
  // Create Event Collection
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<void> addEventToFirestore(Event event, String uId) {
    CollectionReference<Event> collectionName =
        getEventCollection(uId); //   Collection
    DocumentReference<Event> docRef = collectionName.doc(); // Document
    event.id = docRef.id; // auto id
    return docRef.set(event);
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFirestore(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromDb(String id) async {
    var querySnapshot = await getUsersCollection().doc(id).get();
    return querySnapshot.data();
  }
}

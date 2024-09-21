import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_homes_customer/core/models/tagging_form.dart';

class TaggingFormService {
  final CollectionReference taggingFormCollection =
      FirebaseFirestore.instance.collection('taggingForms');

  // Query a TaggingForm by clientPhoneNumber
  Future<TaggingForm?> findTaggingFormByPhoneNumber(
      String clientPhoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await taggingFormCollection
          .where('clientPhoneNumber', isEqualTo: clientPhoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming the phone number is unique and we get one result
        return TaggingForm.fromFirebase(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        print('No tagging form found for the provided phone number');
        return null;
      }
    } catch (e) {
      print('Error finding tagging form by phone number: $e');
      return null;
    }
  }

  // Add a new TaggingForm
  Future<String> addTaggingForm(TaggingForm taggingForm) async {
    String message = "";
    try {
      final oldTag = await findTaggingFormByPhoneNumber(
        taggingForm.clientPhoneNumber,
      );
      if (oldTag != null) {
        message = "found lead for this client";
      }

      await taggingFormCollection.add(taggingForm.toJson());
    } catch (e) {
      message = "Error adding tagging form: $e";
      print('Error adding tagging form: $e');
    }
    return message;
  }

  // Update an existing TaggingForm
  Future<void> updateTaggingForm(String docId, TaggingForm taggingForm) async {
    try {
      await taggingFormCollection.doc(docId).update(taggingForm.toJson());
    } catch (e) {
      print('Error updating tagging form: $e');
    }
  }

  // Get a single TaggingForm by its document ID
  Future<TaggingForm?> getTaggingForm(String docId) async {
    try {
      DocumentSnapshot docSnapshot =
          await taggingFormCollection.doc(docId).get();
      if (docSnapshot.exists) {
        return TaggingForm.fromFirebase(
            docSnapshot.data() as Map<String, dynamic>);
      } else {
        print('Tagging form not found');
        return null;
      }
    } catch (e) {
      print('Error getting tagging form: $e');
      return null;
    }
  }

  // Get all TaggingForms
  Future<List<TaggingForm>> getAllTaggingForms() async {
    try {
      QuerySnapshot querySnapshot = await taggingFormCollection.get();
      return querySnapshot.docs
          .map((doc) =>
              TaggingForm.fromFirebase(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting tagging forms: $e');
      return [];
    }
  }

  // Delete a TaggingForm
  Future<void> deleteTaggingForm(String docId) async {
    try {
      await taggingFormCollection.doc(docId).delete();
    } catch (e) {
      print('Error deleting tagging form: $e');
    }
  }
}

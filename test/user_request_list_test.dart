import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homevio/models/request_model.dart';
import 'package:homevio/utils/data_repo.dart';

void main () {
  test('Request Stream returns Stream containing List of Request objects', () async {
//Define parameters and objects

    final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

    final DataRepository dataRepository =
    DataRepository(firestore: fakeFirebaseFirestore);

    final CollectionReference mockCollectionReference =
    fakeFirebaseFirestore.collection(dataRepository.collection.path);

    final List<RequestModel> mockNoteList = [RequestModel()];

// Add data to mock Firestore collection
    for (RequestModel mockNote in mockNoteList) {
      await mockCollectionReference.add(mockNote.toMap());
    }

// Get data from DataRepository's noteStream i.e the method being tested
    final Stream<List<RequestModel>> noteStreamFromRepository =
    dataRepository.noteStream();

    final List<RequestModel> actualNoteList = await noteStreamFromRepository.first;

    final List<RequestModel> expectedNoteList = mockNoteList;

// Assert that the actual data matches the expected data
    expect(actualNoteList, expectedNoteList);
  });
}
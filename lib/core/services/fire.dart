import 'package:pulse/core/models/pulse_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static const collection = 'data';
  static const currentDoc = 'currentDoc';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> updatePulseData(PulseData pulse) async {
    try {
      await _firestore.collection(collection).doc(currentDoc).set(pulse.toJson());
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}

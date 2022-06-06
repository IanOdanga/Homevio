class RequestModel {
  String? uid;
  String? requestid;
  String? servicetype;
  String? location;
  String? providerName;
  int? roomTotal;

  RequestModel({this.uid, this.requestid, this.servicetype, this.location, this.providerName, this.roomTotal});

  factory RequestModel.fromMap(map) {
    return RequestModel(
      uid: map['uid'],
      requestid: map['requestid'],
      servicetype: map['servicetype'],
      location: map['location'],
      providerName: map['providerName'],
      roomTotal: map['roomTotal']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'requestid': requestid,
      'servicetype': servicetype,
      'location': location,
      'providerName': providerName,
      'roomTotal': roomTotal
    };
  }
}

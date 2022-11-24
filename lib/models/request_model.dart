class RequestModel {
  String name = "some";

  @override
  bool operator ==(Object other) => other is RequestModel && other.name == name;

  @override
  int get hashCode => name.hashCode;

  String? uid;
  String? requestid;
  String? servicetype;
  String? room;
  String? location;
  String? providerName;
  int? roomTotal;
  DateTime? dateRequested;
  String? status;
  double? price;

  RequestModel({this.uid, this.requestid, this.servicetype, this.location, this.providerName, this.roomTotal, this.dateRequested, this.room, this.status, this.price});

  factory RequestModel.fromMap(map) {
    return RequestModel(
      uid: map['uid'],
      requestid: map['requestid'],
      servicetype: map['servicetype'],
      room: map['room'],
      dateRequested: map['date requested'],
      location: map['location'],
      providerName: map['providerName'],
      roomTotal: map['roomTotal'],
      status: map['job status'],
      price: map['job cost']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'requestid': requestid,
      'servicetype': servicetype,
      'room': room,
      'date requested': dateRequested,
      'location': location,
      'providerName': providerName,
      'roomTotal': roomTotal,
      'job status': status,
      'job price': price
    };
  }
}

class LandModel {
  String? localId; // local unique id for drafts (timestamp or uuid)
  int? id; // server id (if returned by API)
  String? village;
  String? landArea;
  String? landType;
  String? status; // e.g. "draft", "submitted", "pending"
  // add more fields as needed

  LandModel({
    this.localId,
    this.id,
    this.village,
    this.landArea,
    this.landType,
    this.status,
  });

  factory LandModel.fromJson(Map<String, dynamic> json) => LandModel(
    localId: json['local_id']?.toString(),
    id: json['id'],
    village: json['village'] as String?,
    landArea: json['land_area']?.toString(),
    landType: json['land_type'] as String?,
    status: json['status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (localId != null) 'local_id': localId,
    if (id != null) 'id': id,
    'village': village ?? '',
    'land_area': landArea ?? '',
    'land_type': landType ?? '',
    'status': status ?? '',
  };
}

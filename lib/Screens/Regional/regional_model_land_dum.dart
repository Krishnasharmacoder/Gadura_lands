

class Datum {
  int? id;
  String? landId;
  FarmerDetails farmerDetails;
  LandLocation landLocation;
  LandDetails landDetails;
  DisputeDetails disputeDetails;
  GpsTracking gpsTracking;
  DocumentMedia documentMedia;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;

  Datum({
    this.id,
    this.landId,
    required this.farmerDetails,
    required this.landLocation,
    required this.landDetails,
    required this.disputeDetails,
    required this.gpsTracking,
    required this.documentMedia,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  // Factory constructor from JSON
  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'] as int?,
      landId: json['land_id'] as String?,
      farmerDetails: FarmerDetails.fromJson(json['farmer_details'] ?? {}),
      landLocation: LandLocation.fromJson(json['land_location'] ?? {}),
      landDetails: LandDetails.fromJson(json['land_details'] ?? {}),
      disputeDetails: DisputeDetails.fromJson(json['dispute_details'] ?? {}),
      gpsTracking: GpsTracking.fromJson(json['gps_tracking'] ?? {}),
      documentMedia: DocumentMedia.fromJson(json['document_media'] ?? {}),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString())
          : null,
      status: json['status'] as String?,
    );
  }
}

class FarmerDetails {
  String? name;
  String? phone;
  String? whatsappNumber;
  String? literacy;
  String? ageGroup;
  String? nature;
  String? landOwnership;
  String? mortgage;

  FarmerDetails({
    this.name,
    this.phone,
    this.whatsappNumber,
    this.literacy,
    this.ageGroup,
    this.nature,
    this.landOwnership,
    this.mortgage,
  });

  factory FarmerDetails.fromJson(Map<String, dynamic> json) {
    return FarmerDetails(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      whatsappNumber: json['whatsapp_number'] as String?,
      literacy: json['literacy'] as String?,
      ageGroup: json['age_group'] as String?,
      nature: json['nature'] as String?,
      landOwnership: json['land_ownership'] as String?,
      mortgage: json['mortgage'] as String?,
    );
  }
}

class LandLocation {
  String? state;
  String? district;
  String? mandal;
  String? village;
  String? location;

  LandLocation({
    this.state,
    this.district,
    this.mandal,
    this.village,
    this.location,
  });

  factory LandLocation.fromJson(Map<String, dynamic> json) {
    return LandLocation(
      state: json['state'] as String?,
      district: json['district'] as String?,
      mandal: json['mandal'] as String?,
      village: json['village'] as String?,
      location: json['location'] as String?,
    );
  }
}

class LandDetails {
  String? surveyNumber;
  String? landArea;
  String? guntas;
  double? pricePerAcre;
  double? totalLandPrice;
  String? landType;
  String? waterSource;
  String? garden;
  String? shedDetails;
  String? farmPond;
  String? residental;
  String? fencing;
  String? shed;

  LandDetails({
    this.surveyNumber,
    this.landArea,
    this.guntas,
    this.pricePerAcre,
    this.totalLandPrice,
    this.landType,
    this.waterSource,
    this.garden,
    this.shedDetails,
    this.farmPond,
    this.residental,
    this.fencing,
    this.shed,
  });

  factory LandDetails.fromJson(Map<String, dynamic> json) {
    return LandDetails(
      surveyNumber: json['survey_number'] as String?,
      landArea: json['land_area'] as String?,
      guntas: json['guntas'] as String?,
      pricePerAcre: (json['price_per_acre'] as num?)?.toDouble(),
      totalLandPrice: (json['total_land_price'] as num?)?.toDouble(),
      landType: json['land_type'] as String?,
      waterSource: json['water_source'] as String?,
      garden: json['garden'] as String?,
      shedDetails: json['shed_details'] as String?,
      farmPond: json['farm_pond'] as String?,
      residental: json['residental'] as String?,
      fencing: json['fencing'] as String?,
      shed: json['shed'] as String?,
    );
  }
}

class DisputeDetails {
  String? disputeType;
  String? siblingsInvolveInDispute;
  String? pathToLand;

  DisputeDetails({
    this.disputeType,
    this.siblingsInvolveInDispute,
    this.pathToLand,
  });

  factory DisputeDetails.fromJson(Map<String, dynamic> json) {
    return DisputeDetails(
      disputeType: json['dispute_type'] as String?,
      siblingsInvolveInDispute: json['siblings_involve_in_dispute'] as String?,
      pathToLand: json['path_to_land'] as String?,
    );
  }
}

class GpsTracking {
  String? latitude;
  String? longitude;
  String? roadPath;

  GpsTracking({
    this.latitude,
    this.longitude,
    this.roadPath,
  });

  factory GpsTracking.fromJson(Map<String, dynamic> json) {
    return GpsTracking(
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      roadPath: json['road_path'] as String?,
    );
  }
}

class DocumentMedia {
  String? passbookPhoto;
  List<String>? landPhotos;
  List<String>? landVideos;

  DocumentMedia({
    this.passbookPhoto,
    this.landPhotos,
    this.landVideos,
  });

  factory DocumentMedia.fromJson(Map<String, dynamic> json) {
    return DocumentMedia(
      passbookPhoto: json['passbook_photo'] as String?,
      landPhotos: (json['land_photos'] as List<dynamic>?)?.cast<String>(),
      landVideos: (json['land_videos'] as List<dynamic>?)?.cast<String>(),
    );
  }
}
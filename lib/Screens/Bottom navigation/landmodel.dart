// To parse this JSON data, do
//
//     final landModel = landModelFromJson(jsonString);

import 'dart:convert';

LandModel landModelFromJson(String str) => LandModel.fromJson(json.decode(str));

String landModelToJson(LandModel data) => json.encode(data.toJson());

class LandModel {
    String message;
    List<Datum> data;

    LandModel({
        required this.message,
        required this.data,
    });

    factory LandModel.fromJson(Map<String, dynamic> json) => LandModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String landId;
    LandLocation landLocation;
    FarmerDetails farmerDetails;
    LandDetails landDetails;
    GpsTracking gpsTracking;
    DisputeDetails disputeDetails;
    DocumentMedia documentMedia;

    Datum({
        required this.landId,
        required this.landLocation,
        required this.farmerDetails,
        required this.landDetails,
        required this.gpsTracking,
        required this.disputeDetails,
        required this.documentMedia,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        landId: json["land_id"],
        landLocation: LandLocation.fromJson(json["land_location"]),
        farmerDetails: FarmerDetails.fromJson(json["farmer_details"]),
        landDetails: LandDetails.fromJson(json["land_details"]),
        gpsTracking: GpsTracking.fromJson(json["gps_tracking"]),
        disputeDetails: DisputeDetails.fromJson(json["dispute_details"]),
        documentMedia: DocumentMedia.fromJson(json["document_media"]),
    );

    Map<String, dynamic> toJson() => {
        "land_id": landId,
        "land_location": landLocation.toJson(),
        "farmer_details": farmerDetails.toJson(),
        "land_details": landDetails.toJson(),
        "gps_tracking": gpsTracking.toJson(),
        "dispute_details": disputeDetails.toJson(),
        "document_media": documentMedia.toJson(),
    };
}

class DisputeDetails {
    String? disputeType;
    String? siblingsInvolveInDispute;
    String? pathToLand;

    DisputeDetails({
        required this.disputeType,
        required this.siblingsInvolveInDispute,
        required this.pathToLand,
    });

    factory DisputeDetails.fromJson(Map<String, dynamic> json) => DisputeDetails(
        disputeType: json["dispute_type"],
        siblingsInvolveInDispute: json["siblings_involve_in_dispute"],
        pathToLand: json["path_to_land"],
    );

    Map<String, dynamic> toJson() => {
        "dispute_type": disputeType,
        "siblings_involve_in_dispute": siblingsInvolveInDispute,
        "path_to_land": pathToLand,
    };
}

class DocumentMedia {
    List<String> landPhoto;
    List<String> landVideo;

    DocumentMedia({
        required this.landPhoto,
        required this.landVideo,
    });

    factory DocumentMedia.fromJson(Map<String, dynamic> json) => DocumentMedia(
        landPhoto: List<String>.from(json["land_photo"].map((x) => x)),
        landVideo: List<String>.from(json["land_video"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "land_photo": List<dynamic>.from(landPhoto.map((x) => x)),
        "land_video": List<dynamic>.from(landVideo.map((x) => x)),
    };
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
        required this.name,
        required this.phone,
        required this.whatsappNumber,
        required this.literacy,
        required this.ageGroup,
        required this.nature,
        required this.landOwnership,
        required this.mortgage,
    });

    factory FarmerDetails.fromJson(Map<String, dynamic> json) => FarmerDetails(
        name: json["name"],
        phone: json["phone"],
        whatsappNumber: json["whatsapp_number"],
        literacy: json["literacy"],
        ageGroup: json["age_group"],
        nature: json["nature"],
        landOwnership: json["land_ownership"],
        mortgage: json["mortgage"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "whatsapp_number": whatsappNumber,
        "literacy": literacy,
        "age_group": ageGroup,
        "nature": nature,
        "land_ownership": landOwnership,
        "mortgage": mortgage,
    };
}

class GpsTracking {
    String? roadPath;
    String? latitude;
    String? longitude;
    String? landBorder;

    GpsTracking({
        required this.roadPath,
        required this.latitude,
        required this.longitude,
        required this.landBorder,
    });

    factory GpsTracking.fromJson(Map<String, dynamic> json) => GpsTracking(
        roadPath: json["road_path"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        landBorder: json["land_border"],
    );

    Map<String, dynamic> toJson() => {
        "road_path": roadPath,
        "latitude": latitude,
        "longitude": longitude,
        "land_border": landBorder,
    };
}

class LandDetails {
    String? landArea;
    String? guntas;
    int? pricePerAcre;
    int? totalLandPrice;
    String? passbookPhoto;
    String? landType;
    String? waterSource;
    String? garden;
    String? shedDetails;
    String? farmPond;
    String? residental;
    String? fencing;

    LandDetails({
        required this.landArea,
        required this.guntas,
        required this.pricePerAcre,
        required this.totalLandPrice,
        required this.passbookPhoto,
        required this.landType,
        required this.waterSource,
        required this.garden,
        required this.shedDetails,
        required this.farmPond,
        required this.residental,
        required this.fencing,
    });

    factory LandDetails.fromJson(Map<String, dynamic> json) => LandDetails(
        landArea: json["land_area"],
        guntas: json["guntas"],
        pricePerAcre: json["price_per_acre"],
        totalLandPrice: json["total_land_price"],
        passbookPhoto: json["passbook_photo"],
        landType: json["land_type"],
        waterSource: json["water_source"],
        garden: json["garden"],
        shedDetails: json["shed_details"],
        farmPond: json["farm_pond"],
        residental: json["residental"],
        fencing: json["fencing"],
    );

    Map<String, dynamic> toJson() => {
        "land_area": landArea,
        "guntas": guntas,
        "price_per_acre": pricePerAcre,
        "total_land_price": totalLandPrice,
        "passbook_photo": passbookPhoto,
        "land_type": landType,
        "water_source": waterSource,
        "garden": garden,
        "shed_details": shedDetails,
        "farm_pond": farmPond,
        "residental": residental,
        "fencing": fencing,
    };
}

class LandLocation {
    String uniqueId;
    String state;
    String? district;
    String? mandal;
    String? village;
    String? location;
    String status;

    LandLocation({
        required this.uniqueId,
        required this.state,
        required this.district,
        required this.mandal,
        required this.village,
        required this.location,
        required this.status,
    });

    factory LandLocation.fromJson(Map<String, dynamic> json) => LandLocation(
        uniqueId: json["unique_id"],
        state: json["state"],
        district: json["district"],
        mandal: json["mandal"],
        village: json["village"],
        location: json["location"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "unique_id": uniqueId,
        "state": state,
        "district": district,
        "mandal": mandal,
        "village": village,
        "location": location,
        "status": status,
    };
}

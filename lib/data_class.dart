// ignore: camel_case_types
class cData {
  String cId;
  String cName;
  String cAddress;
  String cEmail;
  String cJob;
  String cQuote;
  String cAvatar;

  cData({
    required this.cId,
    required this.cName,
    required this.cAddress,
    required this.cEmail,
    required this.cJob,
    required this.cQuote,
    required this.cAvatar,
  });

  factory cData.fromJson(Map<String, dynamic> json) {
    return cData(
      cId: json['id'],
      cName: json['nama'],
      cAddress: json['alamat'],
      cEmail: json['email'],
      cJob: json['pekerjaan'],
      cQuote: json['quote'],
      cAvatar: json['avatar'],
    );
  }
}

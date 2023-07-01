class Files {
  bool? cv;
  bool? ijazah;
  bool? sertifikat;

  Files({this.cv, this.ijazah, this.sertifikat});

  Files.fromJson(Map<String, dynamic> json) {
    cv = json['cv'];
    ijazah = json['ijazah'];
    sertifikat = json['sertifikat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cv'] = this.cv;
    data['ijazah'] = this.ijazah;
    data['sertifikat'] = this.sertifikat;
    return data;
  }
}

class imageModel {
  final String filename;
  final String uploader;
  final String downloadUrl;
  final String uploadDate;
  final String saved;
  final List<String> SharedUsers;

  imageModel(
      this.filename,
      this.uploader,
      this.downloadUrl,
      this.uploadDate,
      this.saved,
      this.SharedUsers
      );

//   User.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         email = json['email'];
//
//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'email': email,
//   };
// }

}

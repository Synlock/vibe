// class UserSettings {
//   String categoryName;
//   int categoryIcon;

//   @override
//   bool operator ==(Object other) =>
//       other is UserSettings &&
//       (other.categoryName == categoryName ||
//           other.categoryIcon == categoryIcon);

//   @override
//   int get hashCode => categoryIcon.hashCode;

//   UserSettings({
//     required this.categoryName,
//     required this.categoryIcon,
//   });

//   UserSettings.fromJson(Map<String, dynamic> json)
//       : categoryName = json[] as String,
//         categoryIcon = json[] as int;

//   Map<String, dynamic> toJson() => {
//         : categoryName,
//         : categoryIcon,
//       };
// }

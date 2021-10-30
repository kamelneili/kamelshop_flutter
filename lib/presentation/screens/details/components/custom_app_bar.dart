// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../size_config.dart';

// class CustomAppBar extends PreferredSize {
//   double rating;

//   CustomAppBar({required this.rating});

//   @override
//   // AppBar().preferredSize.height provide us the height that appy on our app bar
//   Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//         child: Row(
//           children: [
//             SizedBox(
//               height: getProportionateScreenWidth(40),
//               width: getProportionateScreenWidth(40),
//               child: FlatButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(60),
//                 ),
//                 color: Colors.white,
//                 padding: EdgeInsets.zero,
//                 onPressed: () => Navigator.pop(context),
//                 child: SvgPicture.asset(
//                   "assets/icons/Back ICon.svg",
//                   height: 15,
//                 ),
//               ),
//             ),
//             Spacer(),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 children: [
//                   Text(
//                     "$rating",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   SvgPicture.asset("assets/icons/Star Icon.svg"),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   CustomAppBar copyWith({
//     double? rating,
//   }) {
//     return CustomAppBar(
//       rating: rating ?? this.rating,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'rating': rating,
//     };
//   }

//   factory CustomAppBar.fromMap(Map<String, dynamic> map) {
//     return CustomAppBar(
//       rating: map['rating'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CustomAppBar.fromJson(String source) =>
//       CustomAppBar.fromMap(json.decode(source));

//   @override
//   String toString() => 'CustomAppBar(rating: $rating)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is CustomAppBar && other.rating == rating;
//   }

//   @override
//   int get hashCode => rating.hashCode;
// }

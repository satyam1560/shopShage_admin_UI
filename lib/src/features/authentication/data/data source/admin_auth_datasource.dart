import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';

// class GetAdminAuth {
//   Future<void> getAdminAuth(CustomUser customUser) async {
//     UserCredential response =
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: CustomUser.email,
//       password: 'test123',
//     );
//     User? userCred = response.user;
//     bool isAuthorized = userCred != null;
//     List<CustomUser> adminLoginCred = [];

//     if (userCred != null) {
//       CustomUser customUser = CustomUser.fromJson({
//         'id': userCred.uid,
//         'email': userCred.email,
//       }, isAuthorized);

//       adminLoginCred.add(customUser);
// //navigate to next screen
//     } else {
//       isAuthorized = false;
//     }

//     return adminLoginCred;
//     // } on FirebaseAuthException catch (e) {
//     //   print('Authentication Error: ${e.code}');
//     // } catch (e) {
//     //   print('Error: $e');
//     // }

//     // return [];
//   }
// }
class GetAdminAuth {
  Future<bool> getAdminAuth(CustomUser customUser) async {
    try {
      UserCredential response =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: customUser.email!,
        password: customUser.password!,
      );
      User? userCred = response.user;

      print('userCred-----$userCred');
      bool isAuthorized = userCred != null ? true : false;
      print('isAuth----$isAuthorized');
      return isAuthorized;
    } on FirebaseAuthException catch (e) {
      print('Authentication Error: ${e.code}');
      return false;
    }
  }
}

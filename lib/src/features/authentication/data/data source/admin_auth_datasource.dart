import 'package:ecommerce/src/features/authentication/data/data%20source/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetAdminAuth {
  Future<List<CustomUser>> getAdminAuth() async {
    UserCredential response =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'satyam.20ch@gmail.com',
      password: 'test123',
    );
    User? userCred = response.user;
    bool isAuthorized = userCred != null;
    List<CustomUser> adminLoginCred = [];

    if (userCred != null) {
      CustomUser customUser = CustomUser.fromJson({
        'id': userCred.uid,
        'email': userCred.email,
      }, isAuthorized);

      adminLoginCred.add(customUser);
//navigate to next screen
    } else {
      isAuthorized = false;
    }

    return adminLoginCred;
    // } on FirebaseAuthException catch (e) {
    //   print('Authentication Error: ${e.code}');
    // } catch (e) {
    //   print('Error: $e');
    // }

    // return [];
  }
}

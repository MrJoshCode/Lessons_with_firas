import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_boxes/utility/preference_box.dart';

final intializeMainProviders = Provider.autoDispose(
  (ref) async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    ref.read(firstNameProvider.notifier).state =
        userData.data()?["firstName"] ?? "";
    ref.read(lastNameProvider.notifier).state =
        userData.data()?["lastName"] ?? "";
    ref.read(ageProvider.notifier).state = userData.data()?["age"] ?? "";
    ref.read(currentUserProvider.notifier).state = user;
    ref.read(appProvidersInitialized.notifier).state = true;
  },
);

final appProvidersInitialized = StateProvider<bool>((ref) => false);

final currentUserProvider = StateProvider<User?>((ref) => null);

final firstNameProvider = StateProvider<String>((ref) => "");

final lastNameProvider = StateProvider<String>((ref) => "");

final logoutToggleProvider = StateProvider<bool>(
    (ref) => PreferenceBox.getInstance().getConfirmLogoutToggle());

final ageProvider = StateProvider<String>((ref) => "");

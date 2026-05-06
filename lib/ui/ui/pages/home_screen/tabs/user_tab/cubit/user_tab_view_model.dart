import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/cache/shared_preference.dart';
import 'user_tab_states.dart';

@injectable
class UserTabViewModel extends Cubit<UserTabStates> {
  UserTabViewModel() : super(UserTabInitialState());

  final ImagePicker _picker = ImagePicker();
  File? profileImage;

  // متغيرات لحمل بيانات المستخدم القادمة من الكاش
  String? userName;
  String? userEmail;
  String? userPhone;

  static const String imageKey = "user_profile_image";

  /// جلب بيانات المستخدم (الاسم، الإيميل، الهاتف) من SharedPreference
  void getUserData() {
    userName = SharedPreference.getData(key: 'userName') as String?;
    userEmail = SharedPreference.getData(key: 'userEmail') as String?;
    userPhone = SharedPreference.getData(key: 'userPhone') as String?;

    // إرسال حالة لتحديث الواجهة بالبيانات الجديدة
    emit(UserDataLoadedState());
  }

  /// اختيار صورة من المعرض وحفظ مسارها
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      emit(UserTabLoadingState());

      profileImage = File(image.path);

      // حفظ المسار في الكاش ليبقى متاحاً عند إعادة فتح التطبيق
      await SharedPreference.saveData(
        key: imageKey,
        value: image.path,
      );

      emit(UserImageUpdatedState(image: profileImage!));
    } catch (e) {
      emit(UserTabErrorState(errorMessage: "حدث خطأ أثناء اختيار الصورة"));
    }
  }

  /// تحميل الصورة المحفوظة مسبقاً عند فتح الشاشة
  void loadImage() {
    final path = SharedPreference.getData(key: imageKey);

    if (path != null && path.toString().isNotEmpty) {
      profileImage = File(path.toString());

      // التأكد من أن الملف ما زال موجوداً في ذاكرة الهاتف
      if (profileImage!.existsSync()) {
        emit(UserImageUpdatedState(image: profileImage!));
      } else {
        // إذا حُذفت الصورة من الجهاز، نعود للحالة الابتدائية
        emit(UserTabInitialState());
      }
    }
  }

  // دالة لتحديث أي حقل (اسم، هاتف، إلخ)
  Future<void> updateUserData({required String key, required String newValue}) async {
    await SharedPreference.saveData(key: key, value: newValue);

    // إعادة جلب البيانات لتحديث المتغيرات (userName, userEmail, userPhone)
    getUserData();

    // إشعار الواجهة بالتغيير
    emit(UserDataLoadedState());
  }
}
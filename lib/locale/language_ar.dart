import '../configs.dart';
import 'languages.dart';

class LanguageAr extends BaseLanguage {
  @override
  String get tokenExpired => 'انتهت صلاحية الرمز المميز';

  @override
  String get badRequest => '400 طلب سىء';

  @override
  String get forbidden => '403 ممنوع';

  @override
  String get pageNotFound => '404: الصفحة غير موجودة';

  @override
  String get tooManyRequests => '429 : طلبات كثيرة جداً';

  @override
  String get internalServerError => '500: خطأ داخلي في الخادم';

  @override
  String get badGateway => '502 مدخل غير صالح';

  @override
  String get serviceUnavailable => '503 الخدمة غير متوفرة';

  @override
  String get gatewayTimeout => 'البوابة 504 انتهى الزمن';

  @override
  String get hey => 'يا';

  @override
  String get helloUser => 'مرحباً بالمستخدم!';

  @override
  String get createYourAccountFor => 'قم بإنشاء حسابك لتجربة أفضل';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get email => 'بريد إلكتروني';

  @override
  String get thisFieldIsRequired => 'هذه الخانة مطلوبه';

  @override
  String get contactNumber => 'رقم الاتصال';

  @override
  String get password => 'كلمة المرور';

  @override
  String get signUp => 'اشتراك';

  @override
  String get alreadyHaveAnAccount => 'هل لديك حساب؟';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get welcomeBack => 'مرحبًا بعودتك!';

  @override
  String get youHaveBeenMissed => 'لقد كنت في عداد المفقودين لفترة طويلة';

  @override
  String get rememberMe => 'تذكرنى';

  @override
  String get forgotPassword => 'هل نسيت كلمة السر؟';

  @override
  String get registerNow => 'سجل الان';

  @override
  String get or => 'أو';

  @override
  String get pleaseEnterValidOtp => 'الرجاء إدخال كلمة المرور الصحيحة (OTP).';

  @override
  String get otpVerification => 'التحقق من OTP';

  @override
  String get checkYourMailAnd => 'تحقق من بريدك وأدخل الرمز الذي تحصل عليه';

  @override
  String get didNotGetTheOtp => 'لم تحصل على OTP؟';

  @override
  String get resendOtp => 'إعادة إرسال كلمة المرور لمرة واحدة';

  @override
  String get verify => 'يؤكد';

  @override
  String get enterYourEmailAddress => 'أدخل عنوان بريدك الالكتروني';

  @override
  String get aResetPasswordLink => 'سيتم إرسال رابط إعادة تعيين كلمة المرور إلى عنوان البريد الإلكتروني الذي تم إدخاله أعلاه';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get areYouSureWantToPerformThisAction => 'هل أنت متأكد أنك تريد تنفيذ هذا الإجراء؟';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get gallery => 'صالة عرض';

  @override
  String get camera => 'آلة تصوير';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get update => 'تحديث';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get newPasswordsMustBeDifferent => 'يجب أن تكون كلمات المرور الجديدة مختلفة عن الكلمات السابقة';

  @override
  String get oldPassword => 'كلمة المرور القديمة';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get thePasswordDoesNotMatch => 'كلمة المرور غير متطابقة';

  @override
  String get reEnterPassword => 'إعادة إدخال كلمة المرور';

  @override
  String get confirm => 'يتأكد';

  @override
  String get pleaseLoginAgain => 'الرجاد الدخول على الحساب من جديد';

  @override
  String get loginSuccessfully => 'تم تسجيل الدخول بنجاح';

  @override
  String get noUserFound => 'لم يتم العثور على المستخدم';

  @override
  String get otpInvalidMessage => 'الرمز الذي تم إدخاله غير صالح، يرجى المحاولة مرة أخرى';

  @override
  String get pleaseContactWithAdmin => 'يرجى الاتصال مع المشرف';

  @override
  String get confirmOtp => 'تأكيد كلمة المرور لمرة واحدة';

  @override
  String get verified => 'تم التحقق';

  @override
  String get signInFailed => 'فشل تسجيل الدخول';

  @override
  String get appleSigInIsNotAvailable => 'Apple SignIn غير متاح لجهازك';

  @override
  String get emailAddressIsRequiredUpdateAppleAccount => 'عنوان البريد الإلكتروني مطلوب. يرجى تحديث البريد الإلكتروني في حساب Apple الخاص بك';

  @override
  String get yourPasswordReset => 'إعادة تعيين كلمة المرور الخاصة بك';

  @override
  String get yourAccountIsReady => 'حسابك جاهز للاستخدام. استمتع بمتخصصينا وخدماتنا';

  @override
  String get yourPassWorResetSuccessfully => 'تم إعادة تعيين كلمة المرور الخاصة بك بنجاح';

  @override
  String get done => 'منتهي';

  @override
  String get specialist => 'متخصص';

  @override
  String get date => 'تاريخ';

  @override
  String get time => 'وقت';

  @override
  String get payment => 'قسط';

  @override
  String get noDetailsFound => 'لم يتم العثور على تفاصيل';

  @override
  String get reload => 'إعادة تحميل';

  @override
  String get locationInformation => 'معلومات الموقع';

  @override
  String get name => 'اسم';

  @override
  String get address => 'عنوان';

  @override
  String get quickBookAppointment => 'حجز موعد سريع';

  @override
  String get service => 'خدمة';

  @override
  String get total => 'المجموع';

  @override
  String get bookNow => 'احجز الآن';

  @override
  String get pleaseSelectService => 'الرجاء اختيار الخدمة';

  @override
  String get confirmBooking => 'تأكيد الحجز';

  @override
  String get doYouWantToConfirmBooking => 'هل تريد تأكيد هذا الحجز؟';

  @override
  String get paymentDetails => 'بيانات الدفع';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get tip => 'نصيحة';

  @override
  String get discount => 'تخفيض';

  @override
  String get yourReview => 'مراجعتك';

  @override
  String get deleteReview => 'حذف المراجعة';

  @override
  String get doYouWantToDeleteReview => 'هل تريد حذف هذه المراجعة؟';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get rate => 'معدل';

  @override
  String get paymentMethod => 'طريقة الدفع او السداد';

  @override
  String get goToBookings => 'اذهب إلى الحجوزات';

  @override
  String get yourBookingFor => 'حجزك ل';

  @override
  String get bookingSuccessful => 'الحجز ناجح!';

  @override
  String get cashAfterService => 'النقد بعد الخدمة';

  @override
  String get razorpay => 'رازورباي';

  @override
  String get stripe => 'شريط';

  @override
  String get doWantToBookAppointment => 'هل تريد حجز هذا الموعد؟';

  @override
  String get noTimeSlots => 'لا فتحات الوقت';

  @override
  String get availableSlots => 'فتحات متاحة';

  @override
  String get next => 'التالي';

  @override
  String get pleaseSelectTimeSlotFirst => 'الرجاء تحديد الفترة الزمنية أولاً';

  @override
  String get chooseYourExpert => 'اختر الخبير الخاص بك';

  @override
  String get pleaseChooseYourExpert => 'الرجاء اختيار الخبير الخاص بك أولا';

  @override
  String get services => 'خدمات';

  @override
  String get cancelAppointment => 'إلغاء التعيين';

  @override
  String get doYouWantToCancelBooking => 'هل تريد إلغاء هذا الحجز؟';

  @override
  String get bookingInformation => 'معلومات الحجز';

  @override
  String get status => 'حالة';

  @override
  String get chooseBranch => 'اختر الفرع';

  @override
  String get noBranchFound => 'لم يتم العثور على فرع';

  @override
  String get doYouWantExplore => 'هل تريد الاستكشاف';

  @override
  String get nearbyBranches => 'الفروع القريبة';

  @override
  String get about => 'عن';

  @override
  String get reviews => 'التعليقات';

  @override
  String get staff => 'طاقم عمل';

  @override
  String get noServicesFound => 'لم يتم العثور على أي خدمات';

  @override
  String get noReviewsFound => 'لم يتم العثور على تعليقات';

  @override
  String get yourReviewsWillBeAppearedHere => 'ستظهر تعليقاتك هنا';

  @override
  String get call => 'يتصل';

  @override
  String get direction => 'اتجاه';

  @override
  String get noGalleryFound => 'لم يتم العثور على معرض';

  @override
  String get workingHours => 'ساعات العمل';

  @override
  String get ourCategory => 'فئتنا';

  @override
  String get noCategoryFound => 'لم يتم العثور على فئة';

  @override
  String get pressBackAgainToExitApp => 'اضغط مرة أخرى للخروج من التطبيق';

  @override
  String get home => 'بيت';

  @override
  String get booking => 'الحجز';

  @override
  String get notifications => 'إشعارات';

  @override
  String get user => 'مستخدم';

  @override
  String get profile => 'حساب تعريفي';

  @override
  String get setting => 'جلسة';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get theme => 'سمة';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get rateUs => 'قيمنا';

  @override
  String get share => 'يشارك';

  @override
  String get help => 'يساعد';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get tC => 'الشروط والأحكام';

  @override
  String get logout => 'تسجيل خروج';

  @override
  String get logoutYourAccount => 'تسجيل الخروج من حسابك';

  @override
  String get ohNoYouAreLeaving => 'أوه لا، أنت تغادر!';

  @override
  String get doYouWantToLogout => 'هل ترغب بالخروج؟';

  @override
  String get noNotifications => 'لا إشعارات';

  @override
  String get weLlNotifyYouOnce => 'سنقوم بإعلامك عندما يكون لدينا شيء لك';

  @override
  String get searchForServices => 'البحث عن الخدمات';

  @override
  String get searchServices => 'خدمات البحث';

  @override
  String get searchBooking => 'حجز البحث';

  @override
  String get topExperts => 'كبار الخبراء';

  @override
  String get theUserHasDeniedSpeechRecognition => 'رفض المستخدم استخدام التعرف على الكلام';

  @override
  String get category => 'فئة';

  @override
  String get kms => 'كيلومترات';

  @override
  String get fromYourLocation => 'من موقعك';

  @override
  String get noBookingsFound => 'لم يتم العثور على أي حجوزات';

  @override
  String get notAMember => 'ليس عضوا؟';

  @override
  String get noStaffFound => 'لم يتم العثور على طاقم العمل';

  @override
  String get contactInfo => 'معلومات الاتصال';

  @override
  String get noReviewsYetFor => 'لا توجد تعليقات حتى الآن ل';

  @override
  String get language => 'لغة';

  @override
  String get appTheme => 'موضوع التطبيق';

  @override
  String get termsConditions => 'البنود و الظروف';

  @override
  String get app => 'برنامج';

  @override
  String get light => 'ضوء';

  @override
  String get dark => 'مظلم';

  @override
  String get systemDefault => 'النظام الافتراضي';

  @override
  String get chooseTheme => 'اختيار موضوع';

  @override
  String get allServices => 'جميع الخدمات';

  @override
  String get searchFor => 'بحث عن';

  @override
  String get subCategories => 'الفئات الفرعية';

  @override
  String get clear => 'واضح';

  @override
  String get welcomeToThe => 'أهلا بك في';

  @override
  String get salon => 'صالون';

  @override
  String get weProvideYouBestServiceMessage => 'نحن نقدم لك أفضل الخدمات وأفضلها';

  @override
  String get userExperience => 'تجربة المستخدم';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get confirmed => 'مؤكد';

  @override
  String get cancelled => 'ألغيت';

  @override
  String get checkIn => 'تحقق في';

  @override
  String get checkOut => 'الدفع';

  @override
  String get completed => 'مكتمل';

  @override
  String get invalidUrl => 'URL غير صالح';

  @override
  String get enterYourReviewOptional => 'أدخل رأيك (اختياري)';

  @override
  String get cancel => 'يلغي';

  @override
  String get submit => 'يُقدِّم';

  @override
  String get ratingIsRequired => 'التقييم مطلوب';

  @override
  String get timeSlotBookedMessage => 'تم حجزه بالفعل! الرجاء اختيار فترة زمنية أخرى';

  @override
  String get branchName => 'اسم الفرع';

  @override
  String get place => 'مكان';

  @override
  String get basedOn => 'مرتكز على';

  @override
  String get review => 'مراجعة';

  @override
  String get s => 'س';

  @override
  String get error => 'خطأ:';

  @override
  String get externalWallet => 'المحفظة الخارجية:';

  @override
  String get userCancelled => 'تم إلغاء المستخدم';

  @override
  String get userNotFound => 'لم يتم العثور على المستخدم';

  @override
  String get dateIsRequired => 'التاريخ مطلوب';

  @override
  String get timeIsRequired => 'الوقت مطلوب';

  @override
  String get findYourNearestSalon => 'ابحث عن أقرب صالون لك';

  @override
  String get walkThrough1subTitle => 'يمكنك العثور بسهولة على أفضل حلاق وصالون بالقرب منك والاستمتاع بأفضل تجربة خدمة';

  @override
  String get pickAService => 'اختر خدمة';

  @override
  String get walkThrough2subTitle => 'يمكنك اختيار الخدمة الخاصة بك واختيار المختص الخاص بك والحصول على الحجز السريع';

  @override
  String get quickBooking => 'الحجز السريع';

  @override
  String get walkThrough3subTitle => 'يمكنك الحصول على أفضل الخدمات وأفضل متخصص في خدماتك لدينا';

  @override
  String get skip => 'يتخطى';

  @override
  String get getStarted => 'البدء';

  @override
  String get delete => 'يمسح';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get signInYourAccount => 'تسجيل الدخول إلى حسابك';

  @override
  String get deleteAccountConfirmation => 'سيتم حذف حسابك نهائيا. لن تتم استعادة بياناتك مرة أخرى.';

  @override
  String get dangerZone => 'منطقة الخطر';

  @override
  String get helloGuest => 'مرحبا، الضيف';

  @override
  String get signInWith => 'تسجيل الدخول ب';

  @override
  String get google => 'جوجل';

  @override
  String get apple => 'تفاحة';

  @override
  String get termsConditionsMessage => 'لقد قرأت إخلاء المسؤولية وأوافق على الشروط والأحكام';

  @override
  String get pleaseAcceptTermsAndConditions => 'يرجى قبول الشروط والأحكام';

  @override
  String get description => 'وصف';

  @override
  String get serviceNote => 'ملاحظة الخدمة';

  @override
  String get priceMayBeUpdated => 'قد يتم تحديث السعر';

  @override
  String get optionalDetails => 'تفاصيل اختيارية';

  @override
  String get reschedule => 'إعادة جدولة';

  @override
  String get priceDetails => 'تفاصيل الأسعار';

  @override
  String get transactionId => 'رقم المعاملة';

  @override
  String get paymentStatus => 'حالة السداد';

  @override
  String get paid => 'مدفوع';

  @override
  String get goBack => 'عُد';

  @override
  String get noStaffAvailableForBranchMessage => 'لا يوجد موظفين متاحين للخدمة المختارة!';

  @override
  String get tryToChangeYourService => 'حاول تغيير الخدمة الخاصة بك';

  @override
  String get pay => 'يدفع';

  @override
  String get open => 'يفتح';

  @override
  String get closed => 'مغلق';

  @override
  String get selectEmployeeFirst => 'حدد الموظف أولاً';

  @override
  String get yourBookingForHairBookingMessage => 'لقد تم حجز حجزك لقص الشعر بنجاح';

  @override
  String get back => 'خلف';

  @override
  String get taxIncluded => 'شامل الضريبة';

  @override
  String get demoUserCannotBeGrantedForThis => 'لا يمكن منح المستخدم التجريبي لهذا الإجراء';

  @override
  String get payNow => 'ادفع الآن';

  @override
  String get pleaseTryAgain => 'حاول مرة اخرى';

  @override
  String get somethingWentWrong => 'هناك خطأ ما';

  @override
  String get yourInternetIsNotWorking => 'الإنترنت الخاص بك لا يعمل';

  @override
  String get youCannotBookPrevious => 'لا يمكنك حجز فتحات سابقة';

  @override
  String get galleryWillBeAppearedHere => 'سوف يظهر المعرض هنا';

  @override
  String get goToBookingDetail => 'انتقل إلى تفاصيل الحجز';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage => 'تم دفع دفعتك بنجاح مع';

  @override
  String get paymentSuccessful => 'تم الدفع بنجاح!';

  @override
  String get edit => 'يحرر';

  @override
  String get bookingTimeSlotChangeMessage => 'هل تريد تغيير الفترة الزمنية لهذا الحجز؟';

  @override
  String get change => 'يتغير';

  @override
  String get profileUpdatedSuccessfully => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get oldPasswordDoesNotMatchMessage => 'كلمة المرور القديمة الخاصة بك غير صحيحة!';

  @override
  String get bookingSuccessfullyUpdateMessage => 'تم تحديث الحجز بنجاح';

  @override
  String get newUpdate => 'تحديث جديد';

  @override
  String get anUpdateToIs => 'يتوفر تحديث لتطبيق $APP_NAME. انتقل إلى متجر Play وقم بتنزيل الإصدار الجديد من التطبيق.';

  @override
  String get closeApp => 'إغلاق التطبيق';

  @override
  String get paystack => 'الراتب';

  @override
  String get paypal => 'باي بال';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get other => 'آخر';

  @override
  String get gender => 'جنس';

  @override
  String get pleaseSelectTheDateFirst => 'الرجاء تحديد التاريخ أولاً';

  @override
  String get thereAreNoBookings => 'لا توجد حجوزات مدرجة في الوقت الراهن. تتبع الحجوزات الخاصة بك هنا.';

  @override
  String get payWithFlutterwave => 'الدفع باستخدام Flutterwave';

  @override
  String get transactionFailed => 'فشل الاجراء';

  @override
  String get transactionCancelled => 'تم إلغاء المعاملة';

  @override
  String get flutterwave => 'موجة الرفرفة';

  @override
  String get paytm => 'بايتم';

  @override
  String get areYouSureYouWantToRemove => 'هل أنت متأكد أنك تريد إزالة هذا العنصر';

  @override
  String get remove => 'يزيل';

  @override
  String get you => 'أنت';

  @override
  String get veChanged => 'لقد تغيرت';

  @override
  String get quantityTo => 'الكمية ل';

  @override
  String get editAddress => 'تعديل العنوان';

  @override
  String get addNewAddress => 'إضافة عنوان جديد';

  @override
  String get selectCountry => 'حدد الدولة';

  @override
  String get selectState => 'اختر ولايه';

  @override
  String get selectCity => 'اختر مدينة';

  @override
  String get pincode => 'الرمز السري';

  @override
  String get addressLine => 'خط عنوان';

  @override
  String get writeAddressHere => 'اكتب العنوان هنا';

  @override
  String get writeLandmarkHere => 'اكتب المعالم هنا';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get save => 'يحفظ';

  @override
  String get cart => 'عربة التسوق';

  @override
  String get yourCartIsEmpty => 'عربة التسوق فارغة';

  @override
  String get thereAreCurrentlyNoItems => 'لا يوجد حاليا أي عناصر في سلة التسوق الخاصة بك. ابدأ بالتسوق وأضف العناصر إلى سلة التسوق الخاصة بك.';

  @override
  String get productPriceDetails => 'تفاصيل سعر المنتج';

  @override
  String get totalAmount => 'المبلغ الإجمالي';

  @override
  String get selectAddress => 'حدد العنوان';

  @override
  String get opps => 'انتبه';

  @override
  String get looksLikeYouHave => 'يبدو أنك لم تقم بإضافة أي عنوان بعد.';

  @override
  String get primary => 'أساسي';

  @override
  String get deliverHere => 'تسليم هنا';

  @override
  String get areYouSureYouWantToDelete => 'هل أنت متأكد أنك تريد حذف هذا العنوان';

  @override
  String get addressDeleteSuccessfully => 'تم حذف العنوان بنجاح';

  @override
  String get weAreNotShipping => 'نحن لا نقوم بالشحن إلى مدينتك الآن';

  @override
  String get deliveryCharge => 'رسوم التوصيل';

  @override
  String get orders => 'طلبات';

  @override
  String get seeYourOrders => 'انظر أوامرك';

  @override
  String get myAddresses => 'عناويني';

  @override
  String get manageYourAddresses => 'إدارة العناوين الخاصة بك';

  @override
  String get shop => 'محل';

  @override
  String get aboutProduct => 'حول المنتج';

  @override
  String get qty => 'الكمية';

  @override
  String get orderDetail => 'تفاصيل الطلب';

  @override
  String get orderDate => 'تاريخ الطلب';

  @override
  String get deliveredOn => 'تم التسليم';

  @override
  String get deliveryStatus => 'حالة التسليم';

  @override
  String get cancelOrder => 'الغاء الطلب';

  @override
  String get doYouWantToCancel => 'هل تريد إلغاء هذا الطلب';

  @override
  String get theOrderHasBeenCancelled => 'تم إلغاء الطلب بنجاح.';

  @override
  String get noOrdersFound => 'لم يتم العثور على أية طلبات';

  @override
  String get thereAreNoOrders => 'لا توجد أوامر مدرجة في الوقت الراهن. تتبع طلباتك هنا.';

  @override
  String get tax => 'ضريبة';

  @override
  String get shippingDetail => 'تفاصيل الشحن';

  @override
  String get alternativeContactNumber => 'رقم الاتصال البديل:';

  @override
  String get addReview => 'إضافة مراجعة';

  @override
  String get thanksYouForReview => 'شكرا لك على المراجعة!';

  @override
  String get selectUpToThreeImages => 'حدد ما يصل إلى ثلاث صور!';

  @override
  String get doYouWantToRemove => 'هل تريد إزالة هذه الصورة';

  @override
  String get addPhoto => 'إضافة صورة';

  @override
  String get customerDetail => 'تفاصيل العملاء';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get alternateContactNumber => 'رقم الاتصال البديل';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get shippingAddress => 'عنوان الشحن';

  @override
  String get off => 'عن';

  @override
  String get discountedAmount => 'المبلغ المخصوم';

  @override
  String get proceed => 'يتابع';

  @override
  String get productReviews => 'تعليقات المنتج';

  @override
  String get thanksForVoting => 'شكرا للتصويت';

  @override
  String get bestSellerProduct => 'أفضل منتج مبيعا';

  @override
  String get dealsForYou => 'عروض لك';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get featured => 'متميز';

  @override
  String get readMore => 'اقرأ أكثر';

  @override
  String get readLess => 'أقرأ أقل';

  @override
  String get brand => 'ماركة';

  @override
  String get inclusiveOfAllTaxes => 'شاملة لجميع الضرائب';

  @override
  String get outOfStock => 'إنتهى من المخزن';

  @override
  String get productSize => 'حجم المنتج';

  @override
  String get quantity => 'كمية';

  @override
  String get noRatingsYet => 'لا يوجد تقييم';

  @override
  String get ratingAndReviews => 'التقييم والمراجعات';

  @override
  String get totalReviewsAndRatings => 'إجمالي التقييمات والتقييمات';

  @override
  String get ourMostLoveChewTreats => 'حلوى المضغ الأكثر حبًا لدينا';

  @override
  String get allCategories => 'جميع الفئات';

  @override
  String get thereAreNoCategories => 'لا توجد فئات في الوقت الراهن. تتبع الفئات الخاصة بك هنا.';

  @override
  String get searchForProduct => 'البحث عن المنتج';

  @override
  String get atThisTimeThere => 'في هذا الوقت، لا توجد منتجات أو فئات متاحة';

  @override
  String get goToCart => 'اذهب إلى عربة التسوق';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get orderSuccessfullyPlaced => 'تم تقديم الطلب بنجاح';

  @override
  String get yorOrderHasBeen => 'لقد تم تقديم طلبك بنجاح';

  @override
  String get goToOrderList => 'انتقل إلى قائمة الطلبات';

  @override
  String get choosePaymentMethod => 'اختر وسيلة الدفع';

  @override
  String get chooseYourConvenientPayment => 'اختر خيار الدفع المناسب لك.';

  @override
  String get placeOrder => 'مكان الامر';

  @override
  String get confirmOrder => 'أكد الطلب';

  @override
  String get doYouConfirmThisPayment => 'هل تؤكد هذا الدفع';

  @override
  String get wishlist => 'قائمة الرغبات';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist => 'لا يوجد حاليا أي عناصر في قائمة الرغبات الخاصة بك. ابدأ بإضافة العناصر التي تحبها لحفظها لوقت لاحق.';

  @override
  String get price => 'سعر';

  @override
  String get productBrands => 'ماركات المنتجات';

  @override
  String get searchBrand => 'بحث عن العلامة التجارية';

  @override
  String get more => 'أكثر';

  @override
  String get rating => 'تقييم';

  @override
  String get weight => 'وزن';

  @override
  String get clearFilter => 'مرشح واضح';

  @override
  String get applyFilter => 'تطبيق الفلتر';

  @override
  String get orderPlaced => 'تم الطلب';

  @override
  String get processing => 'يعالج';

  @override
  String get delivered => 'تم التوصيل';

  @override
  String get unpaid => 'غير مدفوعة الأجر';

  @override
  String get parchasedProducts => 'منتجات بارشاسيد';

  @override
  String get productAmount => 'المبلغ المنتج';

  @override
  String get filterBy => 'مصنف بواسطة';

  @override
  String get bookingStatus => 'وضع الحجز';

  @override
  String get apply => 'يتقدم';

  @override
  String get searchOrder => 'ترتيب البحث';

  @override
  String get ciNetPay => 'cinet Pay';

  @override
  String get lblCheckOutWithCiNetPay => 'الخروج مع CinetPay';

  @override
  String get ciNetPayNotSupportedMessage => 'CinetPay غير مدعوم بعملاتك';

  @override
  String get totalAmountShouldBeMoreThan => 'يجب أن يكون المبلغ الإجمالي أكثر من';

  @override
  String get totalAmountShouldBeLessThan => 'يجب أن يكون المبلغ الإجمالي أقل من';

  @override
  String get yourPaymentFailedPleaseTryAgain => 'فشلت عملية الدفع يرجى المحاولة مرة أخرى';

  @override
  String get yourPaymentHasBeenMadeSuccessfully => 'لقد تم الدفع بنجاح';

  @override
  String get lblInvalidTransaction => 'المعاملة غير صالحة';

  @override
  String get accessDeniedContactYourAdmin => 'تم الرفض. اتصل بالمسؤول للحصول على المساعدة.';

  @override
  String get sadadPayment => 'سداد الدفع';

  @override
  String get topUpWallet => 'أعلى متابعة المحفظة';

  @override
  String get airtelMoneyPayment => 'ايرتل دفع المال';

  @override
  String get paymentSuccess => 'الدفع الناجح';

  @override
  String get redirectingToBookings => 'إعادة التوجيه للحجوزات..';

  @override
  String get transactionIsInProcess => 'الصفقة قيد التنفيذ...';

  @override
  String get pleaseCheckThePayment => 'يرجى التأكد من إرسال طلب الدفع إلى رقمك';

  @override
  String get enterYourMsisdnHere => 'أدخل msisdn الخاص بك هنا';

  @override
  String get theTransactionIsStill => 'لا تزال المعاملة قيد المعالجة وهي في حالة غامضة. يرجى إجراء الاستعلام عن المعاملة لجلب حالة المعاملة.';

  @override
  String get transactionIsSuccessful => 'عملية ناجحة';

  @override
  String get incorrectPinHasBeen => 'لقد تم إدخال رقم التعريف الشخصي بشكل غير صحيح';

  @override
  String get theUserHasExceeded => 'لقد تجاوز المستخدم حد المعاملات المسموح به في محفظته';

  @override
  String get theAmountUserIs => 'المبلغ الذي يحاول المستخدم تحويله أقل من الحد الأدنى المسموح به';

  @override
  String get userDidnTEnterThePin => 'لم يدخل المستخدم الرقم السري';

  @override
  String get transactionInPendingState => 'المعاملة في حالة معلقة. يرجى التحقق بعد وقت ما';

  @override
  String get userWalletDoesNot => 'لا تحتوي محفظة المستخدم على أموال كافية لتغطية المبلغ المستحق';

  @override
  String get theTransactionWasRefused => 'تم رفض الصفقة';

  @override
  String get thisIsAGeneric => 'هذا رفض عام له عدة أسباب محتملة';

  @override
  String get payeeIsAlreadyInitiated => 'لقد تم بالفعل بدء المستفيد في الإيقاف أو الحظر أو عدم التسجيل على منصة Airtel Money';

  @override
  String get theTransactionWasTimed => 'انتهت مهلة المعاملة.';

  @override
  String get theTransactionWasNot => 'لم يتم العثور على الصفقة.';

  @override
  String get xSignatureAndPayloadDid => 'توقيع x والحمولة غير متطابقين';

  @override
  String get encryptionKeyHasBeen => 'تم جلب مفتاح التشفير بنجاح';

  @override
  String get couldNotFetchEncryption => 'تعذر جلب مفتاح التشفير';

  @override
  String get transactionHasBeenExpired => 'لقد انتهت صلاحية المعاملة';

  @override
  String get ambiguous => 'غامض';

  @override
  String get success => 'نجاح';

  @override
  String get incorrectPin => 'رقم التعريف الشخصي غير صحيح';

  @override
  String get exceedsWithdrawalAmountLimitS => 'يتجاوز حد (حدود) مبلغ السحب / تم تجاوز حد مبلغ السحب';

  @override
  String get invalidAmount => 'مبلغ غير صحيح';

  @override
  String get transactionIdIsInvalid => 'معرف المعاملة غير صالح';

  @override
  String get inProcess => 'تحت المعالجة';

  @override
  String get notEnoughBalance => 'لا يوجد رصيد كافي';

  @override
  String get refused => 'رفض';

  @override
  String get doNotHonor => 'لا تتباهي';

  @override
  String get transactionNotPermittedTo => 'المعاملة غير مسموح بها للمدفوع لأمره';

  @override
  String get transactionTimedOut => 'انتهت مهلة المعاملة';

  @override
  String get transactionNotFound => 'لم يتم العثور على المعاملة';

  @override
  String get forBidden => 'مُحرَّم';

  @override
  String get successfullyFetchedEncryptionKey => 'تم جلب مفتاح التشفير بنجاح';

  @override
  String get errorWhileFetchingEncryption => 'حدث خطأ أثناء جلب مفتاح التشفير';

  @override
  String get transactionExpired => 'انتهت صلاحية المعاملة';

  @override
  String get btnSubmit => 'يُقدِّم';

  @override
  String get midTransPayment => 'ميدترانس الدفع';

  @override
  String get phonePe => 'الدفع عبر الهاتف';

  @override
  String get availableCoupons => 'القسائم المتاحة';

  @override
  String get youSaved => 'لقد قمت بالحفظ';

  @override
  String get couponIsRemoved => 'تمت إزالة القسيمة';

  @override
  String get pleaseSelectServices => 'الرجاء تحديد الخدمات';

  @override
  String get selectCoupon => 'حدد القسيمة';

  @override
  String get validTill => 'صالح حتى';

  @override
  String get useThisCodeToGet => 'استخدم هذا الرمز للحصول على';

  @override
  String get downloadInvoice => 'تحميل فاتورة';

  @override
  String get noCouponLeftIn => 'لم يتبق قسيمة في حسابك.';

  @override
  String get noCouponsAvailable => 'لا توجد كوبونات متاحة.';

  @override
  String get couponAppliedSuccessfully => 'تم تطبيق القسيمة بنجاح';

  @override
  String get pleaseAddCouponCode => 'الرجاء إضافة رمز القسيمة.';

  @override
  String get viewInvoice => 'عرض الفاتورة';

  @override
  String get finalTotal => 'المجموع النهائي';

  @override
  String get myDiscountCoupons => 'كوبونات الخصم الخاصة بي';

  @override
  String get coupons => 'كوبونات';

  @override
  String get valid => 'صالح';

  @override
  String get couponCodeCopied => 'تم نسخ رمز القسيمة';

  @override
  String get applyCoupon => 'تطبيق القسيمة';

  @override
  String get enterYourCode => 'ادخل رمزك';

  @override
  String get couponCode => 'رمز الكوبون';

  @override
  String get couponDiscount => 'خصم القسيمة';

  @override
  String get packages => 'طَرد';

  @override
  String get purchaseNow => 'شراء الآن';

  @override
  String get viewDetail => 'عرض التفاصيل';

  @override
  String get coupon => 'قسيمة';

  @override
  String get package => 'طَرد';

  @override
  String get yourPackage => 'مجموعتك';

  @override
  String get expiryIn => 'انتهاء الصلاحية في';

  @override
  String get packageExpiringSoon => 'تنتهي صلاحية الحزمة قريبًا';

  @override
  String get exclusiveYearLongSalonPamper => 'باقة تدليل الصالون الحصرية لمدة عام كامل';

  @override
  String get whatSIncluded => 'ما يحتويه';

  @override
  String get mins => 'دقيقة';

  @override
  String get reclaim => 'استعادة';

  @override
  String get selectedPackage => 'الحزمة المختارة';

  @override
  String get noPackagesFound => 'لم يتم العثور على أي حزم';

  @override
  String get yourExistingPackage => 'الحزمة الحالية الخاصة بك';

  @override
  String get viewAllPackages => 'عرض جميع الباقات';

  @override
  String get existingPackages => 'الحزم الموجودة';

  @override
  String get upgrade => 'يرقي';

  @override
  String get mo => 'شهر';

  @override
  String get days => 'أيام';

  @override
  String get yourPackageIsStillActive => 'الحزمة الخاصة بك لا تزال نشطة.';

  @override
  String get packagesAvailable => 'الحزم المتاحة';

  @override
  String get yourBookedServices => 'خدماتك المحجوزة:';

  @override
  String get reused => 'إعادة استخدامها';

  @override
  String get packageDetail => 'تفاصيل الحزمة';

  @override
  String get ourPackages => 'عروضنا';

  @override
  String get explore => 'يستكشف';

  @override
  String get myPackages => 'الحزم الخاصة بي';

  @override
  String get availablePackages => 'الحزم المتاحة';

  @override
  String get remainingQuantity => 'الكمية المتبقية';

  @override
  String get useNow => 'استخدم الان';

  @override
  String get removingPackage => 'هل تريد إزالة الحزمة؟';

  @override
  String get doYouWantTo => 'هل تريد إزالة هذه الحزمة والمتابعة';

  @override
  String get expiryBy => 'انتهاء الصلاحية بحلول';

  @override
  String get expiringToday => 'تنتهي صلاحيته اليوم';

  @override
  String get iHaveReadThe => 'لقد قرأت إخلاء المسؤولية وأوافق على ';

  @override
  String get theCouponAmountExceeds => 'قيمة الكوبون تتجاوز سعر الخدمة';

  @override
  String get night => 'ليلة';

  @override
  String get morning => 'صباح';

  @override
  String get afternoon => 'بعد الظهر';

  @override
  String get evening => 'مساء';

  @override
  String get newPasswordWarning => 'يجب ألا تكون كلمة المرور الجديدة هي نفس كلمة المرور القديمة';

  @override
  String get note => 'ملحوظة';

  @override
  String get setAsPrimary => 'تعيين كأساسي';

  @override
  String get orderInvoice => 'فاتورة الطلب';

  @override
  String get logisticPartner => 'الشريك اللوجستي';

  @override
  String get logisticContactNumber => 'رقم الاتصال اللوجستي';

  @override
  String get logisticAddress => 'العنوان اللوجستي';

  @override
  String get wouldYouLikeToDownloadTheInvoice => 'هل ترغب في تنزيل الفاتورة؟';

  @override
  String get download => 'تحميل';

  @override
  String get failedToAccessExternalStorage => 'فشل في الوصول إلى وحدة التخزين الخارجية';

  @override
  String get invalidResponseOrLinkNotFound => 'استجابة غير صالحة أو لم يتم العثور على الرابط';

  @override
  String get failedToFetchInvoiceDetails => 'فشل جلب تفاصيل الفاتورة';

  @override
  String get PayWithUpiApps => 'الدفع باستخدام تطبيقات Upi';

  @override
  String get PaywithCard => 'الدفع بالبطاقة';

  @override
  String get ContactUsForAnyQuestionsOnYourOrder => 'اتصل بنا بخصوص أي أسئلة بخصوص طلبك';

  @override
  String get ThePaymentTransactionDescription => 'وصف معاملة الدفع';

  @override
  String get FAQs => 'الأسئلة الشائعة';

  @override
  String get noServicesAvailable => 'لا توجد خدمات متاحة';
}

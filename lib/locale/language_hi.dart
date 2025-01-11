import '../configs.dart';
import 'languages.dart';

class LanguageHi extends BaseLanguage {
  @override
  String get tokenExpired => 'टोकन समाप्त हो गया';

  @override
  String get badRequest => '400 गलत अनुरोध';

  @override
  String get forbidden => '403 निषिद्ध';

  @override
  String get pageNotFound => '404 पृष्ठ नहीं मिला';

  @override
  String get tooManyRequests => '429: बहुत अधिक अनुरोध';

  @override
  String get internalServerError => '500 आंतरिक सर्वर त्रुटि';

  @override
  String get badGateway => '502 खराब गेटवे';

  @override
  String get serviceUnavailable => '503 सेवा उपलब्ध नहीं';

  @override
  String get gatewayTimeout => '504 गेटवे समय समाप्त';

  @override
  String get hey => 'अरे';

  @override
  String get helloUser => 'नमस्ते उपयोगकर्ता!';

  @override
  String get createYourAccountFor => 'बेहतर अनुभव के लिए अपना खाता बनाएं';

  @override
  String get firstName => 'पहला नाम';

  @override
  String get lastName => 'उपनाम';

  @override
  String get email => 'ईमेल';

  @override
  String get thisFieldIsRequired => 'यह फ़ील्ड आवश्यक है';

  @override
  String get contactNumber => 'संपर्क संख्या';

  @override
  String get password => 'पासवर्ड';

  @override
  String get signUp => 'साइन अप करें';

  @override
  String get alreadyHaveAnAccount => 'क्या आपके पास पहले से एक खाता मौजूद है?';

  @override
  String get signIn => 'दाखिल करना';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है!';

  @override
  String get youHaveBeenMissed => 'आप लंबे समय से याद आ रहे हैं';

  @override
  String get rememberMe => 'मुझे याद करो';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get registerNow => 'अभी पंजीकरण करें';

  @override
  String get or => 'या';

  @override
  String get pleaseEnterValidOtp => 'कृपया वैध ओटीपी दर्ज करें';

  @override
  String get otpVerification => 'ओटीपी सत्यापन';

  @override
  String get checkYourMailAnd => 'अपना मेल जांचें और जो कोड मिले उसे दर्ज करें';

  @override
  String get didNotGetTheOtp => 'ओटीपी नहीं मिला?';

  @override
  String get resendOtp => 'ओटीपी पुनः भेजें';

  @override
  String get verify => 'सत्यापित करें';

  @override
  String get enterYourEmailAddress => 'अपना ईमेल पता दर्ज करें';

  @override
  String get aResetPasswordLink => 'उपरोक्त दर्ज ईमेल पते पर एक रीसेट पासवर्ड लिंक भेजा जाएगा';

  @override
  String get resetPassword => 'पासवर्ड रीसेट';

  @override
  String get areYouSureWantToPerformThisAction => 'क्या आप वाकई यह क्रिया करना चाहते हैं?';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get gallery => 'गैलरी';

  @override
  String get camera => 'कैमरा';

  @override
  String get editProfile => 'प्रोफ़ाइल संपादित करें';

  @override
  String get update => 'अद्यतन';

  @override
  String get changePassword => 'पासवर्ड बदलें';

  @override
  String get newPasswordsMustBeDifferent => 'नये पासवर्ड पिछले पासवर्ड से भिन्न होने चाहिए';

  @override
  String get oldPassword => 'पुराना पासवर्ड';

  @override
  String get newPassword => 'नया पासवर्ड';

  @override
  String get thePasswordDoesNotMatch => 'पासवर्ड मेल नहीं खाता';

  @override
  String get reEnterPassword => 'पासवर्ड फिर से दर्ज करें';

  @override
  String get confirm => 'पुष्टि करना';

  @override
  String get pleaseLoginAgain => 'कृपया फिर भाग लें';

  @override
  String get loginSuccessfully => 'सफलतापूर्वक लॉगिन करें';

  @override
  String get noUserFound => 'कोई उपयोगकर्ता नहीं मिला';

  @override
  String get otpInvalidMessage => 'दर्ज किया गया कोड अमान्य है, कृपया पुनः प्रयास करें';

  @override
  String get pleaseContactWithAdmin => 'कृपया व्यवस्थापक से संपर्क करें';

  @override
  String get confirmOtp => 'ओटीपी की पुष्टि करें';

  @override
  String get verified => 'सत्यापित';

  @override
  String get signInFailed => 'भाग लेना विफल हुआ';

  @override
  String get appleSigInIsNotAvailable => 'Apple साइन इन आपके डिवाइस के लिए उपलब्ध नहीं है';

  @override
  String get emailAddressIsRequiredUpdateAppleAccount => 'ईमेल पते की ज़रुरत है। कृपया अपने Apple खाते में ईमेल अपडेट करें';

  @override
  String get yourPasswordReset => 'आपका पासवर्ड रीसेट हो गया';

  @override
  String get yourAccountIsReady => 'आपका खाता उपयोग के लिए तैयार है. हमारे विशेषज्ञ और हमारी सेवाओं का आनंद लें';

  @override
  String get yourPassWorResetSuccessfully => 'आपका पासवर्ड सफलतापूर्वक रीसेट हो गया';

  @override
  String get done => 'हो गया';

  @override
  String get specialist => 'SPECIALIST';

  @override
  String get date => 'तारीख';

  @override
  String get time => 'समय';

  @override
  String get payment => 'भुगतान';

  @override
  String get noDetailsFound => 'कोई विवरण नहीं मिला';

  @override
  String get reload => 'पुनः लोड करें';

  @override
  String get locationInformation => 'स्थिति सूचना';

  @override
  String get name => 'नाम';

  @override
  String get address => 'पता';

  @override
  String get quickBookAppointment => 'शीघ्र बुक अपॉइंटमेंट';

  @override
  String get service => 'सेवा';

  @override
  String get total => 'कुल';

  @override
  String get bookNow => 'अभी बुक करें';

  @override
  String get pleaseSelectService => 'कृपया सेवा चुनें';

  @override
  String get confirmBooking => 'बुकिंग की पुष्टि करें';

  @override
  String get doYouWantToConfirmBooking => 'क्या आप इस बुकिंग की पुष्टि करना चाहते हैं?';

  @override
  String get paymentDetails => 'भुगतान विवरण';

  @override
  String get subtotal => 'उप-योग';

  @override
  String get tip => 'बख्शीश';

  @override
  String get discount => 'छूट';

  @override
  String get yourReview => 'आपकी समीक्षा';

  @override
  String get deleteReview => 'समीक्षा हटाएँ';

  @override
  String get doYouWantToDeleteReview => 'क्या आप यह समीक्षा हटाना चाहते हैं?';

  @override
  String get viewAll => 'सभी को देखें';

  @override
  String get rate => 'दर';

  @override
  String get paymentMethod => 'भुगतान विधि';

  @override
  String get goToBookings => 'बुकिंग पर जाएं';

  @override
  String get yourBookingFor => 'के लिए आपकी बुकिंग';

  @override
  String get bookingSuccessful => 'बुकिंग सफल!';

  @override
  String get cashAfterService => 'सेवा के बाद नकद';

  @override
  String get razorpay => 'रेज़रपे';

  @override
  String get stripe => 'पट्टी';

  @override
  String get doWantToBookAppointment => 'क्या आप यह अपॉइंटमेंट बुक करना चाहते हैं?';

  @override
  String get noTimeSlots => 'कोई टाइम स्लॉट नहीं';

  @override
  String get availableSlots => 'उपलब्ध स्लॉट';

  @override
  String get next => 'अगला';

  @override
  String get pleaseSelectTimeSlotFirst => 'कृपया पहले टाइम स्लॉट चुनें';

  @override
  String get chooseYourExpert => 'अपना विशेषज्ञ चुनें';

  @override
  String get pleaseChooseYourExpert => 'कृपया पहले अपना विशेषज्ञ चुनें';

  @override
  String get services => 'सेवाएं';

  @override
  String get cancelAppointment => 'अपॉइंटमेंट रद्द करें';

  @override
  String get doYouWantToCancelBooking => 'क्या आप यह बुकिंग रद्द करना चाहते हैं?';

  @override
  String get bookingInformation => 'बुकिंग जानकारी';

  @override
  String get status => 'स्थिति';

  @override
  String get chooseBranch => 'शाखा चुनें';

  @override
  String get noBranchFound => 'कोई शाखा नहीं मिली';

  @override
  String get doYouWantExplore => 'क्या आप अन्वेषण करना चाहते हैं?';

  @override
  String get nearbyBranches => 'निकटवर्ती शाखाएँ';

  @override
  String get about => 'के बारे में';

  @override
  String get reviews => 'समीक्षा';

  @override
  String get staff => 'कर्मचारी';

  @override
  String get noServicesFound => 'कोई सेवा नहीं मिली';

  @override
  String get noReviewsFound => 'कोई समीक्षा नहीं मिली';

  @override
  String get yourReviewsWillBeAppearedHere => 'आपकी समीक्षाएं यहां दिखाई जाएंगी';

  @override
  String get call => 'पुकारना';

  @override
  String get direction => 'दिशा';

  @override
  String get noGalleryFound => 'कोई गैलरी नहीं मिली';

  @override
  String get workingHours => 'कार्य के घंटे';

  @override
  String get ourCategory => 'हमारी श्रेणी';

  @override
  String get noCategoryFound => 'कोई श्रेणी नहीं मिली';

  @override
  String get pressBackAgainToExitApp => 'ऐप से बाहर निकलने के लिए दोबारा वापस दबाएँ';

  @override
  String get home => 'घर';

  @override
  String get booking => 'बुकिंग';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get user => 'उपयोगकर्ता';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get setting => 'सेटिंग';

  @override
  String get appLanguage => 'ऐप भाषा';

  @override
  String get theme => 'विषय';

  @override
  String get aboutApp => 'ऐप के बारे में';

  @override
  String get rateUs => 'हमें रेटिंग दें';

  @override
  String get share => 'शेयर करना';

  @override
  String get help => 'मदद';

  @override
  String get helpCenter => 'सहायता केंद्र';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get tC => 'नियम एवं शर्तें';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get logoutYourAccount => 'अपना खाता लॉगआउट करें';

  @override
  String get ohNoYouAreLeaving => 'अरे नहीं, आप जा रहे हैं!';

  @override
  String get doYouWantToLogout => 'क्या आप लॉगआउट करना चाहते हैं?';

  @override
  String get noNotifications => 'कोई सूचनाएं नहीं';

  @override
  String get weLlNotifyYouOnce => 'जब हमारे पास आपके लिए कुछ होगा तो हम आपको सूचित करेंगे';

  @override
  String get searchForServices => 'सेवाएँ खोजें';

  @override
  String get searchServices => 'खोज सेवाएँ';

  @override
  String get searchBooking => 'बुकिंग खोजें';

  @override
  String get topExperts => 'शीर्ष विशेषज्ञ';

  @override
  String get theUserHasDeniedSpeechRecognition => 'उपयोगकर्ता ने वाक् पहचान के उपयोग से इनकार किया है';

  @override
  String get category => 'वर्ग';

  @override
  String get kms => 'कि.मी.';

  @override
  String get fromYourLocation => 'आपके स्थान से';

  @override
  String get noBookingsFound => 'कोई बुकिंग नहीं मिली';

  @override
  String get notAMember => 'सदस्य नहीं हैं?';

  @override
  String get noStaffFound => 'कोई स्टाफ नहीं मिला';

  @override
  String get contactInfo => 'संपर्क सूचना';

  @override
  String get noReviewsYetFor => 'के लिए अभी तक कोई समीक्षा नहीं';

  @override
  String get language => 'भाषा';

  @override
  String get appTheme => 'ऐप थीम';

  @override
  String get termsConditions => 'नियम एवं शर्तें';

  @override
  String get app => 'अनुप्रयोग';

  @override
  String get light => 'रोशनी';

  @override
  String get dark => 'अँधेरा';

  @override
  String get systemDefault => 'प्रणालीगत चूक';

  @override
  String get chooseTheme => 'थीम चुनें';

  @override
  String get allServices => 'सभी सेवाएँ';

  @override
  String get searchFor => 'निम्न को खोजें';

  @override
  String get subCategories => 'उपश्रेणियाँ';

  @override
  String get clear => 'स्पष्ट';

  @override
  String get welcomeToThe => 'आपका स्वागत है';

  @override
  String get salon => 'सैलून';

  @override
  String get weProvideYouBestServiceMessage => 'हम आपको सर्वोत्तम और सर्वश्रेष्ठ सेवाएँ प्रदान करते हैं';

  @override
  String get userExperience => 'प्रयोगकर्ता का अनुभव';

  @override
  String get createAccount => 'खाता बनाएं';

  @override
  String get pending => 'लंबित';

  @override
  String get confirmed => 'की पुष्टि';

  @override
  String get cancelled => 'रद्द';

  @override
  String get checkIn => 'चेक इन';

  @override
  String get checkOut => 'चेक आउट';

  @override
  String get completed => 'पुरा होना।';

  @override
  String get invalidUrl => 'असामान्य यूआरएल';

  @override
  String get enterYourReviewOptional => 'अपनी समीक्षा दर्ज करें (वैकल्पिक)';

  @override
  String get cancel => 'रद्द करना';

  @override
  String get submit => 'जमा करना';

  @override
  String get ratingIsRequired => 'रेटिंग आवश्यक है';

  @override
  String get timeSlotBookedMessage => 'पहले से ही बुक है! कृपया कोई अन्य टाइमस्लॉट चुनें';

  @override
  String get branchName => 'शाखा का नाम';

  @override
  String get place => 'जगह';

  @override
  String get basedOn => 'पर आधारित';

  @override
  String get review => 'समीक्षा';

  @override
  String get s => 'एस';

  @override
  String get error => 'गलती:';

  @override
  String get externalWallet => 'बाहरी बटुआ:';

  @override
  String get userCancelled => 'उपयोगकर्ता रद्द कर दिया गया';

  @override
  String get userNotFound => 'उपयोगकर्ता नहीं मिला';

  @override
  String get dateIsRequired => 'दिनांक आवश्यक है';

  @override
  String get timeIsRequired => 'समय की आवश्यकता है';

  @override
  String get findYourNearestSalon => 'अपना निकटतम सैलून ढूंढें';

  @override
  String get walkThrough1subTitle => 'आप आसानी से अपने नजदीक सर्वश्रेष्ठ नाई और सैलून ढूंढ सकते हैं और सर्वोत्तम सेवा अनुभव का आनंद ले सकते हैं';

  @override
  String get pickAService => 'एक सेवा चुनें';

  @override
  String get walkThrough2subTitle => 'आप अपनी सेवा चुन सकते हैं और अपना विशेषज्ञ चुन सकते हैं और त्वरित बुकिंग प्राप्त कर सकते हैं';

  @override
  String get quickBooking => 'त्वरित बुकिंग';

  @override
  String get walkThrough3subTitle => 'आपको हमारी सर्वोत्तम सेवाएँ और आपकी सेवाओं के सर्वोत्तम विशेषज्ञ मिलेंगे';

  @override
  String get skip => 'छोडना';

  @override
  String get getStarted => 'शुरू हो जाओ';

  @override
  String get delete => 'मिटाना';

  @override
  String get deleteAccount => 'खाता हटा दो';

  @override
  String get signInYourAccount => 'अपने खाते में साइन इन करें';

  @override
  String get deleteAccountConfirmation => 'आपका खाता स्थायी रूप से हटा दिया जाएगा. आपका डेटा दोबारा बहाल नहीं किया जाएगा.';

  @override
  String get dangerZone => 'खतरा क्षेत्र';

  @override
  String get helloGuest => 'नमस्ते, अतिथि';

  @override
  String get signInWith => 'के साथ साइन इन करें';

  @override
  String get google => 'गूगल';

  @override
  String get apple => 'सेब';

  @override
  String get termsConditionsMessage => 'मैंने अस्वीकरण पढ़ लिया है और नियम एवं शर्तों से सहमत हूं';

  @override
  String get pleaseAcceptTermsAndConditions => 'कृपया नियम एवं शर्तें स्वीकार करें';

  @override
  String get description => 'विवरण';

  @override
  String get serviceNote => 'सेवा नोट';

  @override
  String get priceMayBeUpdated => 'कीमत अपडेट की जा सकती है';

  @override
  String get optionalDetails => 'वैकल्पिक विवरण';

  @override
  String get reschedule => 'पुनर्निर्धारित';

  @override
  String get priceDetails => 'मूल्य विवरण';

  @override
  String get transactionId => 'लेन-देन आईडी';

  @override
  String get paymentStatus => 'भुगतान की स्थिति';

  @override
  String get paid => 'चुकाया गया';

  @override
  String get goBack => 'वापस जाओ';

  @override
  String get noStaffAvailableForBranchMessage => 'चयनित सेवा के लिए कोई कर्मचारी उपलब्ध नहीं है!';

  @override
  String get tryToChangeYourService => 'अपनी सेवा बदलने का प्रयास करें';

  @override
  String get pay => 'वेतन';

  @override
  String get open => 'खुला';

  @override
  String get closed => 'बंद किया हुआ';

  @override
  String get selectEmployeeFirst => 'पहले कर्मचारी चुनें';

  @override
  String get yourBookingForHairBookingMessage => 'हेयर कट के लिए आपकी बुकिंग सफलतापूर्वक बुक हो गई है';

  @override
  String get back => 'पीछे';

  @override
  String get taxIncluded => 'टैक्स शामिल';

  @override
  String get demoUserCannotBeGrantedForThis => 'इस कार्रवाई के लिए डेमो उपयोगकर्ता को अनुमति नहीं दी जा सकती';

  @override
  String get payNow => 'अब भुगतान करें';

  @override
  String get pleaseTryAgain => 'कृपया पुन: प्रयास करें';

  @override
  String get somethingWentWrong => 'कुछ गलत हो गया';

  @override
  String get yourInternetIsNotWorking => 'आपका इंटरनेट काम नहीं कर रहा है';

  @override
  String get youCannotBookPrevious => 'आप पिछले स्लॉट बुक नहीं कर सकते';

  @override
  String get galleryWillBeAppearedHere => 'गैलरी यहां दिखाई देगी';

  @override
  String get goToBookingDetail => 'बुकिंग विवरण पर जाएं';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage => 'आपका भुगतान सफलतापूर्वक भुगतान कर दिया गया है';

  @override
  String get paymentSuccessful => 'भुगतान सफल!';

  @override
  String get edit => 'संपादन करना';

  @override
  String get bookingTimeSlotChangeMessage => 'क्या आप इस बुकिंग का टाइम स्लॉट बदलना चाहते हैं?';

  @override
  String get change => 'परिवर्तन';

  @override
  String get profileUpdatedSuccessfully => 'प्रोफाइल को सफलतापूर्वक अपडेट किया गया';

  @override
  String get oldPasswordDoesNotMatchMessage => 'आपका पुराना पासवर्ड सही नहीं होता!';

  @override
  String get bookingSuccessfullyUpdateMessage => 'बुकिंग सफलतापूर्वक अपडेट कर दी गई है';

  @override
  String get newUpdate => 'नई अपडेट';

  @override
  String get anUpdateToIs => '$APP_NAME का अपडेट उपलब्ध है। प्ले स्टोर पर जाएं और ऐप का नया वर्जन डाउनलोड करें।';

  @override
  String get closeApp => 'ऐप बंद करें';

  @override
  String get paystack => 'भुगतान का ढेर';

  @override
  String get paypal => 'Paypal';

  @override
  String get male => 'पुरुष';

  @override
  String get female => 'महिला';

  @override
  String get other => 'अन्य';

  @override
  String get gender => 'लिंग';

  @override
  String get pleaseSelectTheDateFirst => 'कृपया पहले दिनांक चुनें';

  @override
  String get thereAreNoBookings => 'फिलहाल कोई बुकिंग सूचीबद्ध नहीं है। यहां अपनी बुकिंग पर नज़र रखें।';

  @override
  String get payWithFlutterwave => 'फ़्लटरवेव से भुगतान करें';

  @override
  String get transactionFailed => 'लेन - देन विफल';

  @override
  String get transactionCancelled => 'लेनदेन रद्द कर दिया गया';

  @override
  String get flutterwave => 'स्पंदन तरंग';

  @override
  String get paytm => 'Paytm';

  @override
  String get areYouSureYouWantToRemove => 'क्या आप वाकई इस आइटम को हटाना चाहते हैं?';

  @override
  String get remove => 'निकालना';

  @override
  String get you => 'आप';

  @override
  String get veChanged => 'हम बदल गए हैं';

  @override
  String get quantityTo => 'मात्रा को';

  @override
  String get editAddress => 'पता संपादित करें';

  @override
  String get addNewAddress => 'नया पता जोड़ें';

  @override
  String get selectCountry => 'देश चुनें';

  @override
  String get selectState => 'राज्य चुनें';

  @override
  String get selectCity => 'शहर चुनें';

  @override
  String get pincode => 'पिन कोड';

  @override
  String get addressLine => 'पता पंक्ति';

  @override
  String get writeAddressHere => 'यहां पता लिखें';

  @override
  String get writeLandmarkHere => 'यहां लैंडमार्क लिखें';

  @override
  String get saveChanges => 'परिवर्तनों को सुरक्षित करें';

  @override
  String get save => 'बचाना';

  @override
  String get cart => 'कार्ट';

  @override
  String get yourCartIsEmpty => 'आपकी गाड़ी खाली है';

  @override
  String get thereAreCurrentlyNoItems => 'आपके कार्ट में अभी कोई आइटम नहीं है। खरीदारी शुरू करें और अपने कार्ट में आइटम जोड़ें।';

  @override
  String get productPriceDetails => 'उत्पाद मूल्य विवरण';

  @override
  String get totalAmount => 'कुल राशि';

  @override
  String get selectAddress => 'पता चुनें';

  @override
  String get opps => 'ओह';

  @override
  String get looksLikeYouHave => 'ऐसा लगता है कि आपने अभी तक कोई पता नहीं जोड़ा है.';

  @override
  String get primary => 'प्राथमिक';

  @override
  String get deliverHere => 'यहाँ वितरित करें';

  @override
  String get areYouSureYouWantToDelete => 'क्या आप वाकई यह पता हटाना चाहते हैं?';

  @override
  String get addressDeleteSuccessfully => 'पता सफलतापूर्वक हटा दिया गया';

  @override
  String get weAreNotShipping => 'हम अभी आपके शहर में शिपिंग नहीं कर रहे हैं';

  @override
  String get deliveryCharge => 'वितरण शुल्क';

  @override
  String get orders => 'आदेश';

  @override
  String get seeYourOrders => 'अपने आदेश देखें';

  @override
  String get myAddresses => 'मेरे पते';

  @override
  String get manageYourAddresses => 'अपने पते प्रबंधित करें';

  @override
  String get shop => 'दुकान';

  @override
  String get aboutProduct => 'उत्पाद के बारे में';

  @override
  String get qty => 'मात्रा';

  @override
  String get orderDetail => 'ऑर्डर विवरण';

  @override
  String get orderDate => 'आर्डर की तारीख';

  @override
  String get deliveredOn => 'सौंप दिया';

  @override
  String get deliveryStatus => 'डिलीवरी स्टेटस';

  @override
  String get cancelOrder => 'आदेश रद्द';

  @override
  String get doYouWantToCancel => 'क्या आप यह ऑर्डर रद्द करना चाहते हैं';

  @override
  String get theOrderHasBeenCancelled => 'ऑर्डर सफलतापूर्वक रद्द कर दिया गया है.';

  @override
  String get noOrdersFound => 'कोई ऑर्डर नहीं मिला';

  @override
  String get thereAreNoOrders => 'फिलहाल कोई ऑर्डर सूचीबद्ध नहीं है. यहां अपने ऑर्डर का ट्रैक रखें.';

  @override
  String get tax => 'कर';

  @override
  String get shippingDetail => 'शिपिंग विवरण';

  @override
  String get alternativeContactNumber => 'वैकल्पिक संपर्क नंबर:';

  @override
  String get addReview => 'समीक्षा जोड़ें';

  @override
  String get thanksYouForReview => 'समीक्षा के लिए धन्यवाद!';

  @override
  String get selectUpToThreeImages => 'अधिकतम तीन छवियाँ चुनें!';

  @override
  String get doYouWantToRemove => 'क्या आप इस छवि को हटाना चाहते हैं';

  @override
  String get addPhoto => 'तस्वीर जोड़ो';

  @override
  String get customerDetail => 'ग्राहक विवरण';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get alternateContactNumber => 'वैकल्पिक संपर्क नंबर';

  @override
  String get orderSummary => 'आदेश सारांश';

  @override
  String get shippingAddress => 'शिपिंग पता';

  @override
  String get off => 'बंद';

  @override
  String get discountedAmount => 'रियायती राशि';

  @override
  String get proceed => 'आगे बढ़ना';

  @override
  String get productReviews => 'उत्पाद की समीक्षा';

  @override
  String get thanksForVoting => 'मतदान के लिए धन्यवाद';

  @override
  String get bestSellerProduct => 'सर्वाधिक बिकने वाला उत्पाद';

  @override
  String get dealsForYou => 'आपके लिए सौदे';

  @override
  String get noProductsFound => 'कोई उत्पाद नहीं मिला';

  @override
  String get featured => 'प्रदर्शित';

  @override
  String get readMore => 'और पढ़ें';

  @override
  String get readLess => 'कम पढ़ें';

  @override
  String get brand => 'ब्रांड';

  @override
  String get inclusiveOfAllTaxes => 'सभी करों सहित';

  @override
  String get outOfStock => 'स्टॉक ख़त्म';

  @override
  String get productSize => 'उत्पाद का आकार';

  @override
  String get quantity => 'मात्रा';

  @override
  String get noRatingsYet => 'अभी तक कोई रेटिंग नहीं';

  @override
  String get ratingAndReviews => 'रेटिंग और समीक्षाएँ';

  @override
  String get totalReviewsAndRatings => 'कुल समीक्षाएँ और रेटिंग';

  @override
  String get ourMostLoveChewTreats => 'हमारा सबसे पसंदीदा च्यू ट्रीट';

  @override
  String get allCategories => 'सब वर्ग';

  @override
  String get thereAreNoCategories => 'फिलहाल कोई श्रेणियां नहीं हैं. यहां अपनी श्रेणियों पर नज़र रखें.';

  @override
  String get searchForProduct => 'उत्पाद खोजें';

  @override
  String get atThisTimeThere => 'इस समय, कोई उत्पाद या श्रेणियाँ उपलब्ध नहीं हैं';

  @override
  String get goToCart => 'गाड़ी पर जाना';

  @override
  String get addToCart => 'कार्ट में जोड़ें';

  @override
  String get orderSuccessfullyPlaced => 'ऑर्डर सफलतापूर्वक प्लेस हो गया';

  @override
  String get yorOrderHasBeen => 'आपका ऑर्डर सफलतापूर्वक दे दिया गया है';

  @override
  String get goToOrderList => 'आदेश सूची पर जाएं';

  @override
  String get choosePaymentMethod => 'भुगतान का तरीका चुनें';

  @override
  String get chooseYourConvenientPayment => 'अपना सुविधाजनक भुगतान विकल्प चुनें।';

  @override
  String get placeOrder => 'आदेश देना';

  @override
  String get confirmOrder => 'आदेश की पुष्टि';

  @override
  String get doYouConfirmThisPayment => 'क्या आप इस भुगतान की पुष्टि करते हैं?';

  @override
  String get wishlist => 'इच्छा-सूची';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist => 'आपके कार्ट में कोई आइटम नहीं हैं। अपनी पसंदीदा वस्तुओं को बाद के लिए सहेजने के लिए उन्हें जोड़ना प्रारंभ करें।';

  @override
  String get price => 'कीमत';

  @override
  String get productBrands => 'उत्पाद ब्रांड';

  @override
  String get searchBrand => 'ब्रांड खोजें';

  @override
  String get more => 'अधिक';

  @override
  String get rating => 'रेटिंग';

  @override
  String get weight => 'वज़न';

  @override
  String get clearFilter => 'स्पष्ट निस्यंदक';

  @override
  String get applyFilter => 'फिल्टर लागू करें';

  @override
  String get orderPlaced => 'आदेश रखा';

  @override
  String get processing => 'प्रसंस्करण';

  @override
  String get delivered => 'पहुंचा दिया';

  @override
  String get unpaid => 'अवैतनिक';

  @override
  String get parchasedProducts => 'खरीदे गए उत्पाद';

  @override
  String get productAmount => 'उत्पाद मात्रा';

  @override
  String get filterBy => 'फिल्टर के द्वारा';

  @override
  String get bookingStatus => 'बुकिंग स्थिति';

  @override
  String get apply => 'आवेदन करना';

  @override
  String get searchOrder => 'खोज आदेश';

  @override
  String get ciNetPay => 'सिनेट वेतन';

  @override
  String get lblCheckOutWithCiNetPay => 'सिनेटपे के साथ चेकआउट करें';

  @override
  String get ciNetPayNotSupportedMessage => 'सिनेटपे आपकी मुद्राओं द्वारा समर्थित नहीं है';

  @override
  String get totalAmountShouldBeMoreThan => 'कुल राशि से अधिक होनी चाहिए';

  @override
  String get totalAmountShouldBeLessThan => 'कुल राशि से कम होनी चाहिए';

  @override
  String get yourPaymentFailedPleaseTryAgain => 'आपका भुगतान विफल रहा कृपया पुनः प्रयास करें';

  @override
  String get yourPaymentHasBeenMadeSuccessfully => 'आपका भुगतान सफलतापूर्वक कर दिया गया है';

  @override
  String get lblInvalidTransaction => 'अवैध लेन - देन';

  @override
  String get accessDeniedContactYourAdmin => 'पहुंच अस्वीकृत। सहायता के लिए अपने व्यवस्थापक से संपर्क करें.';

  @override
  String get sadadPayment => 'सादा भुगतान';

  @override
  String get topUpWallet => 'टॉप-अप वॉलेट';

  @override
  String get airtelMoneyPayment => 'एयरटेल मनी भुगतान';

  @override
  String get paymentSuccess => 'भुगतान की सफलता';

  @override
  String get redirectingToBookings => 'बुकिंग पर पुनः निर्देशित किया जा रहा है..';

  @override
  String get transactionIsInProcess => 'लेन-देन प्रक्रिया में है...';

  @override
  String get pleaseCheckThePayment => 'कृपया जांच लें कि भुगतान अनुरोध आपके नंबर पर भेजा गया है';

  @override
  String get enterYourMsisdnHere => 'यहां अपना एमएसआईएसडीएन दर्ज करें';

  @override
  String get theTransactionIsStill => 'लेन-देन अभी भी संसाधित हो रहा है और अस्पष्ट स्थिति में है। कृपया लेन-देन की स्थिति जानने के लिए लेन-देन संबंधी पूछताछ करें।';

  @override
  String get transactionIsSuccessful => 'लेन-देन सफल है';

  @override
  String get incorrectPinHasBeen => 'ग़लत पिन दर्ज किया गया है';

  @override
  String get theUserHasExceeded => 'उपयोगकर्ता ने अपने वॉलेट द्वारा अनुमत लेनदेन सीमा पार कर ली है';

  @override
  String get theAmountUserIs => 'उपयोगकर्ता जिस राशि को स्थानांतरित करने का प्रयास कर रहा है वह अनुमत न्यूनतम राशि से कम है';

  @override
  String get userDidnTEnterThePin => 'उपयोगकर्ता ने पिन दर्ज नहीं किया';

  @override
  String get transactionInPendingState => 'लेनदेन लंबित स्थिति में. कृपया कुछ देर बाद जांचें';

  @override
  String get userWalletDoesNot => 'उपयोगकर्ता के वॉलेट में देय राशि को कवर करने के लिए पर्याप्त धन नहीं है';

  @override
  String get theTransactionWasRefused => 'लेन-देन से इनकार कर दिया गया';

  @override
  String get thisIsAGeneric => 'यह एक सामान्य इनकार है जिसके कई संभावित कारण हैं';

  @override
  String get payeeIsAlreadyInitiated => 'भुगतानकर्ता पहले से ही मंथन के लिए शुरू किया गया है या प्रतिबंधित है या एयरटेल मनी प्लेटफॉर्म पर पंजीकृत नहीं है';

  @override
  String get theTransactionWasTimed => 'लेन-देन का समय समाप्त हो गया था.';

  @override
  String get theTransactionWasNot => 'लेन-देन नहीं मिला.';

  @override
  String get xSignatureAndPayloadDid => 'एक्स-हस्ताक्षर और पेलोड मेल नहीं खाते';

  @override
  String get encryptionKeyHasBeen => 'एन्क्रिप्शन कुंजी सफलतापूर्वक प्राप्त कर ली गई है';

  @override
  String get couldNotFetchEncryption => 'एन्क्रिप्शन कुंजी नहीं लायी जा सकी';

  @override
  String get transactionHasBeenExpired => 'लेन-देन समाप्त हो गया है';

  @override
  String get ambiguous => 'अस्पष्ट';

  @override
  String get success => 'सफलता';

  @override
  String get incorrectPin => 'ग़लत पिन';

  @override
  String get exceedsWithdrawalAmountLimitS => 'निकासी राशि सीमा से अधिक / निकासी राशि सीमा से अधिक';

  @override
  String get invalidAmount => 'अवैध राशि';

  @override
  String get transactionIdIsInvalid => 'लेन-देन आईडी अमान्य है';

  @override
  String get inProcess => 'प्रक्रिया में';

  @override
  String get notEnoughBalance => 'पर्याप्त संतुलन नहीं';

  @override
  String get refused => 'अस्वीकार करना';

  @override
  String get doNotHonor => 'सम्मान मत कर';

  @override
  String get transactionNotPermittedTo => 'भुगतानकर्ता को लेनदेन की अनुमति नहीं है';

  @override
  String get transactionTimedOut => 'लेन-देन का समय समाप्त हो गया';

  @override
  String get transactionNotFound => 'लेनदेन नहीं मिला';

  @override
  String get forBidden => 'निषिद्ध';

  @override
  String get successfullyFetchedEncryptionKey => 'एन्क्रिप्शन कुंजी सफलतापूर्वक प्राप्त की गई';

  @override
  String get errorWhileFetchingEncryption => 'एन्क्रिप्शन कुंजी लाते समय त्रुटि';

  @override
  String get transactionExpired => 'लेन-देन समाप्त हो गया';

  @override
  String get btnSubmit => 'जमा करना';

  @override
  String get midTransPayment => 'मिडट्रांस भुगतान';

  @override
  String get phonePe => 'फ़ोनपे भुगतान';

  @override
  String get availableCoupons => 'उपलब्ध कूपन';

  @override
  String get youSaved => 'आपने बचा लिया';

  @override
  String get couponIsRemoved => 'कूपन हटा दिया गया है';

  @override
  String get pleaseSelectServices => 'कृपया सेवाएँ चुनें';

  @override
  String get selectCoupon => 'कूपन चुनें';

  @override
  String get validTill => 'तक मान्य';

  @override
  String get useThisCodeToGet => 'प्राप्त करने के लिए इस कोड का उपयोग करें';

  @override
  String get downloadInvoice => 'इनवाइस को डाउनलोड करो';

  @override
  String get noCouponLeftIn => 'आपके खाते में कोई कूपन नहीं बचा.';

  @override
  String get noCouponsAvailable => 'कोई कूपन उपलब्ध नहीं है.';

  @override
  String get couponAppliedSuccessfully => 'कूपन सफलतापूर्वक लागू हो गया';

  @override
  String get pleaseAddCouponCode => 'कृपया कूपन कोड जोड़ें.';

  @override
  String get viewInvoice => 'चालान देखें';

  @override
  String get finalTotal => 'अंतिम कुल';

  @override
  String get myDiscountCoupons => 'मेरे डिस्काउंट कूपन';

  @override
  String get coupons => 'कूपन';

  @override
  String get valid => 'वैध';

  @override
  String get couponCodeCopied => 'कूपन कोड कॉपी किया गया';

  @override
  String get applyCoupon => 'कूपन के लिए आवेदन करो';

  @override
  String get enterYourCode => 'अपने कोड दर्ज करें';

  @override
  String get couponCode => 'कूपन कोड';

  @override
  String get couponDiscount => 'कूपन छूट';

  @override
  String get packages => 'पैकेट';

  @override
  String get purchaseNow => 'अब खरीदें';

  @override
  String get viewDetail => 'विस्तार से देखें';

  @override
  String get coupon => 'कूपन';

  @override
  String get package => 'पैकेट';

  @override
  String get yourPackage => 'आपका पैकेज';

  @override
  String get expiryIn => 'में समाप्ति';

  @override
  String get packageExpiringSoon => 'पैकेज जल्द ही समाप्त हो रहा है';

  @override
  String get exclusiveYearLongSalonPamper => 'साल भर चलने वाला विशेष सैलून पैम्पर पैकेज';

  @override
  String get whatSIncluded => 'क्या शामिल है';

  @override
  String get mins => 'मिनट';

  @override
  String get reclaim => 'रीक्लेम';

  @override
  String get selectedPackage => 'चयनित पैकेज';

  @override
  String get noPackagesFound => 'कोई पैकेज नहीं मिला';

  @override
  String get yourExistingPackage => 'आपका मौजूदा पैकेज';

  @override
  String get viewAllPackages => 'सभी पैकेज देखें';

  @override
  String get existingPackages => 'मौजूदा पैकेज';

  @override
  String get upgrade => 'उन्नत करना';

  @override
  String get mo => 'एमओ';

  @override
  String get days => 'दिन';

  @override
  String get yourPackageIsStillActive => 'आपका पैकेज अभी भी सक्रिय है.';

  @override
  String get packagesAvailable => 'पैकेज उपलब्ध हैं';

  @override
  String get yourBookedServices => 'आपकी बुक की गई सेवाएँ:';

  @override
  String get reused => 'पुन: उपयोग';

  @override
  String get packageDetail => 'पैकेज विवरण';

  @override
  String get ourPackages => 'हमारे पैकेज';

  @override
  String get explore => 'अन्वेषण करना';

  @override
  String get myPackages => 'मेरे पैकेज';

  @override
  String get availablePackages => 'उपलब्ध पैकेज';

  @override
  String get remainingQuantity => 'बची हुई मात्रा';

  @override
  String get useNow => 'अभी उपयोग करें';

  @override
  String get removingPackage => 'पैकेज हटाया जा रहा है?';

  @override
  String get doYouWantTo => 'क्या आप इस पैकेज को हटाकर इसे जारी रखना चाहते हैं?';

  @override
  String get expiryBy => 'तक समाप्ति';

  @override
  String get expiringToday => 'आज समाप्त हो रहा है';

  @override
  String get iHaveReadThe => 'मैंने अस्वीकरण पढ़ लिया है और इससे सहमत हूं ';

  @override
  String get theCouponAmountExceeds => 'कूपन राशि सेवा मूल्य से अधिक है';

  @override
  String get appliedTaxes => 'लागू कर';
}

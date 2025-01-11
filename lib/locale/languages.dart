import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get tokenExpired;

  String get badRequest;

  String get forbidden;

  String get pageNotFound;

  String get tooManyRequests;

  String get internalServerError;

  String get badGateway;

  String get serviceUnavailable;

  String get gatewayTimeout;

  String get hey;

  String get helloUser;

  String get createYourAccountFor;

  String get firstName;

  String get lastName;

  String get email;

  String get thisFieldIsRequired;

  String get contactNumber;

  String get password;

  String get signUp;

  String get alreadyHaveAnAccount;

  String get signIn;

  String get welcomeBack;

  String get youHaveBeenMissed;

  String get rememberMe;

  String get forgotPassword;

  String get registerNow;

  String get or;

  String get pleaseEnterValidOtp;

  String get otpVerification;

  String get checkYourMailAnd;

  String get didNotGetTheOtp;

  String get resendOtp;

  String get verify;

  String get enterYourEmailAddress;

  String get aResetPasswordLink;

  String get resetPassword;

  String get areYouSureWantToPerformThisAction;

  String get yes;

  String get no;

  String get gallery;

  String get camera;

  String get editProfile;

  String get update;

  String get changePassword;

  String get newPasswordsMustBeDifferent;

  String get oldPassword;

  String get newPassword;

  String get thePasswordDoesNotMatch;

  String get reEnterPassword;

  String get confirm;

  String get pleaseLoginAgain;

  String get loginSuccessfully;

  String get noUserFound;

  String get otpInvalidMessage;

  String get pleaseContactWithAdmin;

  String get confirmOtp;

  String get verified;

  String get signInFailed;

  String get appleSigInIsNotAvailable;

  String get emailAddressIsRequiredUpdateAppleAccount;

  String get yourPasswordReset;

  String get yourAccountIsReady;

  String get yourPassWorResetSuccessfully;

  String get done;

  String get specialist;

  String get date;

  String get time;

  String get payment;

  String get noDetailsFound;

  String get reload;

  String get locationInformation;

  String get name;

  String get address;

  String get quickBookAppointment;

  String get service;

  String get total;

  String get bookNow;

  String get pleaseSelectService;

  String get confirmBooking;

  String get doYouWantToConfirmBooking;

  String get paymentDetails;

  String get subtotal;

  String get tip;

  String get discount;

  String get yourReview;

  String get deleteReview;

  String get doYouWantToDeleteReview;

  String get viewAll;

  String get rate;

  String get paymentMethod;

  String get goToBookings;

  String get yourBookingFor;

  String get bookingSuccessful;

  String get cashAfterService;

  String get razorpay;

  String get stripe;

  String get doWantToBookAppointment;

  String get noTimeSlots;

  String get availableSlots;

  String get next;

  String get pleaseSelectTimeSlotFirst;

  String get chooseYourExpert;

  String get pleaseChooseYourExpert;

  String get services;

  String get cancelAppointment;

  String get doYouWantToCancelBooking;

  String get bookingInformation;

  String get status;

  String get chooseBranch;

  String get noBranchFound;

  String get doYouWantExplore;

  String get nearbyBranches;

  String get about;

  String get reviews;

  String get staff;

  String get noServicesFound;

  String get noReviewsFound;

  String get yourReviewsWillBeAppearedHere;

  String get call;

  String get direction;

  String get noGalleryFound;

  String get workingHours;

  String get ourCategory;

  String get noCategoryFound;

  String get pressBackAgainToExitApp;

  String get home;

  String get booking;

  String get notifications;

  String get user;

  String get profile;

  String get setting;

  String get appLanguage;

  String get theme;

  String get aboutApp;

  String get rateUs;

  String get share;

  String get help;

  String get helpCenter;

  String get privacyPolicy;

  String get tC;

  String get logout;

  String get logoutYourAccount;

  String get ohNoYouAreLeaving;

  String get doYouWantToLogout;

  String get noNotifications;

  String get weLlNotifyYouOnce;

  String get searchForServices;

  String get searchServices;

  String get searchBooking;

  String get topExperts;

  String get theUserHasDeniedSpeechRecognition;

  String get category;

  String get kms;

  String get fromYourLocation;

  String get noBookingsFound;

  String get notAMember;

  String get noStaffFound;

  String get contactInfo;

  String get noReviewsYetFor;

  String get language;

  String get appTheme;

  String get termsConditions;

  String get app;

  String get light;

  String get dark;

  String get systemDefault;

  String get chooseTheme;

  String get allServices;

  String get searchFor;

  String get subCategories;

  String get clear;

  String get welcomeToThe;

  String get salon;

  String get weProvideYouBestServiceMessage;

  String get userExperience;

  String get createAccount;

  String get pending;

  String get confirmed;

  String get cancelled;

  String get checkIn;

  String get checkOut;

  String get completed;

  String get invalidUrl;

  String get enterYourReviewOptional;

  String get cancel;

  String get submit;

  String get ratingIsRequired;

  String get timeSlotBookedMessage;

  String get branchName;

  String get place;

  String get basedOn;

  String get review;

  String get s;

  String get error;

  String get externalWallet;

  String get userCancelled;

  String get userNotFound;

  String get dateIsRequired;

  String get timeIsRequired;

  String get findYourNearestSalon;

  String get walkThrough1subTitle;

  String get pickAService;

  String get walkThrough2subTitle;

  String get quickBooking;

  String get walkThrough3subTitle;

  String get skip;

  String get getStarted;

  String get delete;

  String get deleteAccount;

  String get signInYourAccount;

  String get deleteAccountConfirmation;

  String get dangerZone;

  String get helloGuest;

  String get signInWith;

  String get google;

  String get apple;

  String get termsConditionsMessage;

  String get pleaseAcceptTermsAndConditions;

  String get description;

  String get serviceNote;

  String get priceMayBeUpdated;

  String get optionalDetails;

  String get reschedule;

  String get priceDetails;

  String get transactionId;

  String get paymentStatus;

  String get paid;

  String get goBack;

  String get noStaffAvailableForBranchMessage;

  String get tryToChangeYourService;

  String get pay;

  String get open;

  String get closed;

  String get selectEmployeeFirst;

  String get yourBookingForHairBookingMessage;

  String get back;

  String get taxIncluded;

  String get demoUserCannotBeGrantedForThis;

  String get payNow;

  String get pleaseTryAgain;

  String get somethingWentWrong;

  String get yourInternetIsNotWorking;

  String get youCannotBookPrevious;

  String get galleryWillBeAppearedHere;

  String get goToBookingDetail;

  String get yourPaymentIsPaidSuccessfullyMessage;

  String get paymentSuccessful;

  String get edit;

  String get bookingTimeSlotChangeMessage;

  String get change;

  String get profileUpdatedSuccessfully;

  String get oldPasswordDoesNotMatchMessage;

  String get bookingSuccessfullyUpdateMessage;

  String get newUpdate;

  String get anUpdateToIs;

  String get closeApp;

  String get paystack;

  String get paypal;

  String get male;

  String get female;

  String get other;

  String get gender;

  String get pleaseSelectTheDateFirst;

  String get thereAreNoBookings;

  String get payWithFlutterwave;

  String get transactionFailed;

  String get transactionCancelled;

  String get flutterwave;

  String get paytm;

  String get areYouSureYouWantToRemove;

  String get remove;

  String get you;

  String get veChanged;

  String get quantityTo;

  String get editAddress;

  String get addNewAddress;

  String get selectCountry;

  String get selectState;

  String get selectCity;

  String get pincode;

  String get addressLine;

  String get writeAddressHere;

  String get writeLandmarkHere;

  String get saveChanges;

  String get save;

  String get cart;

  String get yourCartIsEmpty;

  String get thereAreCurrentlyNoItems;

  String get productPriceDetails;

  String get totalAmount;

  String get selectAddress;

  String get opps;

  String get looksLikeYouHave;

  String get primary;

  String get deliverHere;

  String get areYouSureYouWantToDelete;

  String get addressDeleteSuccessfully;

  String get weAreNotShipping;

  String get deliveryCharge;

  String get orders;

  String get seeYourOrders;

  String get myAddresses;

  String get manageYourAddresses;

  String get shop;

  String get aboutProduct;

  String get qty;

  String get orderDetail;

  String get orderDate;

  String get deliveredOn;

  String get deliveryStatus;

  String get cancelOrder;

  String get doYouWantToCancel;

  String get theOrderHasBeenCancelled;

  String get noOrdersFound;

  String get thereAreNoOrders;

  String get tax;

  String get shippingDetail;

  String get alternativeContactNumber;

  String get addReview;

  String get thanksYouForReview;

  String get selectUpToThreeImages;

  String get doYouWantToRemove;

  String get addPhoto;

  String get customerDetail;

  String get fullName;

  String get alternateContactNumber;

  String get orderSummary;

  String get shippingAddress;

  String get off;

  String get discountedAmount;

  String get proceed;

  String get productReviews;

  String get thanksForVoting;

  String get bestSellerProduct;

  String get dealsForYou;

  String get noProductsFound;

  String get featured;

  String get readMore;

  String get readLess;

  String get brand;

  String get inclusiveOfAllTaxes;

  String get outOfStock;

  String get productSize;

  String get quantity;

  String get noRatingsYet;

  String get ratingAndReviews;

  String get totalReviewsAndRatings;

  String get ourMostLoveChewTreats;

  String get allCategories;

  String get thereAreNoCategories;

  String get searchForProduct;

  String get atThisTimeThere;

  String get goToCart;

  String get addToCart;

  String get orderSuccessfullyPlaced;

  String get yorOrderHasBeen;

  String get goToOrderList;

  String get choosePaymentMethod;

  String get chooseYourConvenientPayment;

  String get placeOrder;

  String get confirmOrder;

  String get doYouConfirmThisPayment;

  String get wishlist;

  String get thereAreCurrentlyNoItemsInYourWishlist;

  String get price;

  String get productBrands;

  String get searchBrand;

  String get more;

  String get rating;

  String get weight;

  String get clearFilter;

  String get applyFilter;

  String get orderPlaced;

  String get processing;

  String get delivered;

  String get unpaid;

  String get parchasedProducts;

  String get productAmount;

  String get filterBy;

  String get bookingStatus;

  String get apply;

  String get searchOrder;

  String get ciNetPay;

  String get lblCheckOutWithCiNetPay;

  String get ciNetPayNotSupportedMessage;

  String get totalAmountShouldBeMoreThan;

  String get totalAmountShouldBeLessThan;

  String get yourPaymentFailedPleaseTryAgain;

  String get yourPaymentHasBeenMadeSuccessfully;

  String get lblInvalidTransaction;

  String get accessDeniedContactYourAdmin;

  String get sadadPayment;

  String get topUpWallet;

  String get airtelMoneyPayment;

  String get paymentSuccess;

  String get redirectingToBookings;

  String get transactionIsInProcess;

  String get pleaseCheckThePayment;

  String get enterYourMsisdnHere;

  String get theTransactionIsStill;

  String get transactionIsSuccessful;

  String get incorrectPinHasBeen;

  String get theUserHasExceeded;

  String get theAmountUserIs;

  String get userDidnTEnterThePin;

  String get transactionInPendingState;

  String get userWalletDoesNot;

  String get theTransactionWasRefused;

  String get thisIsAGeneric;

  String get payeeIsAlreadyInitiated;

  String get theTransactionWasTimed;

  String get theTransactionWasNot;

  String get xSignatureAndPayloadDid;

  String get encryptionKeyHasBeen;

  String get couldNotFetchEncryption;

  String get transactionHasBeenExpired;

  String get ambiguous;

  String get success;

  String get incorrectPin;

  String get exceedsWithdrawalAmountLimitS;

  String get invalidAmount;

  String get transactionIdIsInvalid;

  String get inProcess;

  String get notEnoughBalance;

  String get refused;

  String get doNotHonor;

  String get transactionNotPermittedTo;

  String get transactionTimedOut;

  String get transactionNotFound;

  String get forBidden;

  String get successfullyFetchedEncryptionKey;

  String get errorWhileFetchingEncryption;

  String get transactionExpired;

  String get btnSubmit;

  String get midTransPayment;

  String get phonePe;

  String get availableCoupons;

  String get youSaved;

  String get couponIsRemoved;

  String get pleaseSelectServices;

  String get selectCoupon;

  String get validTill;

  String get useThisCodeToGet;

  String get downloadInvoice;

  String get noCouponLeftIn;

  String get noCouponsAvailable;

  String get couponAppliedSuccessfully;

  String get pleaseAddCouponCode;

  String get viewInvoice;

  String get finalTotal;

  String get myDiscountCoupons;

  String get coupons;

  String get valid;

  String get couponCodeCopied;

  String get applyCoupon;

  String get enterYourCode;

  String get couponCode;

  String get couponDiscount;

  String get packages;

  String get purchaseNow;

  String get viewDetail;

  String get coupon;

  String get package;

  String get yourPackage;

  String get expiryIn;

  String get packageExpiringSoon;

  String get exclusiveYearLongSalonPamper;

  String get whatSIncluded;

  String get mins;

  String get reclaim;

  String get selectedPackage;

  String get noPackagesFound;

  String get yourExistingPackage;

  String get viewAllPackages;

  String get existingPackages;

  String get upgrade;

  String get mo;

  String get days;

  String get yourPackageIsStillActive;

  String get packagesAvailable;

  String get yourBookedServices;

  String get reused;

  String get packageDetail;

  String get ourPackages;

  String get explore;

  String get myPackages;

  String get availablePackages;

  String get remainingQuantity;

  String get useNow;

  String get removingPackage;

  String get doYouWantTo;

  String get expiryBy;

  String get expiringToday;

  String get iHaveReadThe;

  String get theCouponAmountExceeds;

  String get appliedTaxes;
}

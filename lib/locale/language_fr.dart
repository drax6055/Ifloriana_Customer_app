import '../configs.dart';
import 'languages.dart';

class LanguageFr extends BaseLanguage {
  @override
  String get tokenExpired => 'Jeton expiré';

  @override
  String get badRequest => '400 : requête incorrecte';

  @override
  String get forbidden => '403 : Interdit';

  @override
  String get pageNotFound => '404 Page non trouvée';

  @override
  String get tooManyRequests => '429 : Trop de demandes';

  @override
  String get internalServerError => '500 : erreur de serveur interne';

  @override
  String get badGateway => '502 Mauvaise passerelle';

  @override
  String get serviceUnavailable => '503 Service Indisponible';

  @override
  String get gatewayTimeout => '504 portail expiré';

  @override
  String get hey => 'Hé';

  @override
  String get helloUser => 'Bonjour utilisateur !';

  @override
  String get createYourAccountFor => 'Créez votre compte pour une meilleure expérience';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom de famille';

  @override
  String get email => 'E-mail';

  @override
  String get thisFieldIsRequired => 'Ce champ est obligatoire';

  @override
  String get contactNumber => 'Numéro de contact';

  @override
  String get password => 'Mot de passe';

  @override
  String get signUp => "S'inscrire";

  @override
  String get alreadyHaveAnAccount => 'Vous avez déjà un compte?';

  @override
  String get signIn => 'Se connecter';

  @override
  String get welcomeBack => 'Content de te revoir!';

  @override
  String get youHaveBeenMissed => 'Vous nous manquez depuis longtemps';

  @override
  String get rememberMe => 'Souviens-toi de moi';

  @override
  String get forgotPassword => 'Mot de passe oublié?';

  @override
  String get registerNow => "S'inscrire maintenant";

  @override
  String get or => 'OU';

  @override
  String get pleaseEnterValidOtp => 'Veuillez entrer un OTP valide';

  @override
  String get otpVerification => 'Vérification OTP';

  @override
  String get checkYourMailAnd => 'Vérifiez votre courrier et entrez le code que vous obtenez';

  @override
  String get didNotGetTheOtp => 'Vous n’avez pas obtenu l’OTP ?';

  @override
  String get resendOtp => 'Renvoyer OTP';

  @override
  String get verify => 'Vérifier';

  @override
  String get enterYourEmailAddress => 'Entrez votre adresse email';

  @override
  String get aResetPasswordLink => "Un lien de réinitialisation du mot de passe sera envoyé à l'adresse e-mail saisie ci-dessus";

  @override
  String get resetPassword => 'réinitialiser le mot de passe';

  @override
  String get areYouSureWantToPerformThisAction => 'Êtes-vous sûr de vouloir effectuer cette action ?';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get gallery => 'Galerie';

  @override
  String get camera => 'Caméra';

  @override
  String get editProfile => 'Editer le profil';

  @override
  String get update => 'Mise à jour';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get newPasswordsMustBeDifferent => 'Les nouveaux mots de passe doivent être différents des précédents';

  @override
  String get oldPassword => 'ancien mot de passe';

  @override
  String get newPassword => 'nouveau mot de passe';

  @override
  String get thePasswordDoesNotMatch => 'Le mot de passe ne correspond pas';

  @override
  String get reEnterPassword => 'Entrez à nouveau le mot de passe';

  @override
  String get confirm => 'Confirmer';

  @override
  String get pleaseLoginAgain => 'Veuillez vous reconnecter';

  @override
  String get loginSuccessfully => 'Connectez-vous avec succès';

  @override
  String get noUserFound => 'Aucun utilisateur trouvé';

  @override
  String get otpInvalidMessage => "Le code saisi n'est pas valide, veuillez réessayer";

  @override
  String get pleaseContactWithAdmin => "Veuillez contacter l'administrateur";

  @override
  String get confirmOtp => 'Confirmer OTP';

  @override
  String get verified => 'Vérifié';

  @override
  String get signInFailed => 'Échec de la connexion';

  @override
  String get appleSigInIsNotAvailable => "Apple SignIn n'est pas disponible pour votre appareil";

  @override
  String get emailAddressIsRequiredUpdateAppleAccount => "Adresse e-mail est nécessaire. Veuillez mettre à jour l'e-mail dans votre compte Apple";

  @override
  String get yourPasswordReset => 'Votre mot de passe réinitialisé';

  @override
  String get yourAccountIsReady => 'Votre compte est prêt à être utilisé. Profitez de notre spécialiste et de nos services';

  @override
  String get yourPassWorResetSuccessfully => 'Votre mot de passe a été réinitialisé avec succès';

  @override
  String get done => 'Fait';

  @override
  String get specialist => 'Spécialiste';

  @override
  String get date => 'Date';

  @override
  String get time => 'Temps';

  @override
  String get payment => 'Paiement';

  @override
  String get noDetailsFound => 'Aucun détail trouvé';

  @override
  String get reload => 'Recharger';

  @override
  String get locationInformation => 'Information de Lieu';

  @override
  String get name => 'Nom';

  @override
  String get address => 'Adresse';

  @override
  String get quickBookAppointment => 'Prise de rendez-vous rapide';

  @override
  String get service => 'Service';

  @override
  String get total => 'Total';

  @override
  String get bookNow => 'Reserve maintenant';

  @override
  String get pleaseSelectService => 'Veuillez sélectionner un service';

  @override
  String get confirmBooking => 'Confirmer la réservation';

  @override
  String get doYouWantToConfirmBooking => 'Voulez-vous confirmer cette réservation?';

  @override
  String get paymentDetails => 'Détails de paiement';

  @override
  String get subtotal => 'Total';

  @override
  String get tip => 'Conseil';

  @override
  String get discount => 'Rabais';

  @override
  String get yourReview => 'Votre avis';

  @override
  String get deleteReview => "Supprimer l'avis";

  @override
  String get doYouWantToDeleteReview => 'Voulez-vous supprimer cet avis ?';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get rate => 'Taux';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get goToBookings => 'Aller aux réservations';

  @override
  String get yourBookingFor => 'Votre réservation pour';

  @override
  String get bookingSuccessful => 'Réservation réussie !';

  @override
  String get cashAfterService => 'Paiement après service';

  @override
  String get razorpay => 'Rasoirpay';

  @override
  String get stripe => 'Bande';

  @override
  String get doWantToBookAppointment => 'Vous souhaitez prendre ce rendez-vous ?';

  @override
  String get noTimeSlots => 'Pas de créneaux horaires';

  @override
  String get availableSlots => 'Emplacements disponibles';

  @override
  String get next => 'Suivant';

  @override
  String get pleaseSelectTimeSlotFirst => "Veuillez d'abord sélectionner un créneau horaire";

  @override
  String get chooseYourExpert => 'Choisissez votre expert';

  @override
  String get pleaseChooseYourExpert => "Veuillez d'abord choisir votre expert";

  @override
  String get services => 'Prestations de service';

  @override
  String get cancelAppointment => 'Annuler rendez-vous';

  @override
  String get doYouWantToCancelBooking => 'Voulez-vous annuler cette réservation?';

  @override
  String get bookingInformation => 'Informations de réservation';

  @override
  String get status => 'Statut';

  @override
  String get chooseBranch => 'Choisir une succursale';

  @override
  String get noBranchFound => 'Aucune succursale trouvée';

  @override
  String get doYouWantExplore => 'Voulez-vous explorer';

  @override
  String get nearbyBranches => 'Succursales à proximité';

  @override
  String get about => 'À propos';

  @override
  String get reviews => 'Commentaires';

  @override
  String get staff => 'Personnel';

  @override
  String get noServicesFound => 'Aucun service trouvé';

  @override
  String get noReviewsFound => 'Aucun avis trouvé';

  @override
  String get yourReviewsWillBeAppearedHere => 'Vos avis apparaîtront ici';

  @override
  String get call => 'Appel';

  @override
  String get direction => 'Direction';

  @override
  String get noGalleryFound => 'Aucune galerie trouvée';

  @override
  String get workingHours => "Heures d'ouverture";

  @override
  String get ourCategory => 'Notre catégorie';

  @override
  String get noCategoryFound => 'Aucune catégorie trouvée';

  @override
  String get pressBackAgainToExitApp => "Appuyez à nouveau pour quitter l'application";

  @override
  String get home => 'Maison';

  @override
  String get booking => 'Réservation';

  @override
  String get notifications => 'Notifications';

  @override
  String get user => 'Utilisateur';

  @override
  String get profile => 'Profil';

  @override
  String get setting => 'Paramètre';

  @override
  String get appLanguage => "Langue de l'application";

  @override
  String get theme => 'Thème';

  @override
  String get aboutApp => "À propos de l'application";

  @override
  String get rateUs => 'Évaluez nous';

  @override
  String get share => 'Partager';

  @override
  String get help => 'Aide';

  @override
  String get helpCenter => "Centre d'aide";

  @override
  String get privacyPolicy => 'politique de confidentialité';

  @override
  String get tC => 'Conditions générales';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get logoutYourAccount => 'Déconnectez-vous de votre compte';

  @override
  String get ohNoYouAreLeaving => 'Oh non, tu pars !';

  @override
  String get doYouWantToLogout => 'Voulez-vous vous déconnecter ?';

  @override
  String get noNotifications => 'Aucune notification';

  @override
  String get weLlNotifyYouOnce => 'Nous vous informerons dès que nous aurons quelque chose pour vous';

  @override
  String get searchForServices => 'Rechercher des services';

  @override
  String get searchServices => 'Services de recherche';

  @override
  String get searchBooking => 'Rechercher une réservation';

  @override
  String get topExperts => 'Les meilleurs experts';

  @override
  String get theUserHasDeniedSpeechRecognition => "L'utilisateur a refusé l'utilisation de la reconnaissance vocale";

  @override
  String get category => 'Catégorie';

  @override
  String get kms => 'KM';

  @override
  String get fromYourLocation => 'Depuis votre emplacement';

  @override
  String get noBookingsFound => 'Aucune réservation trouvée';

  @override
  String get notAMember => 'Pas un membre?';

  @override
  String get noStaffFound => 'Aucun membre du personnel trouvé';

  @override
  String get contactInfo => 'Informations de contact';

  @override
  String get noReviewsYetFor => "Pas encore d'avis pour";

  @override
  String get language => 'Langue';

  @override
  String get appTheme => "Thème de l'application";

  @override
  String get termsConditions => 'termes et conditions';

  @override
  String get app => 'Application';

  @override
  String get light => 'Lumière';

  @override
  String get dark => 'Sombre';

  @override
  String get systemDefault => 'Défaillance du système';

  @override
  String get chooseTheme => 'Choisir un thème';

  @override
  String get allServices => 'Tous les services';

  @override
  String get searchFor => 'Rechercher';

  @override
  String get subCategories => 'Sous-catégories';

  @override
  String get clear => 'Clair';

  @override
  String get welcomeToThe => 'Bienvenue à la';

  @override
  String get salon => 'Salon';

  @override
  String get weProvideYouBestServiceMessage => 'Nous vous fournissons les meilleurs services et les meilleurs';

  @override
  String get userExperience => 'expérience utilisateur';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get pending => 'En attente';

  @override
  String get confirmed => 'Confirmé';

  @override
  String get cancelled => 'Annulé';

  @override
  String get checkIn => 'Enregistrement';

  @override
  String get checkOut => 'Vérifier';

  @override
  String get completed => 'Complété';

  @override
  String get invalidUrl => 'URL invalide';

  @override
  String get enterYourReviewOptional => 'Entrez votre avis (facultatif)';

  @override
  String get cancel => 'Annuler';

  @override
  String get submit => 'Soumettre';

  @override
  String get ratingIsRequired => 'Une note est requise';

  @override
  String get timeSlotBookedMessage => 'est déjà réservé ! Veuillez choisir un autre créneau horaire';

  @override
  String get branchName => 'Nom de la filiale';

  @override
  String get place => 'Lieu';

  @override
  String get basedOn => 'Basé sur';

  @override
  String get review => 'Revoir';

  @override
  String get s => 's';

  @override
  String get error => 'Erreur:';

  @override
  String get externalWallet => 'Portefeuille externe :';

  @override
  String get userCancelled => 'Utilisateur annulé';

  @override
  String get userNotFound => 'Utilisateur non trouvé';

  @override
  String get dateIsRequired => 'La date est requise';

  @override
  String get timeIsRequired => 'Il faut du temps';

  @override
  String get findYourNearestSalon => 'Trouvez votre salon le plus proche';

  @override
  String get walkThrough1subTitle => 'Vous pouvez trouver facilement à proximité de chez vous le meilleur barbier et salon et profiter de la meilleure expérience de service';

  @override
  String get pickAService => 'Choisissez un service';

  @override
  String get walkThrough2subTitle => 'Vous pouvez choisir votre service et choisir votre spécialiste et obtenir une réservation rapide';

  @override
  String get quickBooking => 'Réservation rapide';

  @override
  String get walkThrough3subTitle => 'Vous obtenez les meilleurs services et le meilleur spécialiste de vos services de notre';

  @override
  String get skip => 'Sauter';

  @override
  String get getStarted => 'Commencer';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get signInYourAccount => 'Connectez-vous à votre compte';

  @override
  String get deleteAccountConfirmation => 'Votre compte sera supprimé définitivement. Vos données ne seront plus restaurées.';

  @override
  String get dangerZone => 'Zone dangereuse';

  @override
  String get helloGuest => 'Bonjour, Invité';

  @override
  String get signInWith => 'Se connecter avec';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Pomme';

  @override
  String get termsConditionsMessage => "J'ai lu la clause de non-responsabilité et j'accepte les termes et conditions";

  @override
  String get pleaseAcceptTermsAndConditions => 'Veuillez accepter les termes et conditions';

  @override
  String get description => 'Description';

  @override
  String get serviceNote => "Remarque sur l'entretien";

  @override
  String get priceMayBeUpdated => 'Le prix peut être mis à jour';

  @override
  String get optionalDetails => 'Détails facultatifs';

  @override
  String get reschedule => 'Reprogrammer';

  @override
  String get priceDetails => 'Détails du prix';

  @override
  String get transactionId => 'identifiant de transaction';

  @override
  String get paymentStatus => 'Statut de paiement';

  @override
  String get paid => 'Payé';

  @override
  String get goBack => 'Retourner';

  @override
  String get noStaffAvailableForBranchMessage => 'Aucun personnel disponible pour le service sélectionné !';

  @override
  String get tryToChangeYourService => 'Essayez de changer votre service';

  @override
  String get pay => 'Payer';

  @override
  String get open => 'Ouvrir';

  @override
  String get closed => 'Fermé';

  @override
  String get selectEmployeeFirst => "Sélectionnez d'abord l'employé";

  @override
  String get yourBookingForHairBookingMessage => 'Votre réservation pour une coupe de cheveux a été réservée avec succès';

  @override
  String get back => 'Dos';

  @override
  String get taxIncluded => 'taxe inclu';

  @override
  String get demoUserCannotBeGrantedForThis => "L'utilisateur démo ne peut pas être autorisé pour cette action";

  @override
  String get payNow => 'Payez maintenant';

  @override
  String get pleaseTryAgain => 'Veuillez réessayer';

  @override
  String get somethingWentWrong => "Quelque chose s'est mal passé";

  @override
  String get yourInternetIsNotWorking => 'Votre Internet ne fonctionne pas';

  @override
  String get youCannotBookPrevious => 'Vous ne pouvez pas réserver les créneaux précédents';

  @override
  String get galleryWillBeAppearedHere => 'La galerie apparaîtra ici';

  @override
  String get goToBookingDetail => 'Aller aux détails de la réservation';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage => 'Votre paiement est effectué avec succès avec';

  @override
  String get paymentSuccessful => 'Paiement réussi!';

  @override
  String get edit => 'Modifier';

  @override
  String get bookingTimeSlotChangeMessage => 'Souhaitez-vous modifier le créneau horaire de cette réservation ?';

  @override
  String get change => 'Changement';

  @override
  String get profileUpdatedSuccessfully => 'Mise à jour du profil réussie';

  @override
  String get oldPasswordDoesNotMatchMessage => "Votre ancien mot de passe n'est pas correct!";

  @override
  String get bookingSuccessfullyUpdateMessage => 'La réservation a été mise à jour avec succès';

  @override
  String get newUpdate => 'Nouvelle mise à jour';

  @override
  String get anUpdateToIs => "Une mise à jour de $APP_NAME est disponible. Accédez au Play Store et téléchargez la nouvelle version de l'application.";

  @override
  String get closeApp => "Fermer l'application";

  @override
  String get paystack => 'Pile de paie';

  @override
  String get paypal => 'Pay Pal';

  @override
  String get male => 'Mâle';

  @override
  String get female => 'Femelle';

  @override
  String get other => 'Autre';

  @override
  String get gender => 'Genre';

  @override
  String get pleaseSelectTheDateFirst => "Veuillez d'abord sélectionner la date";

  @override
  String get thereAreNoBookings => 'Il n’y a aucune réservation répertoriée pour le moment. Gardez une trace de vos réservations ici.';

  @override
  String get payWithFlutterwave => 'Payer avec Flutterwave';

  @override
  String get transactionFailed => 'La transaction a échoué';

  @override
  String get transactionCancelled => 'Transaction annulée';

  @override
  String get flutterwave => 'Onde Flutter';

  @override
  String get paytm => 'Payer';

  @override
  String get areYouSureYouWantToRemove => 'Êtes-vous sûr de vouloir supprimer cet élément';

  @override
  String get remove => 'Retirer';

  @override
  String get you => 'Toi';

  @override
  String get veChanged => "j'ai changé";

  @override
  String get quantityTo => 'QUANTITÉ à';

  @override
  String get editAddress => "Modifier l'adresse";

  @override
  String get addNewAddress => 'Ajouter une nouvelle adresse';

  @override
  String get selectCountry => 'Choisissez le pays';

  @override
  String get selectState => "Sélectionnez l'état";

  @override
  String get selectCity => 'Sélectionnez une ville';

  @override
  String get pincode => 'Code PIN';

  @override
  String get addressLine => "Ligne d'adresse";

  @override
  String get writeAddressHere => "Écrivez l'adresse ici";

  @override
  String get writeLandmarkHere => 'Écrivez un point de repère ici';

  @override
  String get saveChanges => 'Sauvegarder les modifications';

  @override
  String get save => 'Sauvegarder';

  @override
  String get cart => 'Chariot';

  @override
  String get yourCartIsEmpty => 'Votre panier est vide';

  @override
  String get thereAreCurrentlyNoItems => "Il n'y a aucun produit dans votre panier actuellement. Commencez vos achats et ajoutez des articles à votre panier.";

  @override
  String get productPriceDetails => 'Détails du prix du produit';

  @override
  String get totalAmount => 'Montant total';

  @override
  String get selectAddress => "Sélectionnez l'adresse";

  @override
  String get opps => 'Opportunités';

  @override
  String get looksLikeYouHave => "il semble que vous n'ayez pas encore ajouté d'adresse.";

  @override
  String get primary => 'primaire';

  @override
  String get deliverHere => 'Livrez ici';

  @override
  String get areYouSureYouWantToDelete => 'Êtes-vous sûr de vouloir supprimer cette adresse';

  @override
  String get addressDeleteSuccessfully => 'Adresse supprimée avec succès';

  @override
  String get weAreNotShipping => "Nous n'expédions pas dans votre ville pour le moment";

  @override
  String get deliveryCharge => 'Frais de livraison';

  @override
  String get orders => 'Ordres';

  @override
  String get seeYourOrders => 'Voir vos commandes';

  @override
  String get myAddresses => 'Mes adresses';

  @override
  String get manageYourAddresses => 'Gérez vos adresses';

  @override
  String get shop => 'Boutique';

  @override
  String get aboutProduct => 'À propos du produit';

  @override
  String get qty => 'Quantité';

  @override
  String get orderDetail => 'Détails de la commande';

  @override
  String get orderDate => 'Date de commande';

  @override
  String get deliveredOn => 'Délivré le';

  @override
  String get deliveryStatus => 'Statut de livraison';

  @override
  String get cancelOrder => 'annuler la commande';

  @override
  String get doYouWantToCancel => 'Voulez-vous annuler cette commande';

  @override
  String get theOrderHasBeenCancelled => 'La commande a été annulée avec succès.';

  @override
  String get noOrdersFound => 'Aucune commande trouvée';

  @override
  String get thereAreNoOrders => "Aucune commande n'est répertoriée pour le moment. Gardez une trace de vos commandes ici.";

  @override
  String get tax => 'Impôt';

  @override
  String get shippingDetail => "Détails d'expédition";

  @override
  String get alternativeContactNumber => 'Numéro de contact alternatif :';

  @override
  String get addReview => 'Ajouter un commentaire';

  @override
  String get thanksYouForReview => "Merci pour l'examen !";

  @override
  String get selectUpToThreeImages => "Sélectionnez jusqu'à trois images !";

  @override
  String get doYouWantToRemove => 'Voulez-vous supprimer cette image';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get customerDetail => 'Détail du client';

  @override
  String get fullName => 'Nom et prénom';

  @override
  String get alternateContactNumber => 'Numéro de contact alternatif';

  @override
  String get orderSummary => 'Récapitulatif de la commande';

  @override
  String get shippingAddress => 'adresse de livraison';

  @override
  String get off => 'désactivé';

  @override
  String get discountedAmount => 'Montant réduit';

  @override
  String get proceed => 'Procéder';

  @override
  String get productReviews => 'Avis sur les produits';

  @override
  String get thanksForVoting => "Merci d'avoir voté";

  @override
  String get bestSellerProduct => 'Produit le plus vendu';

  @override
  String get dealsForYou => 'Offres pour vous';

  @override
  String get noProductsFound => 'Aucun produit trouvé';

  @override
  String get featured => 'En vedette';

  @override
  String get readMore => 'En savoir plus';

  @override
  String get readLess => 'Lire moins';

  @override
  String get brand => 'Marque';

  @override
  String get inclusiveOfAllTaxes => 'Toutes Taxes Comprises';

  @override
  String get outOfStock => 'En rupture de stock';

  @override
  String get productSize => 'Taille du produit';

  @override
  String get quantity => 'Quantité';

  @override
  String get noRatingsYet => "Aucune note pour l'instant";

  @override
  String get ratingAndReviews => 'Évaluation et avis';

  @override
  String get totalReviewsAndRatings => 'Total des avis et notes';

  @override
  String get ourMostLoveChewTreats => 'Nos friandises à mâcher les plus appréciées';

  @override
  String get allCategories => 'toutes catégories';

  @override
  String get thereAreNoCategories => "Il n'y a pas de catégories pour le moment. Gardez une trace de vos catégories ici.";

  @override
  String get searchForProduct => 'Rechercher un produit';

  @override
  String get atThisTimeThere => "Pour le moment, aucun produit ou catégorie n'est disponible";

  @override
  String get goToCart => 'ALLER AU PANIER';

  @override
  String get addToCart => 'AJOUTER AU PANIER';

  @override
  String get orderSuccessfullyPlaced => 'Commande passée avec succès';

  @override
  String get yorOrderHasBeen => 'Votre commande a été passée avec succès';

  @override
  String get goToOrderList => 'Aller à la liste de commandes';

  @override
  String get choosePaymentMethod => 'Choisissez le mode de paiement';

  @override
  String get chooseYourConvenientPayment => 'Choisissez votre option de paiement pratique.';

  @override
  String get placeOrder => 'Passer la commande';

  @override
  String get confirmOrder => 'Confirmer la commande';

  @override
  String get doYouConfirmThisPayment => 'Confirmez-vous ce paiement';

  @override
  String get wishlist => 'Liste de souhaits';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist =>
      "Il n'y a actuellement aucun article dans votre liste de souhaits. Commencez à ajouter les éléments que vous aimez pour les enregistrer plus tard.";

  @override
  String get price => 'Prix';

  @override
  String get productBrands => 'Marques de produits';

  @override
  String get searchBrand => 'Rechercher une marque';

  @override
  String get more => 'Plus';

  @override
  String get rating => 'Notation';

  @override
  String get weight => 'Poids';

  @override
  String get clearFilter => 'Effacer le filtre';

  @override
  String get applyFilter => 'Appliquer le filtre';

  @override
  String get orderPlaced => 'Commande passée';

  @override
  String get processing => 'Traitement';

  @override
  String get delivered => 'Livré';

  @override
  String get unpaid => 'Non payé';

  @override
  String get parchasedProducts => 'Produits séchés';

  @override
  String get productAmount => 'Montant du produit';

  @override
  String get filterBy => 'Filtrer par';

  @override
  String get bookingStatus => 'Statut de réservation';

  @override
  String get apply => 'Appliquer';

  @override
  String get searchOrder => 'Ordre de recherche';

  @override
  String get ciNetPay => 'cinet Payer';

  @override
  String get lblCheckOutWithCiNetPay => 'Paiement avec CinetPay';

  @override
  String get ciNetPayNotSupportedMessage => "CinetPay n'est pas pris en charge par vos devises";

  @override
  String get totalAmountShouldBeMoreThan => 'Le montant total doit être supérieur à';

  @override
  String get totalAmountShouldBeLessThan => 'Le montant total doit être inférieur à';

  @override
  String get yourPaymentFailedPleaseTryAgain => 'Votre paiement a échoué, veuillez réessayer';

  @override
  String get yourPaymentHasBeenMadeSuccessfully => 'Votre paiement a été effectué avec succès';

  @override
  String get lblInvalidTransaction => 'Transaction invalide';

  @override
  String get accessDeniedContactYourAdmin => "Accès refusé. Contactez votre administrateur pour obtenir de l'aide.";

  @override
  String get sadadPayment => 'Paiement Sadad';

  @override
  String get topUpWallet => 'Portefeuille de recharge';

  @override
  String get airtelMoneyPayment => 'Paiement Airtel Argent';

  @override
  String get paymentSuccess => 'Succès du paiement';

  @override
  String get redirectingToBookings => 'Redirection vers les réservations..';

  @override
  String get transactionIsInProcess => 'La transaction est en cours...';

  @override
  String get pleaseCheckThePayment => 'Veuillez vérifier que la demande de paiement est envoyée à votre numéro';

  @override
  String get enterYourMsisdnHere => 'Entrez votre msisdn ici';

  @override
  String get theTransactionIsStill =>
      'La transaction est toujours en cours de traitement et est dans un état ambigu. Veuillez faire la demande de transaction pour récupérer le statut de la transaction.';

  @override
  String get transactionIsSuccessful => 'La transaction est réussie';

  @override
  String get incorrectPinHasBeen => 'Un code PIN incorrect a été saisi';

  @override
  String get theUserHasExceeded => "L'utilisateur a dépassé la limite de transaction autorisée par son portefeuille";

  @override
  String get theAmountUserIs => "Le montant que l'utilisateur tente de transférer est inférieur au montant minimum autorisé";

  @override
  String get userDidnTEnterThePin => "L'utilisateur n'a pas saisi le code PIN";

  @override
  String get transactionInPendingState => 'Transaction en attente. Veuillez vérifier après un certain temps';

  @override
  String get userWalletDoesNot => "Le portefeuille de l'utilisateur n'a pas assez d'argent pour couvrir le montant à payer";

  @override
  String get theTransactionWasRefused => 'La transaction a été refusée';

  @override
  String get thisIsAGeneric => "Il s'agit d'un refus générique qui a plusieurs causes possibles";

  @override
  String get payeeIsAlreadyInitiated => "Le bénéficiaire est déjà initié pour désabonnement, interdit ou n'est pas enregistré sur la plateforme Airtel Money";

  @override
  String get theTransactionWasTimed => 'La transaction a expiré.';

  @override
  String get theTransactionWasNot => "La transaction n'a pas été trouvée.";

  @override
  String get xSignatureAndPayloadDid => 'La signature X et la charge utile ne correspondent pas';

  @override
  String get encryptionKeyHasBeen => 'La clé de cryptage a été récupérée avec succès';

  @override
  String get couldNotFetchEncryption => 'Impossible de récupérer la clé de chiffrement';

  @override
  String get transactionHasBeenExpired => 'La transaction a expiré';

  @override
  String get ambiguous => 'Ambiguë';

  @override
  String get success => 'Succès';

  @override
  String get incorrectPin => 'Épingle incorrecte';

  @override
  String get exceedsWithdrawalAmountLimitS => 'Dépasse la ou les limites du montant de retrait / Limite du montant de retrait dépassée';

  @override
  String get invalidAmount => 'Montant invalide';

  @override
  String get transactionIdIsInvalid => "L'ID de transaction n'est pas valide";

  @override
  String get inProcess => 'En cours';

  @override
  String get notEnoughBalance => "Pas assez d'équilibre";

  @override
  String get refused => 'Refusé';

  @override
  String get doNotHonor => "N'honore pas";

  @override
  String get transactionNotPermittedTo => 'Transaction non autorisée au bénéficiaire';

  @override
  String get transactionTimedOut => 'Transaction expirée';

  @override
  String get transactionNotFound => 'Transaction introuvable';

  @override
  String get forBidden => 'Interdit';

  @override
  String get successfullyFetchedEncryptionKey => 'Clé de cryptage récupérée avec succès';

  @override
  String get errorWhileFetchingEncryption => 'Erreur lors de la récupération de la clé de cryptage';

  @override
  String get transactionExpired => 'Transaction expirée';

  @override
  String get btnSubmit => 'Soumettre';

  @override
  String get midTransPayment => 'Paiement Midtrans';

  @override
  String get phonePe => 'Paiement par téléphone';

  @override
  String get availableCoupons => 'Coupons disponibles';

  @override
  String get youSaved => 'Tu as sauvegardé';

  @override
  String get couponIsRemoved => 'Le coupon est supprimé';

  @override
  String get pleaseSelectServices => 'Veuillez sélectionner les services';

  @override
  String get selectCoupon => 'Sélectionnez le coupon';

  @override
  String get validTill => "Valable jusqu'au";

  @override
  String get useThisCodeToGet => 'Utilisez ce code pour obtenir';

  @override
  String get downloadInvoice => 'Télécharger la facture';

  @override
  String get noCouponLeftIn => 'Aucun coupon restant sur votre compte.';

  @override
  String get noCouponsAvailable => 'Aucun coupon disponible.';

  @override
  String get couponAppliedSuccessfully => 'Coupon appliqué avec succès';

  @override
  String get pleaseAddCouponCode => 'Veuillez ajouter le code promo.';

  @override
  String get viewInvoice => 'Voir la facture';

  @override
  String get finalTotal => 'Total final';

  @override
  String get myDiscountCoupons => 'Mes bons de réduction';

  @override
  String get coupons => 'Coupons';

  @override
  String get valid => 'Valide';

  @override
  String get couponCodeCopied => 'Code promo copié';

  @override
  String get applyCoupon => 'Appliquer Coupon';

  @override
  String get enterYourCode => 'entrez votre code';

  @override
  String get couponCode => 'Code promo';

  @override
  String get couponDiscount => 'Coupon de réduction';

  @override
  String get packages => 'Emballer';

  @override
  String get purchaseNow => 'Achetez maintenant';

  @override
  String get viewDetail => 'Voir les détails';

  @override
  String get coupon => 'Coupon';

  @override
  String get package => 'Emballer';

  @override
  String get yourPackage => 'Votre colis';

  @override
  String get expiryIn => 'Expiration dans';

  @override
  String get packageExpiringSoon => 'Forfait expirant bientôt';

  @override
  String get exclusiveYearLongSalonPamper => "Forfait exclusif de soins de salon d'un an";

  @override
  String get whatSIncluded => 'Ce qui est inclu';

  @override
  String get mins => 'minutes';

  @override
  String get reclaim => 'Récupérer';

  @override
  String get selectedPackage => 'Forfait sélectionné';

  @override
  String get noPackagesFound => 'Aucun paquet trouvé';

  @override
  String get yourExistingPackage => 'Votre forfait existant';

  @override
  String get viewAllPackages => 'Afficher tous les forfaits';

  @override
  String get existingPackages => 'Forfaits existants';

  @override
  String get upgrade => 'Mise à niveau';

  @override
  String get mo => 'MO';

  @override
  String get days => 'Jours';

  @override
  String get yourPackageIsStillActive => 'Votre forfait est toujours actif.';

  @override
  String get packagesAvailable => 'Forfaits disponibles';

  @override
  String get yourBookedServices => 'Vos prestations réservées :';

  @override
  String get reused => 'Réutilisé';

  @override
  String get packageDetail => 'Détail du Forfait';

  @override
  String get ourPackages => 'Nos forfaits';

  @override
  String get explore => 'Explorer';

  @override
  String get myPackages => 'Mes forfaits';

  @override
  String get availablePackages => 'Forfaits disponibles';

  @override
  String get remainingQuantity => 'Quantité restante';

  @override
  String get useNow => 'Utiliser maintenant';

  @override
  String get removingPackage => 'Supprimer le paquet ?';

  @override
  String get doYouWantTo => 'Voulez-vous supprimer ce package et continuer avec';

  @override
  String get expiryBy => 'Expiration avant';

  @override
  String get expiringToday => "Expirant aujourd'hui";

  @override
  String get iHaveReadThe => "J'ai lu la clause de non-responsabilité et j'accepte les ";

  @override
  String get theCouponAmountExceeds => 'Le montant du coupon dépasse le prix du service';

  @override
  String get night => 'Nuit';

  @override
  String get morning => 'Matin';

  @override
  String get afternoon => 'Après-midi';

  @override
  String get evening => 'Soirée';

  @override
  String get newPasswordWarning => "Le nouveau mot de passe ne doit pas être le même que l'ancien mot de passe";

  @override
  String get note => 'Note';

  @override
  String get setAsPrimary => 'Définir comme principal';

  @override
  String get orderInvoice => 'Facture de commande';

  @override
  String get logisticPartner => 'Partenaire logistique';

  @override
  String get logisticContactNumber => 'Numéro de contact logistique';

  @override
  String get logisticAddress => 'Adresse logistique';

  @override
  String get wouldYouLikeToDownloadTheInvoice => 'Souhaitez-vous télécharger la facture ?';

  @override
  String get download => 'Télécharger';

  @override
  String get failedToAccessExternalStorage => 'Échec de laccès au stockage externe';

  @override
  String get invalidResponseOrLinkNotFound => 'Réponse invalide ou lien introuvable';

  @override
  String get failedToFetchInvoiceDetails => 'Échec de la récupération des détails de la facture';

  @override
  String get PayWithUpiApps => 'Payer avec les applications Upi';

  @override
  String get PaywithCard => 'Payer avec carte';

  @override
  String get ContactUsForAnyQuestionsOnYourOrder => 'Contactez-nous pour toute question sur votre commande';

  @override
  String get ThePaymentTransactionDescription => 'La description de lopération de paiement';

  @override
  String get FAQs => 'FAQ';

  @override
  String get noServicesAvailable => 'Aucun service disponible';
}

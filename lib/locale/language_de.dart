import '../configs.dart';
import 'languages.dart';

class LanguageDe extends BaseLanguage {
  @override
  String get tokenExpired => 'Token abgelaufen';

  @override
  String get badRequest => '400: Ungültige Anfrage';

  @override
  String get forbidden => '403 Verboten';

  @override
  String get pageNotFound => '404 Seite nicht gefunden';

  @override
  String get tooManyRequests => '429: Zu viele Anfragen';

  @override
  String get internalServerError => '500: Interner Serverfehler';

  @override
  String get badGateway => '502 Bad Gateway';

  @override
  String get serviceUnavailable => '503 Dienst nicht verfügbar';

  @override
  String get gatewayTimeout => '504: Gateway-Timeout';

  @override
  String get hey => 'Hey';

  @override
  String get helloUser => 'Hallo Benutzer!';

  @override
  String get createYourAccountFor => 'Erstellen Sie Ihr Konto für ein besseres Erlebnis';

  @override
  String get firstName => 'Vorname';

  @override
  String get lastName => 'Familienname, Nachname';

  @override
  String get email => 'Email';

  @override
  String get thisFieldIsRequired => 'Dieses Feld ist erforderlich';

  @override
  String get contactNumber => 'Kontakt Nummer';

  @override
  String get password => 'Passwort';

  @override
  String get signUp => 'Melden Sie sich an';

  @override
  String get alreadyHaveAnAccount => 'Sie haben bereits ein Konto?';

  @override
  String get signIn => 'Anmelden';

  @override
  String get welcomeBack => 'Willkommen zurück!';

  @override
  String get youHaveBeenMissed => 'Du wurdest schon lange vermisst';

  @override
  String get rememberMe => 'Erinnere dich an mich';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get registerNow => 'Jetzt registrieren';

  @override
  String get or => 'ODER';

  @override
  String get pleaseEnterValidOtp => 'Bitte geben Sie ein gültiges OTP ein';

  @override
  String get otpVerification => 'OTP-Verifizierung';

  @override
  String get checkYourMailAnd => 'Überprüfen Sie Ihre E-Mails und geben Sie den Code ein, den Sie erhalten';

  @override
  String get didNotGetTheOtp => 'Haben Sie das OTP nicht erhalten?';

  @override
  String get resendOtp => 'OTP erneut senden';

  @override
  String get verify => 'Verifizieren';

  @override
  String get enterYourEmailAddress => 'Geben sie ihre E-Mailadresse ein';

  @override
  String get aResetPasswordLink => 'Ein Link zum Zurücksetzen des Passworts wird an die oben eingegebene E-Mail-Adresse gesendet';

  @override
  String get resetPassword => 'Passwort zurücksetzen';

  @override
  String get areYouSureWantToPerformThisAction => 'Möchten Sie diese Aktion wirklich ausführen?';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'NEIN';

  @override
  String get gallery => 'Galerie';

  @override
  String get camera => 'Kamera';

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get update => 'Aktualisieren';

  @override
  String get changePassword => 'Kennwort ändern';

  @override
  String get newPasswordsMustBeDifferent => 'Neue Passwörter müssen sich von den vorherigen unterscheiden';

  @override
  String get oldPassword => 'Altes Passwort';

  @override
  String get newPassword => 'Neues Kennwort';

  @override
  String get thePasswordDoesNotMatch => 'Das Passwort stimmt nicht überein';

  @override
  String get reEnterPassword => 'Kennwort erneut eingeben';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get pleaseLoginAgain => 'Bitte melden Sie sich erneut an';

  @override
  String get loginSuccessfully => 'Anmeldung erfolgreich';

  @override
  String get noUserFound => 'Kein Benutzer gefunden';

  @override
  String get otpInvalidMessage => 'Der eingegebene Code ist ungültig. Bitte versuchen Sie es erneut';

  @override
  String get pleaseContactWithAdmin => 'Bitte wenden Sie sich an den Administrator';

  @override
  String get confirmOtp => 'Bestätigen Sie OTP';

  @override
  String get verified => 'Verifiziert';

  @override
  String get signInFailed => 'Anmeldung fehlgeschlagen';

  @override
  String get appleSigInIsNotAvailable => 'Apple SignIn ist für Ihr Gerät nicht verfügbar';

  @override
  String get emailAddressIsRequiredUpdateAppleAccount => 'E-Mailadresse wird benötigt. Bitte aktualisieren Sie die E-Mail-Adresse in Ihrem Apple-Konto';

  @override
  String get yourPasswordReset => 'Ihr Passwort wurde zurückgesetzt';

  @override
  String get yourAccountIsReady => 'Ihr Konto ist einsatzbereit. Genießen Sie unseren Spezialisten und unsere Dienstleistungen';

  @override
  String get yourPassWorResetSuccessfully => 'Ihr Passwort wurde erfolgreich zurückgesetzt';

  @override
  String get done => 'Erledigt';

  @override
  String get specialist => 'Spezialist';

  @override
  String get date => 'Datum';

  @override
  String get time => 'Zeit';

  @override
  String get payment => 'Zahlung';

  @override
  String get noDetailsFound => 'Keine Details gefunden';

  @override
  String get reload => 'Neu laden';

  @override
  String get locationInformation => 'Standortinformationen';

  @override
  String get name => 'Name';

  @override
  String get address => 'Adresse';

  @override
  String get quickBookAppointment => 'Schnelle Terminvereinbarung';

  @override
  String get service => 'Service';

  @override
  String get total => 'Gesamt';

  @override
  String get bookNow => 'buchen Sie jetzt';

  @override
  String get pleaseSelectService => 'Bitte Service auswählen';

  @override
  String get confirmBooking => 'Buchung bestätigen';

  @override
  String get doYouWantToConfirmBooking => 'Möchten Sie diese Buchung bestätigen?';

  @override
  String get paymentDetails => 'Zahlungsdetails';

  @override
  String get subtotal => 'Zwischensumme';

  @override
  String get tip => 'Tipp';

  @override
  String get discount => 'Rabatt';

  @override
  String get yourReview => 'Deine Bewertung';

  @override
  String get deleteReview => 'Bewertung löschen';

  @override
  String get doYouWantToDeleteReview => 'Möchten Sie diese Bewertung löschen?';

  @override
  String get viewAll => 'Alle ansehen';

  @override
  String get rate => 'Rate';

  @override
  String get paymentMethod => 'Bezahlverfahren';

  @override
  String get goToBookings => 'Gehen Sie zu Buchungen';

  @override
  String get yourBookingFor => 'Ihre Buchung für';

  @override
  String get bookingSuccessful => 'Buchung erfolgreich!';

  @override
  String get cashAfterService => 'Bargeld nach dem Service';

  @override
  String get razorpay => 'Razorpay';

  @override
  String get stripe => 'Streifen';

  @override
  String get doWantToBookAppointment => 'Möchten Sie diesen Termin buchen?';

  @override
  String get noTimeSlots => 'Keine Zeitfenster';

  @override
  String get availableSlots => 'Verfügbare Plätze';

  @override
  String get next => 'Nächste';

  @override
  String get pleaseSelectTimeSlotFirst => 'Bitte wählen Sie zuerst das Zeitfenster aus';

  @override
  String get chooseYourExpert => 'Wählen Sie Ihren Experten';

  @override
  String get pleaseChooseYourExpert => 'Bitte wählen Sie zuerst Ihren Experten aus';

  @override
  String get services => 'Dienstleistungen';

  @override
  String get cancelAppointment => 'Termin absagen';

  @override
  String get doYouWantToCancelBooking => 'Möchten Sie diese Buchung stornieren?';

  @override
  String get bookingInformation => 'Buchungsinformation';

  @override
  String get status => 'Status';

  @override
  String get chooseBranch => 'Wählen Sie Zweig';

  @override
  String get noBranchFound => 'Keine Filiale gefunden';

  @override
  String get doYouWantExplore => 'Möchten Sie erkunden';

  @override
  String get nearbyBranches => 'Filialen in der Nähe';

  @override
  String get about => 'Um';

  @override
  String get reviews => 'Rezensionen';

  @override
  String get staff => 'Personal';

  @override
  String get noServicesFound => 'Keine Dienste gefunden';

  @override
  String get noReviewsFound => 'Keine Bewertungen gefunden';

  @override
  String get yourReviewsWillBeAppearedHere => 'Ihre Bewertungen werden hier angezeigt';

  @override
  String get call => 'Anruf';

  @override
  String get direction => 'Richtung';

  @override
  String get noGalleryFound => 'Keine Galerie gefunden';

  @override
  String get workingHours => 'Arbeitszeit';

  @override
  String get ourCategory => 'Unsere Kategorie';

  @override
  String get noCategoryFound => 'Keine Kategorie gefunden';

  @override
  String get pressBackAgainToExitApp => 'Drücken Sie erneut „Zurück“, um die App zu verlassen';

  @override
  String get home => 'Heim';

  @override
  String get booking => 'Buchung';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get user => 'Benutzer';

  @override
  String get profile => 'Profil';

  @override
  String get setting => 'Einstellung';

  @override
  String get appLanguage => 'App-Sprache';

  @override
  String get theme => 'Thema';

  @override
  String get aboutApp => 'Über App';

  @override
  String get rateUs => 'Bewerten Sie uns';

  @override
  String get share => 'Aktie';

  @override
  String get help => 'Helfen';

  @override
  String get helpCenter => 'Hilfezentrum';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get tC => 'AGB';

  @override
  String get logout => 'Ausloggen';

  @override
  String get logoutYourAccount => 'Melden Sie Ihr Konto ab';

  @override
  String get ohNoYouAreLeaving => 'Oh nein, du gehst!';

  @override
  String get doYouWantToLogout => 'Möchten Sie sich abmelden?';

  @override
  String get noNotifications => 'Keine Benachrichtigungen';

  @override
  String get weLlNotifyYouOnce => 'Wir benachrichtigen Sie, sobald wir etwas für Sie haben';

  @override
  String get searchForServices => 'Nach Diensten suchen';

  @override
  String get searchServices => 'Suchdienste';

  @override
  String get searchBooking => 'Suche Buchung';

  @override
  String get topExperts => 'Top-Experten';

  @override
  String get theUserHasDeniedSpeechRecognition => 'Der Benutzer hat die Verwendung der Spracherkennung abgelehnt';

  @override
  String get category => 'Kategorie';

  @override
  String get kms => 'KMs';

  @override
  String get fromYourLocation => 'Von Ihrem Standort aus';

  @override
  String get noBookingsFound => 'Keine Buchungen gefunden';

  @override
  String get notAMember => 'Kein Mitglied?';

  @override
  String get noStaffFound => 'Kein Personal gefunden';

  @override
  String get contactInfo => 'Kontaktinformation';

  @override
  String get noReviewsYetFor => 'Noch keine Bewertungen für';

  @override
  String get language => 'Sprache';

  @override
  String get appTheme => 'App-Theme';

  @override
  String get termsConditions => 'Terms & amp; Bedingungen';

  @override
  String get app => 'App';

  @override
  String get light => 'Licht';

  @override
  String get dark => 'Dunkel';

  @override
  String get systemDefault => 'Systemfehler';

  @override
  String get chooseTheme => 'Thema wählen';

  @override
  String get allServices => 'Alle Dienstleistungen';

  @override
  String get searchFor => 'Suchen nach';

  @override
  String get subCategories => 'Unterkategorien';

  @override
  String get clear => 'Klar';

  @override
  String get welcomeToThe => 'Willkommen zu';

  @override
  String get salon => 'Salon';

  @override
  String get weProvideYouBestServiceMessage => 'Wir bieten Ihnen den besten Service und das Beste';

  @override
  String get userExperience => 'Benutzererfahrung';

  @override
  String get createAccount => 'Benutzerkonto erstellen';

  @override
  String get pending => 'Ausstehend';

  @override
  String get confirmed => 'Bestätigt';

  @override
  String get cancelled => 'Abgesagt';

  @override
  String get checkIn => 'Einchecken';

  @override
  String get checkOut => 'Kasse';

  @override
  String get completed => 'Vollendet';

  @override
  String get invalidUrl => 'ungültige URL';

  @override
  String get enterYourReviewOptional => 'Geben Sie Ihre Bewertung ein (optional)';

  @override
  String get cancel => 'Stornieren';

  @override
  String get submit => 'Einreichen';

  @override
  String get ratingIsRequired => 'Eine Bewertung ist erforderlich';

  @override
  String get timeSlotBookedMessage => 'ist bereits gebucht! Bitte wählen Sie ein anderes Zeitfenster';

  @override
  String get branchName => 'Zweigname';

  @override
  String get place => 'Ort';

  @override
  String get basedOn => 'Bezogen auf';

  @override
  String get review => 'Rezension';

  @override
  String get s => 'S';

  @override
  String get error => 'Fehler:';

  @override
  String get externalWallet => 'Externe Geldbörse:';

  @override
  String get userCancelled => 'Benutzer hat abgesagt';

  @override
  String get userNotFound => 'Benutzer nicht gefunden';

  @override
  String get dateIsRequired => 'Datum ist erforderlich';

  @override
  String get timeIsRequired => 'Zeit ist erforderlich';

  @override
  String get findYourNearestSalon => 'Finden Sie Ihren nächstgelegenen Salon';

  @override
  String get walkThrough1subTitle => 'Sie können ganz einfach den besten Friseur und Salon in Ihrer Nähe finden und das beste Serviceerlebnis genießen';

  @override
  String get pickAService => 'Wählen Sie einen Dienst';

  @override
  String get walkThrough2subTitle => 'Sie können Ihren Service und Ihren Spezialisten auswählen und eine schnelle Buchung erhalten';

  @override
  String get quickBooking => 'Schnelle Buchung';

  @override
  String get walkThrough3subTitle => 'Sie erhalten von uns den besten Service und den besten Spezialisten für Ihre Dienstleistungen';

  @override
  String get skip => 'Überspringen';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get signInYourAccount => 'Melden Sie sich in Ihrem Konto an';

  @override
  String get deleteAccountConfirmation => 'Ihr Konto wird dauerhaft gelöscht. Ihre Daten werden nicht erneut wiederhergestellt.';

  @override
  String get dangerZone => 'Gefahrenzone';

  @override
  String get helloGuest => 'Hallo, Gast';

  @override
  String get signInWith => 'Anmelden mit';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apfel';

  @override
  String get termsConditionsMessage => 'Ich habe den Haftungsausschluss gelesen und stimme den Allgemeinen Geschäftsbedingungen zu';

  @override
  String get pleaseAcceptTermsAndConditions => 'Bitte akzeptieren Sie die Allgemeinen Geschäftsbedingungen';

  @override
  String get description => 'Beschreibung';

  @override
  String get serviceNote => 'Servicehinweis';

  @override
  String get priceMayBeUpdated => 'Der Preis kann aktualisiert werden';

  @override
  String get optionalDetails => 'Optionale Details';

  @override
  String get reschedule => 'Neu planen';

  @override
  String get priceDetails => 'Preisdetails';

  @override
  String get transactionId => 'Transaktions-ID';

  @override
  String get paymentStatus => 'Zahlungsstatus';

  @override
  String get paid => 'Bezahlt';

  @override
  String get goBack => 'Geh zurück';

  @override
  String get noStaffAvailableForBranchMessage => 'Für den ausgewählten Service ist kein Personal verfügbar!';

  @override
  String get tryToChangeYourService => 'Versuchen Sie, Ihren Service zu ändern';

  @override
  String get pay => 'Zahlen';

  @override
  String get open => 'Offen';

  @override
  String get closed => 'Geschlossen';

  @override
  String get selectEmployeeFirst => 'Wählen Sie „Mitarbeiter zuerst“ aus';

  @override
  String get yourBookingForHairBookingMessage => 'Ihre Buchung für einen Haarschnitt wurde erfolgreich gebucht';

  @override
  String get back => 'Zurück';

  @override
  String get taxIncluded => 'Steuern inklusive';

  @override
  String get demoUserCannotBeGrantedForThis => 'Für diese Aktion kann kein Demo-Benutzer zugelassen werden';

  @override
  String get payNow => 'Zahlen Sie jetzt';

  @override
  String get pleaseTryAgain => 'Bitte versuche es erneut';

  @override
  String get somethingWentWrong => 'Etwas ist schief gelaufen';

  @override
  String get yourInternetIsNotWorking => 'Ihr Internet funktioniert nicht';

  @override
  String get youCannotBookPrevious => 'Sie können keine vorherigen Slots buchen';

  @override
  String get galleryWillBeAppearedHere => 'Die Galerie wird hier angezeigt';

  @override
  String get goToBookingDetail => 'Gehen Sie zu den Buchungsdetails';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage => 'Ihre Zahlung wurde erfolgreich mit bezahlt';

  @override
  String get paymentSuccessful => 'Bezahlung erfolgreich!';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get bookingTimeSlotChangeMessage => 'Möchten Sie das Zeitfenster dieser Buchung ändern?';

  @override
  String get change => 'Ändern';

  @override
  String get profileUpdatedSuccessfully => 'Profil erfolgreich aktualisiert';

  @override
  String get oldPasswordDoesNotMatchMessage => 'Ihr altes Passwort ist nicht korrekt!';

  @override
  String get bookingSuccessfullyUpdateMessage => 'Die Buchung wurde erfolgreich aktualisiert';

  @override
  String get newUpdate => 'Neues Update';

  @override
  String get anUpdateToIs => 'Ein Update für $APP_NAME ist verfügbar. Gehen Sie zum Play Store und laden Sie die neue Version der App herunter.';

  @override
  String get closeApp => 'App schließen';

  @override
  String get paystack => 'Gehaltsstapel';

  @override
  String get paypal => 'Paypal';

  @override
  String get male => 'Männlich';

  @override
  String get female => 'Weiblich';

  @override
  String get other => 'Andere';

  @override
  String get gender => 'Geschlecht';

  @override
  String get pleaseSelectTheDateFirst => 'Bitte wählen Sie zuerst das Datum aus';

  @override
  String get thereAreNoBookings => 'Zur Zeit sind keine Buchungen aufgeführt. Verfolgen Sie hier Ihre Buchungen.';

  @override
  String get payWithFlutterwave => 'Bezahlen Sie mit Flutterwave';

  @override
  String get transactionFailed => 'Transaktion fehlgeschlagen';

  @override
  String get transactionCancelled => 'Transaktion abgebrochen';

  @override
  String get flutterwave => 'Flatterwelle';

  @override
  String get paytm => 'Paytm';

  @override
  String get areYouSureYouWantToRemove => 'Sind Sie sicher, dass Sie dieses Element entfernen möchten?';

  @override
  String get remove => 'Entfernen';

  @override
  String get you => 'Du';

  @override
  String get veChanged => 'Ich habe mich geändert';

  @override
  String get quantityTo => 'MENGE bis';

  @override
  String get editAddress => 'Adresse bearbeiten';

  @override
  String get addNewAddress => 'Neue Adresse hinzufügen';

  @override
  String get selectCountry => 'Land auswählen';

  @override
  String get selectState => 'Staat wählen';

  @override
  String get selectCity => 'Stadt wählen';

  @override
  String get pincode => 'Geheimzahl';

  @override
  String get addressLine => 'Adresszeile';

  @override
  String get writeAddressHere => 'Geben Sie hier die Adresse ein';

  @override
  String get writeLandmarkHere => 'Schreiben Sie hier Landmark';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get save => 'Speichern';

  @override
  String get cart => 'Wagen';

  @override
  String get yourCartIsEmpty => 'Ihr Warenkorb ist leer';

  @override
  String get thereAreCurrentlyNoItems => 'Derzeit befinden sich keine Artikel in Ihrem Warenkorb. Beginnen Sie mit dem Einkauf und legen Sie Artikel in Ihren Warenkorb.';

  @override
  String get productPriceDetails => 'Details zum Produktpreis';

  @override
  String get totalAmount => 'Gesamtmenge';

  @override
  String get selectAddress => 'Wählen Sie Adresse';

  @override
  String get opps => 'Upps';

  @override
  String get looksLikeYouHave => 'Anscheinend haben Sie noch keine Adresse hinzugefügt.';

  @override
  String get primary => 'primär';

  @override
  String get deliverHere => 'Hier liefern';

  @override
  String get areYouSureYouWantToDelete => 'Sind Sie sicher, dass Sie diese Adresse löschen möchten?';

  @override
  String get addressDeleteSuccessfully => 'Adresse erfolgreich gelöscht';

  @override
  String get weAreNotShipping => 'Wir versenden derzeit nicht in Ihre Stadt';

  @override
  String get deliveryCharge => 'Zustellgebühr';

  @override
  String get orders => 'Aufträge';

  @override
  String get seeYourOrders => 'Sehen Sie sich Ihre Bestellungen an';

  @override
  String get myAddresses => 'Meine Adressen';

  @override
  String get manageYourAddresses => 'Verwalten Sie Ihre Adressen';

  @override
  String get shop => 'Geschäft';

  @override
  String get aboutProduct => 'Über das Produkt';

  @override
  String get qty => 'Menge';

  @override
  String get orderDetail => 'Bestelldetails';

  @override
  String get orderDate => 'Auftragsdatum';

  @override
  String get deliveredOn => 'Geliefert am';

  @override
  String get deliveryStatus => 'Lieferstatus';

  @override
  String get cancelOrder => 'Bestellung stornieren';

  @override
  String get doYouWantToCancel => 'Möchten Sie diese Bestellung stornieren?';

  @override
  String get theOrderHasBeenCancelled => 'Die Bestellung wurde erfolgreich storniert.';

  @override
  String get noOrdersFound => 'Keine Bestellungen gefunden';

  @override
  String get thereAreNoOrders => 'Im Moment sind keine Bestellungen aufgeführt. Verfolgen Sie hier Ihre Bestellungen.';

  @override
  String get tax => 'Steuer';

  @override
  String get shippingDetail => 'Versanddetails';

  @override
  String get alternativeContactNumber => 'Alternative Kontaktnummer:';

  @override
  String get addReview => 'Bewertung hinzufügen';

  @override
  String get thanksYouForReview => 'Vielen Dank für die Bewertung!';

  @override
  String get selectUpToThreeImages => 'Wählen Sie bis zu drei Bilder aus!';

  @override
  String get doYouWantToRemove => 'Möchten Sie dieses Bild entfernen?';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get customerDetail => 'Kundendetails';

  @override
  String get fullName => 'Vollständiger Name';

  @override
  String get alternateContactNumber => 'Alternative Kontaktnummer';

  @override
  String get orderSummary => 'Bestellübersicht';

  @override
  String get shippingAddress => 'Lieferanschrift';

  @override
  String get off => 'aus';

  @override
  String get discountedAmount => 'Ermäßigter Betrag';

  @override
  String get proceed => 'Fortfahren';

  @override
  String get productReviews => 'Produktrezensionen';

  @override
  String get thanksForVoting => 'Danke für das Abstimmen';

  @override
  String get bestSellerProduct => 'Bestseller-Produkt';

  @override
  String get dealsForYou => 'Angebote für Sie';

  @override
  String get noProductsFound => 'Keine Produkte gefunden';

  @override
  String get featured => 'Hervorgehoben';

  @override
  String get readMore => 'Mehr lesen';

  @override
  String get readLess => 'Lese weniger';

  @override
  String get brand => 'Marke';

  @override
  String get inclusiveOfAllTaxes => 'Inklusive aller Steuern';

  @override
  String get outOfStock => 'Ausverkauft';

  @override
  String get productSize => 'Produktgröße';

  @override
  String get quantity => 'Menge';

  @override
  String get noRatingsYet => 'Noch keine Bewertungen';

  @override
  String get ratingAndReviews => 'Bewertung und Rezensionen';

  @override
  String get totalReviewsAndRatings => 'Gesamtzahl der Rezensionen und Bewertungen';

  @override
  String get ourMostLoveChewTreats => 'Unsere beliebtesten Kausnacks';

  @override
  String get allCategories => 'Alle Kategorien';

  @override
  String get thereAreNoCategories => 'Zur Zeit sind keine Kategorien vorhanden. Behalten Sie hier den Überblick über Ihre Kategorien.';

  @override
  String get searchForProduct => 'Nach Produkt suchen';

  @override
  String get atThisTimeThere => 'Derzeit sind keine Produkte oder Kategorien verfügbar';

  @override
  String get goToCart => 'ZUM EINKAUFSKORB GEHEN';

  @override
  String get addToCart => 'IN DEN WARENKORB LEGEN';

  @override
  String get orderSuccessfullyPlaced => 'Bestellung erfolgreich aufgegeben';

  @override
  String get yorOrderHasBeen => 'Ihre Bestellung wurde erfolgreich aufgegeben';

  @override
  String get goToOrderList => 'Gehen Sie zur Bestellliste';

  @override
  String get choosePaymentMethod => 'Zahlungsart auswählen';

  @override
  String get chooseYourConvenientPayment => 'Wählen Sie Ihre bequeme Zahlungsoption.';

  @override
  String get placeOrder => 'Bestellung aufgeben';

  @override
  String get confirmOrder => 'Bestellung bestätigen';

  @override
  String get doYouConfirmThisPayment => 'Bestätigen Sie diese Zahlung?';

  @override
  String get wishlist => 'Wunschzettel';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist =>
      'Derzeit befinden sich keine Artikel auf Ihrer Wunschliste. Beginnen Sie mit dem Hinzufügen von Artikeln, die Ihnen gefallen, um sie für später aufzubewahren.';

  @override
  String get price => 'Preis';

  @override
  String get productBrands => 'Produktmarken';

  @override
  String get searchBrand => 'Marke suchen';

  @override
  String get more => 'Mehr';

  @override
  String get rating => 'Bewertung';

  @override
  String get weight => 'Gewicht';

  @override
  String get clearFilter => 'Filter löschen';

  @override
  String get applyFilter => 'Filter anwenden';

  @override
  String get orderPlaced => 'Bestellung aufgegeben';

  @override
  String get processing => 'wird bearbeitet';

  @override
  String get delivered => 'Geliefert';

  @override
  String get unpaid => 'Unbezahlt';

  @override
  String get parchasedProducts => 'Ausgemusterte Produkte';

  @override
  String get productAmount => 'Produktmenge';

  @override
  String get filterBy => 'Filtern nach';

  @override
  String get bookingStatus => 'Buchungsstatus';

  @override
  String get apply => 'Anwenden';

  @override
  String get searchOrder => 'Suchreihenfolge';

  @override
  String get ciNetPay => 'Cinet Pay';

  @override
  String get lblCheckOutWithCiNetPay => 'Bezahlen Sie mit CinetPay';

  @override
  String get ciNetPayNotSupportedMessage => 'CinetPay wird von Ihren Währungen nicht unterstützt';

  @override
  String get totalAmountShouldBeMoreThan => 'Der Gesamtbetrag sollte mehr als betragen';

  @override
  String get totalAmountShouldBeLessThan => 'Der Gesamtbetrag sollte weniger als betragen';

  @override
  String get yourPaymentFailedPleaseTryAgain => 'Ihre Zahlung ist fehlgeschlagen. Bitte versuchen Sie es erneut';

  @override
  String get yourPaymentHasBeenMadeSuccessfully => 'Ihre Zahlung wurde erfolgreich durchgeführt';

  @override
  String get lblInvalidTransaction => 'Ungültige Transaktion';

  @override
  String get accessDeniedContactYourAdmin => 'Zugriff abgelehnt. Wenden Sie sich an Ihren Administrator, um Unterstützung zu erhalten.';

  @override
  String get sadadPayment => 'Sadad-Zahlung';

  @override
  String get topUpWallet => 'Auflade-Wallet';

  @override
  String get airtelMoneyPayment => 'Airtel-Geldzahlung';

  @override
  String get paymentSuccess => 'Zahlungserfolg';

  @override
  String get redirectingToBookings => 'Weiterleitung zu Buchungen..';

  @override
  String get transactionIsInProcess => 'Transaktion ist in Bearbeitung...';

  @override
  String get pleaseCheckThePayment => 'Bitte überprüfen Sie, ob die Zahlungsanforderung an Ihre Nummer gesendet wurde';

  @override
  String get enterYourMsisdnHere => 'Geben Sie hier Ihre msisdn ein';

  @override
  String get theTransactionIsStill =>
      'Die Transaktion wird noch verarbeitet und befindet sich in einem unklaren Zustand. Bitte führen Sie die Transaktionsabfrage durch, um den Transaktionsstatus abzurufen.';

  @override
  String get transactionIsSuccessful => 'Die Transaktion ist erfolgreich';

  @override
  String get incorrectPinHasBeen => 'Es wurde eine falsche PIN eingegeben';

  @override
  String get theUserHasExceeded => 'Der Benutzer hat das zulässige Transaktionslimit seines Wallets überschritten';

  @override
  String get theAmountUserIs => 'Der Betrag, den der Benutzer zu überweisen versucht, liegt unter dem zulässigen Mindestbetrag';

  @override
  String get userDidnTEnterThePin => 'Der Benutzer hat die PIN nicht eingegeben';

  @override
  String get transactionInPendingState => 'Transaktion im Status „Ausstehend“. Bitte schauen Sie nach einiger Zeit nach';

  @override
  String get userWalletDoesNot => 'Das Guthaben des Benutzers reicht nicht aus, um den zu zahlenden Betrag zu decken';

  @override
  String get theTransactionWasRefused => 'Die Transaktion wurde abgelehnt';

  @override
  String get thisIsAGeneric => 'Hierbei handelt es sich um eine allgemeine Ablehnung, die mehrere mögliche Ursachen haben kann';

  @override
  String get payeeIsAlreadyInitiated => 'Für den Zahlungsempfänger wurde die Abwanderung bereits eingeleitet, er ist gesperrt oder nicht auf der Airtel Money-Plattform registriert';

  @override
  String get theTransactionWasTimed => 'Bei der Transaktion ist eine Zeitüberschreitung aufgetreten.';

  @override
  String get theTransactionWasNot => 'Die Transaktion wurde nicht gefunden.';

  @override
  String get xSignatureAndPayloadDid => 'X-Signatur und Nutzlast stimmten nicht überein';

  @override
  String get encryptionKeyHasBeen => 'Der Verschlüsselungsschlüssel wurde erfolgreich abgerufen';

  @override
  String get couldNotFetchEncryption => 'Der Verschlüsselungsschlüssel konnte nicht abgerufen werden';

  @override
  String get transactionHasBeenExpired => 'Die Transaktion ist abgelaufen';

  @override
  String get ambiguous => 'Mehrdeutig';

  @override
  String get success => 'Erfolg';

  @override
  String get incorrectPin => 'Falscher Pin';

  @override
  String get exceedsWithdrawalAmountLimitS => 'Auszahlungsbetragslimit(e) überschritten / Auszahlungsbetragslimit überschritten';

  @override
  String get invalidAmount => 'Ungültige Menge';

  @override
  String get transactionIdIsInvalid => 'Die Transaktions-ID ist ungültig';

  @override
  String get inProcess => 'In Bearbeitung';

  @override
  String get notEnoughBalance => 'Nicht genug Gleichgewicht';

  @override
  String get refused => 'Abgelehnt';

  @override
  String get doNotHonor => 'Nicht ehren';

  @override
  String get transactionNotPermittedTo => 'Dem Zahlungsempfänger ist die Transaktion nicht gestattet';

  @override
  String get transactionTimedOut => 'Zeitüberschreitung bei der Transaktion';

  @override
  String get transactionNotFound => 'Transaktion nicht gefunden';

  @override
  String get forBidden => 'Verboten';

  @override
  String get successfullyFetchedEncryptionKey => 'Der Verschlüsselungsschlüssel wurde erfolgreich abgerufen';

  @override
  String get errorWhileFetchingEncryption => 'Fehler beim Abrufen des Verschlüsselungsschlüssels';

  @override
  String get transactionExpired => 'Transaktion abgelaufen';

  @override
  String get btnSubmit => 'Einreichen';

  @override
  String get midTransPayment => 'Midtrans-Zahlung';

  @override
  String get phonePe => 'PhonePe-Zahlung';

  @override
  String get availableCoupons => 'Verfügbare Gutscheine';

  @override
  String get youSaved => 'Du hast gespeichert';

  @override
  String get couponIsRemoved => 'Der Gutschein wurde entfernt';

  @override
  String get pleaseSelectServices => 'Bitte wählen Sie Dienste aus';

  @override
  String get selectCoupon => 'Wählen Sie Gutschein aus';

  @override
  String get validTill => 'Gültig bis';

  @override
  String get useThisCodeToGet => 'Verwenden Sie diesen Code, um zu erhalten';

  @override
  String get downloadInvoice => 'Download Rechnung';

  @override
  String get noCouponLeftIn => 'Kein Coupon mehr auf Ihrem Konto.';

  @override
  String get noCouponsAvailable => 'Keine Gutscheine verfügbar.';

  @override
  String get couponAppliedSuccessfully => 'Gutschein erfolgreich angewendet';

  @override
  String get pleaseAddCouponCode => 'Bitte Gutscheincode hinzufügen.';

  @override
  String get viewInvoice => 'Rechnung anzeigen';

  @override
  String get finalTotal => 'Endgültige Summe';

  @override
  String get myDiscountCoupons => 'Meine Rabattgutscheine';

  @override
  String get coupons => 'Gutscheine';

  @override
  String get valid => 'Gültig';

  @override
  String get couponCodeCopied => 'Gutscheincode kopiert';

  @override
  String get applyCoupon => 'Gutschein anwenden';

  @override
  String get enterYourCode => 'Gib deinen Code ein';

  @override
  String get couponCode => 'Gutscheincode';

  @override
  String get couponDiscount => 'Coupon-Rabatt';

  @override
  String get packages => 'Paket';

  @override
  String get purchaseNow => 'Jetzt kaufen';

  @override
  String get viewDetail => 'Im Detail sehen';

  @override
  String get coupon => 'Coupon';

  @override
  String get package => 'Paket';

  @override
  String get yourPackage => 'Dein Paket';

  @override
  String get expiryIn => 'Ablaufdatum';

  @override
  String get packageExpiringSoon => 'Paket läuft bald ab';

  @override
  String get exclusiveYearLongSalonPamper => 'Exklusives Salon-Verwöhnpaket für das ganze Jahr';

  @override
  String get whatSIncluded => 'Was ist inbegriffen';

  @override
  String get mins => 'Min';

  @override
  String get reclaim => 'Zurückfordern';

  @override
  String get selectedPackage => 'Ausgewähltes Paket';

  @override
  String get noPackagesFound => 'Keine Pakete gefunden';

  @override
  String get yourExistingPackage => 'Ihr bestehendes Paket';

  @override
  String get viewAllPackages => 'Alle Pakete anzeigen';

  @override
  String get existingPackages => 'Vorhandene Pakete';

  @override
  String get upgrade => 'Aktualisierung';

  @override
  String get mo => 'MO';

  @override
  String get days => 'Tage';

  @override
  String get yourPackageIsStillActive => 'Ihr Paket ist noch aktiv.';

  @override
  String get packagesAvailable => 'Pakete verfügbar';

  @override
  String get yourBookedServices => 'Ihre gebuchten Leistungen:';

  @override
  String get reused => 'Wiederverwendet';

  @override
  String get packageDetail => 'Paketdetails';

  @override
  String get ourPackages => 'Unsere Pakete';

  @override
  String get explore => 'Erkunden';

  @override
  String get myPackages => 'Meine Pakete';

  @override
  String get availablePackages => 'Verfügbare Pakete';

  @override
  String get remainingQuantity => 'Verbleibende Menge';

  @override
  String get useNow => 'Jetzt benutzen';

  @override
  String get removingPackage => 'Paket entfernen?';

  @override
  String get doYouWantTo => 'Möchten Sie dieses Paket entfernen und fortfahren?';

  @override
  String get expiryBy => 'Ablauf bis';

  @override
  String get expiringToday => 'Läuft heute ab';

  @override
  String get iHaveReadThe => 'Ich habe den Haftungsausschluss gelesen und bin damit einverstanden ';

  @override
  String get theCouponAmountExceeds => 'Der Gutscheinbetrag übersteigt den Servicepreis';

  @override
  String get night => 'Nacht';

  @override
  String get morning => 'Morgen';

  @override
  String get afternoon => 'Nachmittag';

  @override
  String get evening => 'Abend';

  @override
  String get newPasswordWarning => 'Das neue Passwort sollte nicht mit dem alten Passwort identisch sein';

  @override
  String get note => 'Notiz';

  @override
  String get setAsPrimary => 'Als primär festlegen';

  @override
  String get orderInvoice => 'Rechnung bestellen';

  @override
  String get logisticPartner => 'Logistikpartner';

  @override
  String get logisticContactNumber => 'Logistik-Kontaktnummer';

  @override
  String get logisticAddress => 'Logistikadresse';

  @override
  String get wouldYouLikeToDownloadTheInvoice => 'Möchten Sie die Rechnung herunterladen?';

  @override
  String get download => 'Herunterladen';

  @override
  String get failedToAccessExternalStorage => 'Zugriff auf externen Speicher fehlgeschlagen';

  @override
  String get invalidResponseOrLinkNotFound => 'Ungültige Antwort oder Link nicht gefunden';

  @override
  String get failedToFetchInvoiceDetails => 'Rechnungsdetails konnten nicht abgerufen werden';

  @override
  String get PayWithUpiApps => 'Bezahlen Sie mit Upi-Apps';

  @override
  String get PaywithCard => 'Bezahlen Sie mit Karte';

  @override
  String get ContactUsForAnyQuestionsOnYourOrder => 'Kontaktieren Sie uns bei Fragen zu Ihrer Bestellung';

  @override
  String get ThePaymentTransactionDescription => 'Die Beschreibung der Zahlungstransaktion';

  @override
  String get FAQs => 'FAQs';

  @override
  String get noServicesAvailable => 'Keine Dienste verfügbar';
}

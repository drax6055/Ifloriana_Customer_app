import '../configs.dart';
import 'languages.dart';

class LanguageEs extends BaseLanguage {
  @override
  String get tokenExpired => 'Token caducado';

  @override
  String get badRequest => '400 Petición Incorrecta';

  @override
  String get forbidden => '403: Prohibido';

  @override
  String get pageNotFound => '404 Pagina no encontrada';

  @override
  String get tooManyRequests => '429: Demasiadas solicitudes';

  @override
  String get internalServerError => 'Error interno de servidor 500';

  @override
  String get badGateway => '502 Puerta de enlace no válida';

  @override
  String get serviceUnavailable => '503 Servicio no Disponible';

  @override
  String get gatewayTimeout => '504: Tiempo de espera de puerta de enlace';

  @override
  String get hey => 'Ey';

  @override
  String get helloUser => '¡Hola usuario!';

  @override
  String get createYourAccountFor => 'Cree su cuenta para una mejor experiencia';

  @override
  String get firstName => 'Nombre de pila';

  @override
  String get lastName => 'Apellido';

  @override
  String get email => 'Correo electrónico';

  @override
  String get thisFieldIsRequired => 'Este campo es obligatorio';

  @override
  String get contactNumber => 'Número de contacto';

  @override
  String get password => 'Contraseña';

  @override
  String get signUp => 'Inscribirse';

  @override
  String get alreadyHaveAnAccount => '¿Ya tienes una cuenta?';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get welcomeBack => '¡Bienvenido de nuevo!';

  @override
  String get youHaveBeenMissed => 'Te han extrañado por mucho tiempo';

  @override
  String get rememberMe => 'Acuérdate de mí';

  @override
  String get forgotPassword => '¿Has olvidado tu contraseña?';

  @override
  String get registerNow => 'Regístrate ahora';

  @override
  String get or => 'O';

  @override
  String get pleaseEnterValidOtp => 'Por favor ingrese una OTP válida';

  @override
  String get otpVerification => 'Verificación OTP';

  @override
  String get checkYourMailAnd => 'Revisa tu correo e ingresa el código que obtienes';

  @override
  String get didNotGetTheOtp => '¿No obtuviste la OTP?';

  @override
  String get resendOtp => 'Reenviar OTP';

  @override
  String get verify => 'Verificar';

  @override
  String get enterYourEmailAddress => 'Introduce tu dirección de correo electrónico';

  @override
  String get aResetPasswordLink => 'Se enviará un enlace para restablecer la contraseña a la dirección de correo electrónico ingresada anteriormente';

  @override
  String get resetPassword => 'Restablecer la contraseña';

  @override
  String get areYouSureWantToPerformThisAction => '¿Estás seguro de que quieres realizar esta acción?';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get gallery => 'Galería';

  @override
  String get camera => 'Cámara';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get update => 'Actualizar';

  @override
  String get changePassword => 'Cambiar la contraseña';

  @override
  String get newPasswordsMustBeDifferent => 'Las nuevas contraseñas deben ser diferentes a las anteriores.';

  @override
  String get oldPassword => 'Contraseña anterior';

  @override
  String get newPassword => 'Nueva contraseña';

  @override
  String get thePasswordDoesNotMatch => 'La contraseña no coincide';

  @override
  String get reEnterPassword => 'Escriba la contraseña otra vez';

  @override
  String get confirm => 'Confirmar';

  @override
  String get pleaseLoginAgain => 'Por favor inicie sesión nuevamente';

  @override
  String get loginSuccessfully => 'Iniciar sesión exitosamente';

  @override
  String get noUserFound => 'Usuario no encontrado';

  @override
  String get otpInvalidMessage => 'El código ingresado no es válido, inténtelo nuevamente.';

  @override
  String get pleaseContactWithAdmin => 'Por favor contacte con el administrador';

  @override
  String get confirmOtp => 'Confirmar OTP';

  @override
  String get verified => 'Verificado';

  @override
  String get signInFailed => 'Fallo al iniciar sesion';

  @override
  String get appleSigInIsNotAvailable => 'Apple SignIn no está disponible para su dispositivo';

  @override
  String get emailAddressIsRequiredUpdateAppleAccount => 'Se requiere Dirección de correo electrónico. Actualice el correo electrónico en su cuenta Apple';

  @override
  String get yourPasswordReset => 'Restablecer tu contraseña';

  @override
  String get yourAccountIsReady => 'Su cuenta está lista para usar. Disfrute de nuestro especialista y nuestros servicios';

  @override
  String get yourPassWorResetSuccessfully => 'Tu contraseña se restableció exitosamente';

  @override
  String get done => 'Hecho';

  @override
  String get specialist => 'Especialista';

  @override
  String get date => 'Fecha';

  @override
  String get time => 'Tiempo';

  @override
  String get payment => 'Pago';

  @override
  String get noDetailsFound => 'No se encontraron detalles';

  @override
  String get reload => 'Recargar';

  @override
  String get locationInformation => 'Información sobre la ubicación';

  @override
  String get name => 'Nombre';

  @override
  String get address => 'DIRECCIÓN';

  @override
  String get quickBookAppointment => 'Cita de reserva rápida';

  @override
  String get service => 'Servicio';

  @override
  String get total => 'Total';

  @override
  String get bookNow => 'Reservar ahora';

  @override
  String get pleaseSelectService => 'Por favor seleccione servicio';

  @override
  String get confirmBooking => 'Reserva confirmada';

  @override
  String get doYouWantToConfirmBooking => '¿Quieres confirmar esta reserva?';

  @override
  String get paymentDetails => 'Detalles del pago';

  @override
  String get subtotal => 'Total parcial';

  @override
  String get tip => 'Consejo';

  @override
  String get discount => 'Descuento';

  @override
  String get yourReview => 'Tu reseña';

  @override
  String get deleteReview => 'Eliminar reseña';

  @override
  String get doYouWantToDeleteReview => '¿Quieres eliminar esta reseña?';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get rate => 'Tasa';

  @override
  String get paymentMethod => 'Método de pago';

  @override
  String get goToBookings => 'Ir a Reservas';

  @override
  String get yourBookingFor => 'Tu reserva para';

  @override
  String get bookingSuccessful => '¡Reserva exitosa!';

  @override
  String get cashAfterService => 'Servicio posventa en efectivo';

  @override
  String get razorpay => 'pago de afeitar';

  @override
  String get stripe => 'Raya';

  @override
  String get doWantToBookAppointment => '¿Quieres reservar esta cita?';

  @override
  String get noTimeSlots => 'No hay intervalos de tiempo';

  @override
  String get availableSlots => 'Ranuras disponibles';

  @override
  String get next => 'Próximo';

  @override
  String get pleaseSelectTimeSlotFirst => 'Seleccione primero el horario';

  @override
  String get chooseYourExpert => 'Elija su experto';

  @override
  String get pleaseChooseYourExpert => 'Elija primero a su experto';

  @override
  String get services => 'Servicios';

  @override
  String get cancelAppointment => 'Cancelar cita';

  @override
  String get doYouWantToCancelBooking => '¿Quieres cancelar esta reserva?';

  @override
  String get bookingInformation => 'Infomación sobre reservas';

  @override
  String get status => 'Estado';

  @override
  String get chooseBranch => 'Elige Sucursal';

  @override
  String get noBranchFound => 'No se encontró ninguna sucursal';

  @override
  String get doYouWantExplore => '¿Quieres explorar?';

  @override
  String get nearbyBranches => 'Sucursales cercanas';

  @override
  String get about => 'Acerca de';

  @override
  String get reviews => 'Reseñas';

  @override
  String get staff => 'Personal';

  @override
  String get noServicesFound => 'No se encontraron servicios';

  @override
  String get noReviewsFound => 'No se encontraron reseñas';

  @override
  String get yourReviewsWillBeAppearedHere => 'Tus reseñas aparecerán aquí.';

  @override
  String get call => 'Llamar';

  @override
  String get direction => 'Dirección';

  @override
  String get noGalleryFound => 'No se encontró ninguna galería';

  @override
  String get workingHours => 'Horas Laborales';

  @override
  String get ourCategory => 'Nuestra categoría';

  @override
  String get noCategoryFound => 'No se encontró ninguna categoría';

  @override
  String get pressBackAgainToExitApp => 'Presione Atrás nuevamente para salir de la aplicación.';

  @override
  String get home => 'Hogar';

  @override
  String get booking => 'Reserva';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get user => 'Usuario';

  @override
  String get profile => 'Perfil';

  @override
  String get setting => 'Configuración';

  @override
  String get appLanguage => 'Idioma de la aplicación';

  @override
  String get theme => 'Tema';

  @override
  String get aboutApp => 'Acerca de la aplicación';

  @override
  String get rateUs => 'Nos califica';

  @override
  String get share => 'Compartir';

  @override
  String get help => 'Ayuda';

  @override
  String get helpCenter => 'Centro de ayuda';

  @override
  String get privacyPolicy => 'política de privacidad';

  @override
  String get tC => 'Términos y condiciones';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutYourAccount => 'Cierra sesión en tu cuenta';

  @override
  String get ohNoYouAreLeaving => '¡Oh no, te vas!';

  @override
  String get doYouWantToLogout => '¿Quieres cerrar sesión?';

  @override
  String get noNotifications => 'No Notificaciones';

  @override
  String get weLlNotifyYouOnce => 'Te avisaremos cuando tengamos algo para ti.';

  @override
  String get searchForServices => 'Buscar servicios';

  @override
  String get searchServices => 'Servicios de búsqueda';

  @override
  String get searchBooking => 'Buscar Reserva';

  @override
  String get topExperts => 'Mejores expertos';

  @override
  String get theUserHasDeniedSpeechRecognition => 'El usuario ha negado el uso del reconocimiento de voz.';

  @override
  String get category => 'Categoría';

  @override
  String get kms => 'KM';

  @override
  String get fromYourLocation => 'Desde tu ubicación';

  @override
  String get noBookingsFound => 'No se encontraron reservas';

  @override
  String get notAMember => '¿No es un miembro?';

  @override
  String get noStaffFound => 'No se encontró personal';

  @override
  String get contactInfo => 'Datos de contacto';

  @override
  String get noReviewsYetFor => 'Aún no hay reseñas para';

  @override
  String get language => 'Idioma';

  @override
  String get appTheme => 'Tema de la aplicación';

  @override
  String get termsConditions => 'Términos y condiciones';

  @override
  String get app => 'Aplicación';

  @override
  String get light => 'Luz';

  @override
  String get dark => 'Oscuro';

  @override
  String get systemDefault => 'Sistema por defecto';

  @override
  String get chooseTheme => 'Escoge un tema';

  @override
  String get allServices => 'Todos los servicios';

  @override
  String get searchFor => 'Buscar';

  @override
  String get subCategories => 'Subcategorías';

  @override
  String get clear => 'Claro';

  @override
  String get welcomeToThe => 'Bienvenida a la';

  @override
  String get salon => 'Salón';

  @override
  String get weProvideYouBestServiceMessage => 'Le brindamos los mejores servicios y la mejor';

  @override
  String get userExperience => 'experiencia de usuario';

  @override
  String get createAccount => 'Crear una cuenta';

  @override
  String get pending => 'Pendiente';

  @override
  String get confirmed => 'Confirmado';

  @override
  String get cancelled => 'Cancelado';

  @override
  String get checkIn => 'Registrarse';

  @override
  String get checkOut => 'Verificar';

  @override
  String get completed => 'Terminado';

  @override
  String get invalidUrl => 'URL invalida';

  @override
  String get enterYourReviewOptional => 'Ingrese su reseña (opcional)';

  @override
  String get cancel => 'Cancelar';

  @override
  String get submit => 'Entregar';

  @override
  String get ratingIsRequired => 'Se requiere calificación';

  @override
  String get timeSlotBookedMessage => '¡Ya está reservado! Por favor elige otra franja horaria';

  @override
  String get branchName => 'Nombre de la sucursal';

  @override
  String get place => 'Lugar';

  @override
  String get basedOn => 'Residencia en';

  @override
  String get review => 'Revisar';

  @override
  String get s => 's';

  @override
  String get error => 'Error:';

  @override
  String get externalWallet => 'Cartera externa:';

  @override
  String get userCancelled => 'Usuario cancelado';

  @override
  String get userNotFound => 'Usuario no encontrado';

  @override
  String get dateIsRequired => 'Se requiere fecha';

  @override
  String get timeIsRequired => 'Se requiere tiempo';

  @override
  String get findYourNearestSalon => 'Encuentra tu salón más cercano';

  @override
  String get walkThrough1subTitle => 'Puede encontrar fácilmente cerca de usted el mejor peluquero y salón y disfrutar de la mejor experiencia de servicio';

  @override
  String get pickAService => 'Elija un servicio';

  @override
  String get walkThrough2subTitle => 'Puede elegir su servicio y elegir su especialista y obtener una reserva rápida.';

  @override
  String get quickBooking => 'Reserva Rápida';

  @override
  String get walkThrough3subTitle => 'Obtendrá los mejores servicios y el mejor especialista de sus servicios de nuestro';

  @override
  String get skip => 'Saltar';

  @override
  String get getStarted => 'Empezar';

  @override
  String get delete => 'Borrar';

  @override
  String get deleteAccount => 'Borrar cuenta';

  @override
  String get signInYourAccount => 'Inicia sesión en tu cuenta';

  @override
  String get deleteAccountConfirmation => 'Su cuenta será eliminada permanentemente. Sus datos no serán restaurados nuevamente.';

  @override
  String get dangerZone => 'Zona peligrosa';

  @override
  String get helloGuest => 'Hola, invitado';

  @override
  String get signInWith => 'Inicia sesión con';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Manzana';

  @override
  String get termsConditionsMessage => 'He leído el aviso legal y acepto los términos y condiciones.';

  @override
  String get pleaseAcceptTermsAndConditions => 'Por favor acepte términos y condiciones';

  @override
  String get description => 'Descripción';

  @override
  String get serviceNote => 'Nota de servicio';

  @override
  String get priceMayBeUpdated => 'El precio puede actualizarse';

  @override
  String get optionalDetails => 'Detalles opcionales';

  @override
  String get reschedule => 'Reprogramar';

  @override
  String get priceDetails => 'Detalles del precio';

  @override
  String get transactionId => 'ID de transacción';

  @override
  String get paymentStatus => 'Estado de pago';

  @override
  String get paid => 'Pagado';

  @override
  String get goBack => 'Regresa';

  @override
  String get noStaffAvailableForBranchMessage => '¡No hay personal disponible para el servicio seleccionado!';

  @override
  String get tryToChangeYourService => 'Intente cambiar su servicio';

  @override
  String get pay => 'Pagar';

  @override
  String get open => 'Abierto';

  @override
  String get closed => 'Cerrado';

  @override
  String get selectEmployeeFirst => 'Seleccione el empleado primero';

  @override
  String get yourBookingForHairBookingMessage => 'Tu reserva de corte de pelo ha sido reservada con éxito.';

  @override
  String get back => 'Atrás';

  @override
  String get taxIncluded => 'impuesto incluido';

  @override
  String get demoUserCannotBeGrantedForThis => 'No se puede otorgar usuario de demostración para esta acción';

  @override
  String get payNow => 'Pagar ahora';

  @override
  String get pleaseTryAgain => 'Inténtalo de nuevo';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get yourInternetIsNotWorking => 'Tu internet no funciona';

  @override
  String get youCannotBookPrevious => 'No se pueden reservar plazas anteriores';

  @override
  String get galleryWillBeAppearedHere => 'La galería aparecerá aquí.';

  @override
  String get goToBookingDetail => 'Ir al detalle de la reserva';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage => 'Su pago se paga exitosamente con';

  @override
  String get paymentSuccessful => '¡Pago exitoso!';

  @override
  String get edit => 'Editar';

  @override
  String get bookingTimeSlotChangeMessage => '¿Quieres cambiar la franja horaria de esta reserva?';

  @override
  String get change => 'Cambiar';

  @override
  String get profileUpdatedSuccessfully => 'Perfil actualizado con éxito';

  @override
  String get oldPasswordDoesNotMatchMessage => '¡Tu antigua contraseña no es correcta!';

  @override
  String get bookingSuccessfullyUpdateMessage => 'La reserva se ha actualizado correctamente.';

  @override
  String get newUpdate => 'Nueva actualización';

  @override
  String get anUpdateToIs => 'Hay una actualización disponible para $APP_NAME. Vaya a Play Store y descargue la nueva versión de la aplicación.';

  @override
  String get closeApp => 'Cerrar app';

  @override
  String get paystack => 'pila de pago';

  @override
  String get paypal => 'PayPal';

  @override
  String get male => 'Masculino';

  @override
  String get female => 'Femenino';

  @override
  String get other => 'Otro';

  @override
  String get gender => 'Género';

  @override
  String get pleaseSelectTheDateFirst => 'Por favor seleccione la fecha primero';

  @override
  String get thereAreNoBookings => 'No hay reservas publicadas en este momento. Realice un seguimiento de sus reservas aquí.';

  @override
  String get payWithFlutterwave => 'Pagar con Flutterwave';

  @override
  String get transactionFailed => 'Transacción fallida';

  @override
  String get transactionCancelled => 'Transacción cancelada';

  @override
  String get flutterwave => 'Onda de aleteo';

  @override
  String get paytm => 'pago';

  @override
  String get areYouSureYouWantToRemove => '¿Estás seguro de que deseas eliminar este elemento?';

  @override
  String get remove => 'Eliminar';

  @override
  String get you => 'Tú';

  @override
  String get veChanged => 'he cambiado';

  @override
  String get quantityTo => 'CANTIDAD a';

  @override
  String get editAddress => 'Editar dirección';

  @override
  String get addNewAddress => 'Agregar nueva dirección';

  @override
  String get selectCountry => 'Seleccionar país';

  @override
  String get selectState => 'Seleccione estado';

  @override
  String get selectCity => 'Ciudad selecta';

  @override
  String get pincode => 'Código PIN';

  @override
  String get addressLine => 'Dirección';

  @override
  String get writeAddressHere => 'Escriba la dirección aquí';

  @override
  String get writeLandmarkHere => 'Escribe punto de referencia aquí';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get save => 'Ahorrar';

  @override
  String get cart => 'Carro';

  @override
  String get yourCartIsEmpty => 'Tu carrito esta vacío';

  @override
  String get thereAreCurrentlyNoItems => 'Actualmente no hay artículos en su carrito. Comience a comprar y agregue artículos a su carrito.';

  @override
  String get productPriceDetails => 'Detalles del precio del producto';

  @override
  String get totalAmount => 'Cantidad total';

  @override
  String get selectAddress => 'Seleccionar dirección';

  @override
  String get opps => 'Opps';

  @override
  String get looksLikeYouHave => 'Parece que aún no has agregado ninguna dirección.';

  @override
  String get primary => 'primario';

  @override
  String get deliverHere => 'Entregar aquí';

  @override
  String get areYouSureYouWantToDelete => '¿Estás seguro de que deseas eliminar esta dirección?';

  @override
  String get addressDeleteSuccessfully => 'Eliminación de dirección exitosa';

  @override
  String get weAreNotShipping => 'No hacemos envíos a tu ciudad ahora.';

  @override
  String get deliveryCharge => 'Gastos de envío';

  @override
  String get orders => 'Pedidos';

  @override
  String get seeYourOrders => 'Ver tus pedidos';

  @override
  String get myAddresses => 'Mis direcciones';

  @override
  String get manageYourAddresses => 'Gestiona tus direcciones';

  @override
  String get shop => 'Comercio';

  @override
  String get aboutProduct => 'Acerca del producto';

  @override
  String get qty => 'Cantidad';

  @override
  String get orderDetail => 'Detalle de la orden';

  @override
  String get orderDate => 'Fecha de orden';

  @override
  String get deliveredOn => 'Entregado en';

  @override
  String get deliveryStatus => 'Estado de entrega';

  @override
  String get cancelOrder => 'Cancelar orden';

  @override
  String get doYouWantToCancel => '¿Quieres cancelar este pedido?';

  @override
  String get theOrderHasBeenCancelled => 'El pedido ha sido cancelado exitosamente.';

  @override
  String get noOrdersFound => 'No se encontraron pedidos';

  @override
  String get thereAreNoOrders => 'No hay pedidos listados en este momento. Realice un seguimiento de sus pedidos aquí.';

  @override
  String get tax => 'Impuesto';

  @override
  String get shippingDetail => 'Detalle de envío';

  @override
  String get alternativeContactNumber => 'Número de contacto alternativo:';

  @override
  String get addReview => 'Agregar una opinión';

  @override
  String get thanksYouForReview => '¡Gracias por la reseña!';

  @override
  String get selectUpToThreeImages => '¡Selecciona hasta tres imágenes!';

  @override
  String get doYouWantToRemove => '¿Quieres eliminar esta imagen?';

  @override
  String get addPhoto => 'Añadir foto';

  @override
  String get customerDetail => 'Detalle del cliente';

  @override
  String get fullName => 'Nombre completo';

  @override
  String get alternateContactNumber => 'Número de contacto alternativo';

  @override
  String get orderSummary => 'Resumen del pedido';

  @override
  String get shippingAddress => 'Dirección de envío';

  @override
  String get off => 'apagado';

  @override
  String get discountedAmount => 'Monto descontado';

  @override
  String get proceed => 'Proceder';

  @override
  String get productReviews => 'Reseñas de productos';

  @override
  String get thanksForVoting => 'Gracias por votar';

  @override
  String get bestSellerProduct => 'Producto más vendido';

  @override
  String get dealsForYou => 'Ofertas para ti';

  @override
  String get noProductsFound => 'No se encontraron productos';

  @override
  String get featured => 'Presentado';

  @override
  String get readMore => 'Leer más';

  @override
  String get readLess => 'Leer menos';

  @override
  String get brand => 'Marca';

  @override
  String get inclusiveOfAllTaxes => 'Incluyendo todos los impuestos';

  @override
  String get outOfStock => 'Agotado';

  @override
  String get productSize => 'Tamaño del producto';

  @override
  String get quantity => 'Cantidad';

  @override
  String get noRatingsYet => 'Aún no hay calificaciones';

  @override
  String get ratingAndReviews => 'Calificación y reseñas';

  @override
  String get totalReviewsAndRatings => 'Reseñas y calificaciones totales';

  @override
  String get ourMostLoveChewTreats => 'Nuestras golosinas masticables más amorosas';

  @override
  String get allCategories => 'todas las categorias';

  @override
  String get thereAreNoCategories => 'No hay categorías por el momento. Mantenga un registro de sus categorías aquí.';

  @override
  String get searchForProduct => 'Buscar producto';

  @override
  String get atThisTimeThere => 'En este momento, no hay productos o categorías disponibles.';

  @override
  String get goToCart => 'IR AL CARRITO';

  @override
  String get addToCart => 'AÑADIR A LA CESTA';

  @override
  String get orderSuccessfullyPlaced => 'Pedido realizado con éxito';

  @override
  String get yorOrderHasBeen => 'Su pedido se ha realizado con éxito';

  @override
  String get goToOrderList => 'Ir a la Lista de la Orden';

  @override
  String get choosePaymentMethod => 'Elige el método de pago';

  @override
  String get chooseYourConvenientPayment => 'Elija su opción de pago conveniente.';

  @override
  String get placeOrder => 'Realizar pedido';

  @override
  String get confirmOrder => 'Confirmar pedido';

  @override
  String get doYouConfirmThisPayment => '¿Confirma este pago?';

  @override
  String get wishlist => 'Lista de deseos';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist => 'Actualmente no hay artículos en su lista de deseos. Comience a agregar elementos que le gusten y guárdelos para más adelante.';

  @override
  String get price => 'Precio';

  @override
  String get productBrands => 'Marcas de productos';

  @override
  String get searchBrand => 'Buscar marca';

  @override
  String get more => 'Más';

  @override
  String get rating => 'Clasificación';

  @override
  String get weight => 'Peso';

  @override
  String get clearFilter => 'Filtro claro';

  @override
  String get applyFilter => 'Aplicar filtro';

  @override
  String get orderPlaced => 'Pedido realizado';

  @override
  String get processing => 'Procesando';

  @override
  String get delivered => 'Entregado';

  @override
  String get unpaid => 'No pagado';

  @override
  String get parchasedProducts => 'Productos parchados';

  @override
  String get productAmount => 'cantidad de producto';

  @override
  String get filterBy => 'Filtrado por';

  @override
  String get bookingStatus => 'Estado de la reservación';

  @override
  String get apply => 'Aplicar';

  @override
  String get searchOrder => 'Orden de búsqueda';

  @override
  String get ciNetPay => 'cinet pagar';

  @override
  String get lblCheckOutWithCiNetPay => 'Pagar con CinetPay';

  @override
  String get ciNetPayNotSupportedMessage => 'CinetPay no es compatible con tus monedas';

  @override
  String get totalAmountShouldBeMoreThan => 'El importe total debe ser superior a';

  @override
  String get totalAmountShouldBeLessThan => 'El importe total debe ser inferior a';

  @override
  String get yourPaymentFailedPleaseTryAgain => 'Tu pago falló, inténtalo de nuevo.';

  @override
  String get yourPaymentHasBeenMadeSuccessfully => 'Su pago se ha realizado con éxito';

  @override
  String get lblInvalidTransaction => 'Transacción inválida';

  @override
  String get accessDeniedContactYourAdmin => 'Acceso denegado. Póngase en contacto con su administrador para obtener ayuda.';

  @override
  String get sadadPayment => 'Pago Sadad';

  @override
  String get topUpWallet => 'Cartera de recarga';

  @override
  String get airtelMoneyPayment => 'Pago de dinero de Airtel';

  @override
  String get paymentSuccess => 'pago exitoso';

  @override
  String get redirectingToBookings => 'Redirigiendo a reservas..';

  @override
  String get transactionIsInProcess => 'La transacción está en proceso...';

  @override
  String get pleaseCheckThePayment => 'Por favor verifique que la solicitud de pago se envíe a su número.';

  @override
  String get enterYourMsisdnHere => 'Ingrese su msisdn aquí';

  @override
  String get theTransactionIsStill => 'La transacción aún se está procesando y se encuentra en estado ambiguo. Realice la consulta de transacción para obtener el estado de la transacción.';

  @override
  String get transactionIsSuccessful => 'La transacción es exitosa';

  @override
  String get incorrectPinHasBeen => 'Se ha ingresado un PIN incorrecto';

  @override
  String get theUserHasExceeded => 'El usuario ha excedido el límite de transacciones permitido en su billetera';

  @override
  String get theAmountUserIs => 'La cantidad que el usuario intenta transferir es inferior a la cantidad mínima permitida';

  @override
  String get userDidnTEnterThePin => 'El usuario no ingresó el pin';

  @override
  String get transactionInPendingState => 'Transacción en estado pendiente. Por favor verifique después de algún tiempo';

  @override
  String get userWalletDoesNot => 'La billetera del usuario no tiene suficiente dinero para cubrir el monto a pagar';

  @override
  String get theTransactionWasRefused => 'La transacción fue rechazada.';

  @override
  String get thisIsAGeneric => 'Se trata de una negativa genérica que tiene varias causas posibles.';

  @override
  String get payeeIsAlreadyInitiated => 'El beneficiario ya está iniciado para la deserción, está prohibido o no está registrado en la plataforma Airtel Money';

  @override
  String get theTransactionWasTimed => 'Se agotó el tiempo de espera de la transacción.';

  @override
  String get theTransactionWasNot => 'La transacción no fue encontrada.';

  @override
  String get xSignatureAndPayloadDid => 'La firma x y la carga útil no coinciden';

  @override
  String get encryptionKeyHasBeen => 'La clave de cifrado se ha obtenido correctamente';

  @override
  String get couldNotFetchEncryption => 'No se pudo recuperar la clave de cifrado';

  @override
  String get transactionHasBeenExpired => 'La transacción ha caducado';

  @override
  String get ambiguous => 'Ambiguo';

  @override
  String get success => 'Éxito';

  @override
  String get incorrectPin => 'Pin incorrecto';

  @override
  String get exceedsWithdrawalAmountLimitS => 'Excede el(los) límite(s) de monto de retiro / Límite de monto de retiro excedido';

  @override
  String get invalidAmount => 'Monto invalido';

  @override
  String get transactionIdIsInvalid => 'El ID de transacción no es válido';

  @override
  String get inProcess => 'En proceso';

  @override
  String get notEnoughBalance => 'No hay suficiente equilibrio';

  @override
  String get refused => 'Rechazado';

  @override
  String get doNotHonor => 'No honrar';

  @override
  String get transactionNotPermittedTo => 'Transacción no permitida al beneficiario';

  @override
  String get transactionTimedOut => 'Transacción agotada';

  @override
  String get transactionNotFound => 'Transacción no encontrada';

  @override
  String get forBidden => 'Prohibido';

  @override
  String get successfullyFetchedEncryptionKey => 'Clave de cifrado obtenida correctamente';

  @override
  String get errorWhileFetchingEncryption => 'Error al obtener la clave de cifrado';

  @override
  String get transactionExpired => 'Transacción vencida';

  @override
  String get btnSubmit => 'Entregar';

  @override
  String get midTransPayment => 'Pago mediotrans';

  @override
  String get phonePe => 'Pago por teléfono';

  @override
  String get availableCoupons => 'Cupones disponibles';

  @override
  String get youSaved => 'Salvaste';

  @override
  String get couponIsRemoved => 'Se elimina el cupón';

  @override
  String get pleaseSelectServices => 'Por favor seleccione servicios';

  @override
  String get selectCoupon => 'Seleccionar cupón';

  @override
  String get validTill => 'Válida hasta';

  @override
  String get useThisCodeToGet => 'Utilice este código para obtener';

  @override
  String get downloadInvoice => 'Descargar factura';

  @override
  String get noCouponLeftIn => 'No queda ningún cupón en su cuenta.';

  @override
  String get noCouponsAvailable => 'No hay cupones disponibles.';

  @override
  String get couponAppliedSuccessfully => 'Cupón aplicado correctamente';

  @override
  String get pleaseAddCouponCode => 'Por favor agregue el código de cupón.';

  @override
  String get viewInvoice => 'Mirar la factura';

  @override
  String get finalTotal => 'Total final';

  @override
  String get myDiscountCoupons => 'Mis cupones de descuento';

  @override
  String get coupons => 'Cupones';

  @override
  String get valid => 'Válido';

  @override
  String get couponCodeCopied => 'Código de cupón copiado';

  @override
  String get applyCoupon => 'Aplicar cupón';

  @override
  String get enterYourCode => 'Ingrese su código';

  @override
  String get couponCode => 'Código promocional';

  @override
  String get couponDiscount => 'Cupón de descuento';

  @override
  String get packages => 'Paquete';

  @override
  String get purchaseNow => 'Comprar ahora';

  @override
  String get viewDetail => 'Ver Detalle';

  @override
  String get coupon => 'Cupón';

  @override
  String get package => 'Paquete';

  @override
  String get yourPackage => 'Tu equipaje';

  @override
  String get expiryIn => 'Caducidad en';

  @override
  String get packageExpiringSoon => 'El paquete expirará pronto';

  @override
  String get exclusiveYearLongSalonPamper => 'Paquete exclusivo de cuidados de salón durante todo el año';

  @override
  String get whatSIncluded => 'Qué está incluido';

  @override
  String get mins => 'minutos';

  @override
  String get reclaim => 'Reclamar';

  @override
  String get selectedPackage => 'Paquete seleccionado';

  @override
  String get noPackagesFound => 'No se encontraron paquetes';

  @override
  String get yourExistingPackage => 'Su paquete existente';

  @override
  String get viewAllPackages => 'Ver todos los paquetes';

  @override
  String get existingPackages => 'Paquetes existentes';

  @override
  String get upgrade => 'Mejora';

  @override
  String get mo => 'mes';

  @override
  String get days => 'Días';

  @override
  String get yourPackageIsStillActive => 'Tu paquete aún está activo.';

  @override
  String get packagesAvailable => 'Paquetes disponibles';

  @override
  String get yourBookedServices => 'Sus servicios reservados:';

  @override
  String get reused => 'Reutilizado';

  @override
  String get packageDetail => 'Detalle del paquete';

  @override
  String get ourPackages => 'Nuestros Paquetes';

  @override
  String get explore => 'Explorar';

  @override
  String get myPackages => 'Mis paquetes';

  @override
  String get availablePackages => 'Paquetes disponibles';

  @override
  String get remainingQuantity => 'Cantidad restante';

  @override
  String get useNow => 'Usar ahora';

  @override
  String get removingPackage => '¿Quitar paquete?';

  @override
  String get doYouWantTo => '¿Quieres eliminar este paquete y continuar con';

  @override
  String get expiryBy => 'Caducidad por';

  @override
  String get expiringToday => 'Venciendo hoy';

  @override
  String get iHaveReadThe => 'He leído el descargo de responsabilidad y acepto las ';

  @override
  String get theCouponAmountExceeds => 'El monto del cupón excede el precio del servicio.';

  @override
  String get appliedTaxes => 'Impuestos aplicados';
}

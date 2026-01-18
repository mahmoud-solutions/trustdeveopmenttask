import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustdeveopmenttask/core/routing/app_router.dart';
import 'package:trustdeveopmenttask/core/services/service_locator.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/domain/UseCase/addToCart/add_to_cart_usecase.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/presention/AddToCartCubit/cubit/addto_cart_cubit.dart';
import 'package:trustdeveopmenttask/features/cart%20screen/presention/GetCartCubit/cubit/cart_cubit.dart';
import 'package:trustdeveopmenttask/features/product/presention/cubit/gest_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(DevicePreview(enabled: true, builder: (context) => const MyTestApp()));
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GuestIdCubit>()..loadGuestId(),
        ),
        BlocProvider(
          create: (context) => AddTOCartCubit(
            sl<AddProductToCartUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => sl<CartCubit>(),
        ),
      ],
      child: MaterialApp.router(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        routerConfig: AppRouter.routes,
      ),
    );
  }
}

// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:trustdeveopmenttask/core/routing/app_router.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // AndroidGoogleMapsFlutter.useAndroidViewSurface = true;

//   // await initServiceLocator();

//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(324.77, 674.65),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return MaterialApp.router(
//           debugShowCheckedModeBanner: false,
//           useInheritedMediaQuery: true, // مهم مع DevicePreview
//           builder: DevicePreview.appBuilder, // مهم جداً مع DevicePreview
//           routerConfig: AppRouter.routes,
//         );
//       },
//     );
//   }
// }

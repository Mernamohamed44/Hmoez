import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_app_bar.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/features/change_password/view.dart';
import 'package:homez/features/login/view.dart';
import 'package:homez/features/notification/notification_view.dart';
import 'package:homez/features/profile/profile_cubit.dart';
import 'package:homez/features/profile/widgets/profile_item.dart';
import 'package:homez/features/profile_details/profile_details.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: const ProfileViewBody(),
    );
  }
}

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    cubit.profileInfoData();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileDataLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.mainColor,
            ),
          );
        }
        if (state is ProfileDataFailedState) {
          return CustomText(
            text: state.msg,
            color: ColorManager.red,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          );
        }
        var profileData = cubit.profileData!.data!.user;

        return Scaffold(
          backgroundColor: ColorManager.bgColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                const CustomAppBarTitle(
                  title: "My Account",
                  withBack: false,
                ),
                30.verticalSpace,
                ListTile(
                  onTap: () {
                    MagicRouter.navigateTo(
                        page: ProfileDetailsView(
                      fullName: '${profileData.fullname}',
                      phone: '${profileData.phone}',
                    ));
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: ColorManager.mainColor,
                  ),
                  title: CustomText(
                    text: '${profileData!.fullname}',
                    color: ColorManager.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
                12.verticalSpace,
                ProfileItem(
                  icon: AssetsStrings.bell,
                  text: "Notifications",
                  onTap: () {
                    MagicRouter.navigateTo(
                      page: const NotificationView(),
                    );
                  },
                ),
                ProfileItem(
                  icon: AssetsStrings.language,
                  text: "Language ",
                  onTap: () {},
                ),
                ProfileItem(
                  icon: AssetsStrings.info,
                  text: "About",
                  onTap: () {},
                ),
                ProfileItem(
                  icon: AssetsStrings.rateUs,
                  text: "Rate Us",
                  onTap: () {},
                ),
                ProfileItem(
                    icon: AssetsStrings.lock,
                    text: "Change Password",
                    haveTrailing: true,
                    onTap: () {
                      MagicRouter.navigateTo(
                        page: const ChangePasswordView(),
                      );
                    }),
                BlocListener<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is LogOutSuccessState) {
                      MagicRouter.navigateTo(
                        page: const LoginView(),
                        withHistory: false,
                      );
                    }
                  },
                  child: ProfileItem(
                    icon: AssetsStrings.logOut,
                    text: "Log Out",
                    haveTrailing: false,
                    onTap: () {
                      cubit.logOut();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';
import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/functions/functions.dart';
import 'package:bestwe2_0/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  File? _profileImage;
  bool _buttonPressed = false;

  Usermodel? currentuser;

  late TextEditingController fullNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController mobileController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController ageController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    final appState = Provider.of<ApplicationState>(context, listen: false);

    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });

      try {
        // ✅ 1. Call updateUser and get response
        final response = await appState.userState.updateUser(currentuser!, imageFile: _profileImage);

        // ✅ 2. Extract image path from response
        final imagePath = response['image'];
        final fullImageUrl = imagePath.startsWith('http')
            ? imagePath
            : 'http://10.10.13.22:9500$imagePath';

        // ✅ 3. Update local user
        setState(() {
          currentuser = currentuser!.copyWith(image: fullImageUrl);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile image updated successfully')),
        );
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }


  void _onEditPressed() async {
    setState(() {
      _buttonPressed = true;
    });

    final appState = Provider.of<ApplicationState>(context, listen: false);

    final updatedUser = Usermodel(
      full_name: fullNameController.text,
      email: emailController.text,
      address: addressController.text,
      age: int.tryParse(ageController.text),
      status: mobileController.text,
      //image: currentuser?.image,
    );

    await appState.userState.updateUser(updatedUser);
    setState(() {
      _buttonPressed = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated')),
    );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = Provider.of<ApplicationState>(context, listen: false);
      currentuser = appState.userState.userList.first; //  Assign currentuser here
      fullNameController.text = currentuser!.full_name;
      emailController.text = currentuser!.email;
      mobileController.text = currentuser!.status;
      addressController.text = currentuser!.address ?? '';
      ageController.text = currentuser!.age?.toString() ?? '';
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDABEB6),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF5B4025), size: 22.sp),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Profile Information',
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF5B4025),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Profile image section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFDABEB6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Center(
                  child: Stack(
                    children: [
                      // CircleAvatar(
                      //   radius: 64.r,
                      //   backgroundImage: _profileImage != null
                      //       ? FileImage(_profileImage!)
                      //       : const NetworkImage('https://randomuser.me/api/portraits/men/1.jpg') as ImageProvider,
                      //   backgroundColor: Colors.white,
                      // ),
                      CircleAvatar(
                        radius: 64.r,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : (currentuser != null && currentuser!.image != null && currentuser!.image!.isNotEmpty)
                            ? NetworkImage(fixImageUrl(currentuser!.image!))
                            : const NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
                        backgroundColor: Colors.white,
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(6.r),
                            child: Icon(Icons.camera_alt, color: const Color(0xFF5B4025), size: 20.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),

          // Profile information section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              child: Consumer<ApplicationState>(builder: (context, appState, _) {
                return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  _ProfileLabel('Your Name'),
                  _ProfileTextField(controller: fullNameController),
                  SizedBox(height: 16.h),
                  _ProfileLabel('E-mail'),
                  _ProfileTextField(controller: emailController),
                  SizedBox(height: 16.h),
                  _ProfileLabel('Mobile'),
                  _ProfileTextField(controller: mobileController),
                  SizedBox(height: 16.h),
                  _ProfileLabel('Address'),
                  _ProfileTextField(controller: addressController),
                  SizedBox(height: 16.h),
                  _ProfileLabel('Age'),
                  _ProfileTextField(controller: ageController),
                  SizedBox(height: 32.h),

                  // Edit Profile button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _buttonPressed ? const Color(0xFF5B4025) : Colors.white,
                      borderRadius: BorderRadius.circular(32.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(17, 12, 46, 0.08),
                          blurRadius: 32,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32.r),
                        onTap: _onEditPressed,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: Center(
                            child: Text(
                              'Edit Profile',
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: _buttonPressed ? Colors.white : const Color(0xFF5B4025),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              );
              },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileLabel extends StatelessWidget {
  final String text;
  const _ProfileLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 6.h),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          color: const Color(0xFF5B4025),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  const _ProfileTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.r),
          borderSide: BorderSide(color: const Color(0xFF5B4025)),
        ),
      ),
    );
  }
}

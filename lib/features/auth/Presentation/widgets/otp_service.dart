// import 'package:email_otp/email_otp.dart' show EmailOTP, OTPType;

// class OTPService {
//   final EmailOTP emailOTP = EmailOTP(); 

//   void configureOTP(String email) {
//     emailOTP.setConfig(
//       appEmail: "amera@gmail.com", 
//       appName: "Langora", // اسم التطبيق
//       userEmail: email, // البريد الإلكتروني للمستلم
//       otpLength: 4, // طول OTP
//       otpType: OTPType.digitsOnly, // نوع OTP (أرقام فقط)
//     );
//   }

//   Future<void> sendOTP(String email) async {
//     configureOTP(email); // تعيين الإعدادات للبريد المُرسل إليه
//     bool result = await emailOTP.sendOTP(); // إرسال الـ OTP

//     if (result) {
//       print("✅ OTP Sent to $email");
//     } else {
//       print("❌ Failed to send OTP");
//     }
//   }

//   Future<bool> verifyOTP(String otp) async {
//     bool isValid = await emailOTP.verifyOTP(otp: otp);
    
//     if (isValid) {
//       print("✅ OTP is valid!");
//     } else {
//       print("❌ Invalid OTP. Please try again.");
//     }
    
//     return isValid;
//   }
// }

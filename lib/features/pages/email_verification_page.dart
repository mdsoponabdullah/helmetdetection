import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'demo.dart';

class EmailVerificationPage extends StatefulWidget {

  final String userId;

  EmailVerificationPage({super.key, required this.userId});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  static int tmp=1;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: StreamBuilder<User?>(
          stream: _auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user != null) {
               if(tmp==1)
                {
                  whileNotVerified(user);
                }
                ;

                if (user.emailVerified) {
                  // Email is verified, navigate to another page
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Demo(userId: widget.userId,)),
                    );
                  });
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Please verify your email'),
                      ElevatedButton(
                        onPressed: () {
                          _sendEmailVerification(user);
                        },
                        child: Text('Resend Verification Email'),
                      ),ElevatedButton(
                        onPressed: () {
                          whileNotVerified(user);
                        },
                        child: Text('Refresh'),
                      ),
                    ],
                  );
                }
              } else {
                // User not logged in
                return Text('User not logged in');
              }
            } else {
              // Connection state not active
              return CircularProgressIndicator();
            }
            return Container(); // Return an empty container by default
          },
        ),
      ),
    );
  }

  Future<void> whileNotVerified(User user1) async {
    await user1.reload();
    await FirebaseAuth.instance.currentUser!.reload();
    bool emailVerified= FirebaseAuth.instance.currentUser!.emailVerified;
    if(user1 == null && emailVerified)
    {
      MaterialPageRoute(builder: (context) => Demo(userId: widget.userId,));

    }
  }
  Future<void> _sendEmailVerification(User user) async {
    await user.reload();

    try {

      await user.sendEmailVerification();
      //Navigator.pushNamed(context, "/login");
      // Show success message or navigate to a new screen
      print('Verification email sent');
    } catch (e) {
      // Show error message
      print('Error sending verification email: $e');
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:helmetdetection/features/pages/demo.dart';
//
// //import '../local_storage/share_preference_logic.dart';
//
// class EmailVerificationPage extends StatefulWidget {
//   final String userId;
//    const EmailVerificationPage({super.key, required this.userId});
//
//   @override
//   _EmailVerificationPageState createState() => _EmailVerificationPageState();
// }
//
// class _EmailVerificationPageState extends State<EmailVerificationPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkEmailVerification();
//   }
//
//   void _checkEmailVerification() async {
//     User? user = _auth.currentUser;
//     await user?.reload();
//     user = _auth.currentUser;
//
//     if (user != null && user.emailVerified) {
//       // Email is verified, redirect to another page
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => Demo(userId: widget.userId)),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Email Verification'),
//       ),
//       body: Center(
//         child: Text('Please verify your email.'),
//       ),
//     );
//   }
// }


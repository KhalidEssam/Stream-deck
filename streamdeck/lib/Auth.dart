// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // import 'auth_service.dart'; // Import the AuthService class

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Sign up with email and password
//   Future<User?> signUp(String email, String password) async {
//     try {
//       final UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final User? user = result.user;

//       if (user != null) {
//         // Create a document for the user in Firestore
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//           'email': user.email,
//         });
//       }

//       return user;
//     } catch (error) {
//       print('Error signing up: $error');
//       return null;
//     }
//   }

//   // Sign in with email and password
//   Future<User?> signIn(String email, String password) async {
//     try {
//       final UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return result.user;
//     } catch (error) {
//       print('Error signing in: $error');
//       return null;
//     }
//   }

//   // Sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }

// final AuthService authService = AuthService();

// class AuthPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Auth Page')),
//       body: DefaultTabController(
//         length: 2,
//         child: Column(
//           children: [
//             TabBar(
//               tabs: [
//                 Tab(text: 'Sign Up'),
//                 Tab(text: 'Sign In'),
//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   SignUpForm(), // Create SignUpForm widget
//                   SignInForm(), // Create SignInForm widget
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class SignUpForm extends StatefulWidget {
// //   @override
// //   _SignUpFormState createState() => _SignUpFormState();
// // }

// // class _SignUpFormState extends State<SignUpForm> {
// //   final _formKey = GlobalKey<FormState>();
// //   String _email = '';
// //   String _password = '';

// // void _submitForm() async {
// //   if (_formKey.currentState!.validate()) {
// //     _formKey.currentState!.save();

// //     final User? user = await authService.signUp(_email, _password);
// //     if (user != null) {
// //       print('Signed up: ${user.uid}');
// //       // Navigate to next screen or perform other actions
// //     }
// //   }
// // }

// // @override
// //   Widget build(BuildContext context) {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         children: [
// //           TextFormField(
// //             decoration: InputDecoration(labelText: 'Email'),
// //             keyboardType: TextInputType.emailAddress,
// //             validator: (value) {
// //               if (value!.isEmpty || !value.contains('@')) {
// //                 return 'Invalid email';
// //               }
// //               return null;
// //             },
// //             onSaved: (value) => _email = value!,
// //           ),
// //           TextFormField(
// //             decoration: InputDecoration(labelText: 'Password'),
// //             obscureText: true,
// //             validator: (value) {
// //               if (value!.isEmpty || value.length < 6) {
// //                 return 'Password must be at least 6 characters';
// //               }
// //               return null;
// //             },
// //             onSaved: (value) => _password = value!,
// //           ),
// //           ElevatedButton(
// //             onPressed: _submitForm,
// //             child: Text('Sign Up'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// class SignInForm extends StatefulWidget {
//   @override
//   _SignInFormState createState() => _SignInFormState();
// }

// class _SignInFormState extends State<SignInForm> {
//   final _formKey = GlobalKey<FormState>();
//   String _email = '';
//   String _password = '';

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       final User? user = await authService.signIn(_email, _password);
//       if (user != null) {
//         print('Signed in: ${user.uid}');
//         // Navigate to next screen or perform other actions
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Email'),
//             keyboardType: TextInputType.emailAddress,
//             validator: (value) {
//               if (value!.isEmpty || !value.contains('@')) {
//                 return 'Invalid email';
//               }
//               return null;
//             },
//             onSaved: (value) => _email = value!,
//           ),
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Password'),
//             obscureText: true,
//             validator: (value) {
//               if (value!.isEmpty || value.length < 6) {
//                 return 'Password must be at least 6 characters';
//               }
//               return null;
//             },
//             onSaved: (value) => _password = value!,
//           ),
//           ElevatedButton(
//             onPressed: _submitForm,
//             child: Text('Sign In'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SignUpForm extends StatefulWidget {
//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }

// class _SignUpFormState extends State<SignUpForm> {
//   final _formKey = GlobalKey<FormState>();
//   String _email = '';
//   String _password = '';

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       final User? user = await authService.signUp(_email, _password);
//       if (user != null) {
//         print('Signed up: ${user.uid}');
//         // Navigate to next screen or perform other actions
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Email'),
//             keyboardType: TextInputType.emailAddress,
//             validator: (value) {
//               if (value!.isEmpty || !value.contains('@')) {
//                 return 'Invalid email';
//               }
//               return null;
//             },
//             onSaved: (value) => _email = value!,
//           ),
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Password'),
//             obscureText: true,
//             validator: (value) {
//               if (value!.isEmpty || value.length < 6) {
//                 return 'Password must be at least 6 characters';
//               }
//               return null;
//             },
//             onSaved: (value) => _password = value!,
//           ),
//           ElevatedButton(
//             onPressed: _submitForm,
//             child: Text('Sign Up'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/login_page.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/Locale_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/language_widget.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/role_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  bool isBlurred = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) => Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.language),
                    onPressed: () {
                      _showLanguageDialog(context);
                    },
                  ),
                ],
              ),
              body: Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    // Background content
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/logos/logos.png'),
                              Container(
                                height: 100,
                                width: 250,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    AppLocalization.of(context)
                                        .translate('On_boarding_title')!,
                                    style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2F394B),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 1),
                              Container(
                                height: 100,
                                width: 200,
                                child: Text(
                                  AppLocalization.of(context)
                                      .translate('On_boarding_desc')!,
                                  style: GoogleFonts.roboto(
                                      fontSize: 16, color: Color(0xFF8D8D8D)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 50),
                              SizedBox(
                                width: 250,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to roleWidget when the button is pressed
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => roleWidget()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 20,
                                      backgroundColor: Colors.blueAccent,
                                      shadowColor: Colors.blue.withOpacity(1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('Get_started')!,
                                      style: GoogleFonts.roboto(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                  },
                                  child: Text(
                                      AppLocalization.of(context)
                                          .translate('already_memeber')!,
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.blueAccent)))
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Blur effect when the button is pressed
                    isBlurred
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isBlurred = false;
                              });
                            },
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          )
                        : Container(),
                    // Popup rectangle widget
                    isBlurred
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              height:
                                  MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => roleWidget()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 20,
                                      backgroundColor: Colors.blueAccent,
                                      shadowColor:
                                          Colors.blue.withOpacity(1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('sign_up_with_email')!,
                                      style: GoogleFonts.roboto(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ));
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LocaleProvider>(
            builder: (context, localeProvider, _) => LanguageView((newLocale) {
                  // Call setLocale method with the new locale
                  localeProvider.setLocale(newLocale);
                }));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/login_page.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/Locale_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Register/role_widget.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/language_widget.dart';
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
        body: Container(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: IconButton(
                        icon: const Icon(Icons.language),
                        onPressed: () {
                          _showLanguageDialog(context);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/boarding.gif',
                          width: 320,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: FittedBox(
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
                          width: 220,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => roleWidget(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 20,
                              backgroundColor:
                                  Color.fromARGB(255, 118, 183, 221),
                              shadowColor:
                                  const Color.fromARGB(255, 144, 198, 243)
                                      .withOpacity(1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
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
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalization.of(context)
                                .translate('already_memeber')!,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Color.fromARGB(255, 76, 139, 175),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LocaleProvider>(
          builder: (context, localeProvider, _) => LanguageView(
            (newLocale) {
              localeProvider.setLocale(newLocale);
            },
          ),
        );
      },
    );
  }
}

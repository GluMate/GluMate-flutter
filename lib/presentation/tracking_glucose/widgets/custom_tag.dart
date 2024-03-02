

import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_record_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GlucTags extends StatefulWidget {
  const GlucTags({Key? key}) : super(key: key);

  @override
  State<GlucTags> createState() => _GlucTagsState();
}

class _GlucTagsState extends State<GlucTags> {
  int? selectedTagIndex;

  final List<String> tags = ['before meal','after meal','after medication','after working','before medication','fasting']; 

@override
void initState() {
    final glucProvider = Provider.of<GlucoseProvider>(context , listen: false);
   for (var i = 0; i < tags.length; i++) {
if (tags[i] == glucProvider.type){
  selectedTagIndex = i ;
}
};
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GlucoseProvider>(builder: (context , glucProvider , _) {
    return Wrap( 
      children: tags
          .asMap()
          .map((index, tag) => MapEntry(
                index,
                CustomTag(
                  tag: tag,
                  index: index,
                  onPressed: () {
                    setState(() {
                      selectedTagIndex = index;
                      glucProvider.setType(tags[selectedTagIndex!]);
                         
                    });
                      glucProvider.checkGlucRange(glucProvider.gluc, glucProvider.unit, glucProvider.type);
                  },
                  isSelected: selectedTagIndex == index,
                ),
              ))
          .values
          .toList(),
    );
    }
    );
  }
}

class CustomTag extends StatelessWidget {
  final String tag;
  final VoidCallback? onPressed;
  final int index;
  final bool isSelected;

  const CustomTag({
    Key? key,
    required this.tag,
    required this.index,
    this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: isSelected ? TColor.primaryColor1 : Colors.grey,
            width: isSelected ? 2 : 1

          ),
        ),
        child: Text(tag ,
        style: GoogleFonts.roboto(color: isSelected ? TColor.primaryColor1 : Colors.black,
        fontSize: isSelected ? 17 : 15,
        fontWeight: isSelected ? FontWeight.w600 : null),
        ),
      ),
    );
  }
}

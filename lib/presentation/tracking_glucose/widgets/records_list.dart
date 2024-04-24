import 'package:flutter/material.dart';
import 'package:glumate_flutter/buisness/entities/gluc_entity.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_record_provider.dart';
import 'package:provider/provider.dart';

class recordsList extends StatefulWidget {

      const recordsList({Key? key}) : super(key: key);

  @override
  State<recordsList> createState() => _recordsListState();
}

class _recordsListState extends State<recordsList> {
 void initState() {
    super.initState();
        Provider.of<RegisterAuthProvider>(context, listen : false).eitherFailureOrConnectedCachedUser(); 

       Provider.of<GlucoseProvider>(context, listen : false).eitherFailureOrFetchRecords(id:  Provider.of<RegisterAuthProvider>(context, listen : false).cachedUser!.id  ); 
}  
  @override
  Widget build(BuildContext context) {
        return Consumer<GlucoseProvider>(builder: (context , glucProvider , _) {
          if (glucProvider.isLoading){
            return const Center(
          child: CircularProgressIndicator(),
        );
          } else {
                return ListView.builder(
  itemCount: glucProvider.record!.length,
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),

  itemBuilder: (context, index) {
    return recordTile(item: glucProvider.record![index],);
    
  });
           }

      });
  }


  }

class recordTile extends StatefulWidget {
final GlucEntity item;
      const recordTile({Key? key , required this.item}) : super(key: key);

  @override
  State<recordTile> createState() => _recordTileState();
}

class _recordTileState extends State<recordTile> {
 
  @override
  Widget build(BuildContext context) {
    return Consumer<GlucoseProvider>(builder: (context , glucProvider , _) {
 return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xff764abc),
        child: Text(widget.item.metaData.type),
      ),
      title: Text('Item ${widget.item}'),
      subtitle: Text('Item description'),
      trailing: Icon(Icons.more_vert),
    );
    });
   
  }
}


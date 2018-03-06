import 'package:flutter/material.dart';

class Embarques extends StatefulBuilder {
	
	final String title = 'Embarques';	
    
	Widget build(BuildContext context, ) {

		return new Scaffold(
			appBar: new AppBar(
				title: new Text(title),
			),			
			body: new Container(				
				padding: new EdgeInsets.all(20.0),
				child: new Column(          
					mainAxisAlignment: MainAxisAlignment.start,
					children: <Widget>[
                        new Card( child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                                const ListTile(
                                    leading: const Icon(Icons.album),
                                    title: const Text('The Enchanted Nightingale'),
                                    subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                                ),
                            ], 
                        ),),
                    ],
                ),
            ),
		);
	}

}

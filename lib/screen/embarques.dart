import 'package:flutter/material.dart';

class Embarques extends StatefulWidget {

  final String title = 'Embarques';

  @override
  _MyEmbarquesState createState() => new _MyEmbarquesState(title: title);
}

class _MyEmbarquesState extends State<Embarques> {

  _MyEmbarquesState({
    Key key,
    this.title,
  });

  final String title;

  @override
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
                                    leading: const Icon(Icons.track_changes),
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

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:birdapp/bird_info.dart';

class BirdScreen extends StatefulWidget {
  @override
  _BirdScreenState createState() => _BirdScreenState();
}

class _BirdScreenState extends State<BirdScreen> {
  bool _isLoading;
  File _image;
  List _output;
  bool _isCamera;
  Map<String, List<String>> _birdInfo = {
    'Crow': [
      'The house crow is a common bird of the crow family that is of Asian origin but now found in many parts of the world.',
      'Conservation status: Least Concern (Population stable)',
      'House crows feed largely on refuse around human habitations, small reptiles and mammals.',
      'The trees in the local environment seem to be necessary for successful breeding.',
      'The voice is a harsh kaaw-kaaw.',
    ],
    'Emu': [
      'The emu is the second-largest living bird by height, after its ratite relative, the ostrich.',
      'Conservation status: Least Concern (Population stable)',
      'Emus are soft-feathered, brown, flightless birds with long necks and legs, and can reach up to 1.9 metres (6.2 ft) in height.',
      'Their diet depends on seasonal availability with such plants as Acacia, Casuarina and grasses being favoured.',
      'Emus begin to settle down at sunset and sleep during the night. They do not sleep continuously but rouse themselves several times during the night.'
    ],
    'Malabar Hornbill': [
      'The emu is the second-largest living bird by height, after its ratite relative, the ostrich.',
      'Conservation status: Least Concern (Population stable)',
      'Emus are soft-feathered, brown, flightless birds with long necks and legs, and can reach up to 1.9 metres (6.2 ft) in height.',
      'Their diet depends on seasonal availability with such plants as Acacia, Casuarina and grasses being favoured.',
      'Emus begin to settle down at sunset and sleep during the night. They do not sleep continuously but rouse themselves several times during the night.'
    ],
    'Flamingo': [
      'The emu is the second-largest living bird by height, after its ratite relative, the ostrich.',
      'Conservation status: Least Concern (Population stable)',
      'Emus are soft-feathered, brown, flightless birds with long necks and legs, and can reach up to 1.9 metres (6.2 ft) in height.',
      'Their diet depends on seasonal availability with such plants as Acacia, Casuarina and grasses being favoured.',
      'Emus begin to settle down at sunset and sleep during the night. They do not sleep continuously but rouse themselves several times during the night.'
    ],
    'Golden Eagle': [
      'Scientific Name : Aquila chrysaetos',
      'Behavior : Found alone or in pairs',
      'Geographic location : Mountains, hills, and cliffs. Found mostly in the western half of the U.S., they are rare in eastern states.',
      'Diet : Small to medium-sized mammals, including hares, rabbits, ground squirrels, prairie dogs, and marmots.',
      'Conservation status : Least Concern (Population Stable)',
      'Fact : The Golden Eagle is the most common official national animal in the world—it\'s the emblem of Albania, Germany, Austria, Mexico, and Kazakhstan.',
    ],
    'Cockatoo': [
      'The emu is the second-largest living bird by height, after its ratite relative, the ostrich.',
      'Conservation status: Least Concern (Population stable)',
      'Emus are soft-feathered, brown, flightless birds with long necks and legs, and can reach up to 1.9 metres (6.2 ft) in height.',
      'Their diet depends on seasonal availability with such plants as Acacia, Casuarina and grasses being favoured.',
      'Emus begin to settle down at sunset and sleep during the night. They do not sleep continuously but rouse themselves several times during the night.'
    ],
  };
  @override
  void initState() {
    _isLoading = true;
    loadModel().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  loadModel() async {
    return await Tflite.loadModel(
        model: "assets/VGG19_birds_model.tflite",
        labels: "assets/bird_labels.txt",
        isAsset: true);
  }

  chooseImage() async {
    var image = await ImagePicker()
        .getImage(source: _isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
      _isLoading = true;
    });
    classifyImage(_image);
  }

  classifyImage(image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path, // required
      numResults: 7, // defaults to 5
      threshold: 0.2, // defaults to 0.1
      asynch: true, // defaults to true
    );
    setState(() {
      _isLoading = false;
      _output = recognitions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bird Classification App'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null
                      ? Container()
                      : Flexible(
                          child: Image.file(
                            _image,
                            fit: BoxFit.cover,
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  _output != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: _output[0]["label"],
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    //   decoration: TextDecoration.underline,
                                    //   fontFeatures: [
                                    //     FontFeature.oldstyleFigures()
                                    //   ],
                                    //   decorationStyle: TextDecorationStyle.wavy,
                                    //   decorationThickness: 1.2,
                                    //   decorationColor:
                                    //       Theme.of(context).accentColor,
                                  ),
                                ),
                                // TextSpan(
                                //   text:
                                //       " with ${(_output[0]["confidence"] * 100).toStringAsFixed(2)}% confidence",
                                //   style: TextStyle(
                                //     fontSize: 32,
                                //     //fontWeight: FontWeight.bold,
                                //     fontStyle: FontStyle.italic,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  _output != null
                      ? Text(
                          'with ${(_output[0]["confidence"] * 100).toStringAsFixed(2)}% confidence',
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      : Container(),
                  _output != null && _output[0]["label"] != 'Unknown'
                      ? Expanded(
                          child: SizedBox(
                            height: 10,
                            child: ListView.builder(
                              itemBuilder: (
                                ctx,
                                index,
                              ) {
                                return BirdInfo(
                                  _output[0]["label"],
                                  index,
                                );
                              },
                              itemCount: 6,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
      persistentFooterButtons: <Widget>[
        FloatingActionButton(
          onPressed: () {
            _isCamera = true;
            chooseImage();
          },
          child: Icon(Icons.add_a_photo),
        ),
        FloatingActionButton(
          onPressed: () {
            _isCamera = false;
            chooseImage();
          },
          child: Icon(Icons.add_photo_alternate),
        ),
      ],
    );
  }
}

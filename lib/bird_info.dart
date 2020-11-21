import 'package:flutter/material.dart';

class BirdInfo extends StatelessWidget {
  final String output;
  final int index;
  final Map<String, List<String>> _birdInfo = {
    'Crow': [
      'Scientific Name : Corvus brachyrhynchos',
      'Behavior : Solitary, but they will often forage in groups',
      'Geographic location: Crows can be found all over the world in a variety of habitats.',
      'Diet : Feed on invertebrates of all types, carrion, scraps of human food, seeds, eggs and nestlings, stranded fish on the shore and various grains.',
      'Conservation status: Least Concern (Population stable)',
      'Fact : A group of crows is called a MURDER.'
    ],
    'Emu': [
      'Scientific Name : Dromaius novaehollandiae',
      'Behavior : Travel in pairs',
      'Geographic location : Most common in areas of savannah woodland and sclerophyll forest. Found on the east coast of Australia.',
      'Diet : Depends on seasonal availability with plants like Acacia, Casuarina and grasses.',
      'Conservation status : Least Concern (Population Stable).',
      'Fact : It is the SECOND-largest living bird by height, after its rarite relative, the ostrich',
    ],
    'Malabar Hornbill': [
      'Scientific Name : Ocyceros griseus',
      'Behavior : They move around in pairs or small groups',
      'Geographic location : Endemic to the Western Ghats and associated hills of southern India.',
      'Diet : fruits, small mammals, birds, small reptiles, insects etc.',
      'Conservation status : Least Concern (Population decreasing)',
      'Fact : The first two neck vertebrae of the hornbills have been fused to support their LARGE bill. Though its bill looks quite heavy, is actually very LIGHT; it is made up of thin-walled hollow cells.'
    ],
    'Flamingo': [
      'Scientific Name : Phoenicopterus',
      'Behavior : live and feed in groups called flocks or colonies.',
      'Geographic location : Caribbean islands, Caribbean Mexico, southern Florida, Belize, coastal Colombia, northern Brazil, Venezuela and Galápagos Islands.',
      'Diet : Flamingos eat larva, small insects, blue-green and red algae, mollusks, crustaceans and small fish.',
      'Conservation status: Least Concern (Population increasing)',
      'Fact : The flamingo is the national bird of The BAHAMAS.'
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
      'Scientific Name : Cacatuidae',
      'Behavior : travel in colourful and noisy flocks.',
      'Geographic location : Australia, New Zealand, and New Guinea.',
      'Diet : Depending on the species will eat an assortment of seeds, fruits, nuts, berries, blossoms, roots, and vegetation such as leaf buds.',
      'Conservation status: Not Extinct',
      'Fact : They are known to be one of the most affectionate parrot species and sometimes called VELCRO birds.'
    ],
  };
  BirdInfo(this.output, this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _birdInfo[output][index],
          style: TextStyle(
            fontSize: 20,
            fontWeight: index == 4 ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(5),
    );
  }
}

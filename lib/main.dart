import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Erwin, Nombre', 'Mapolopolo, Basista, Pangasinan', 'August 25, 2002',
        'https://www.facebook.com/sako.rage.7?mibextid=ZbWKwL'),
    Person('Dee Snider', 'Urbiztondo, Pangasinan', 'June 24, 2003',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/341508325_633061398639204_662283157573003216_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGZxvdIHTzMsGUg4zsyyZ5vzlJZ2s0Ng4fOUlnazQ2Dh0utRuc-7wbjuF-papL41pRWepl5rD6TqRG0UGoYyX1h&_nc_ohc=tJklt23GIxMAX9W1Pcl&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfC23BeWvYKBAnVIK257VJpSd8z-HcCVxTSgTJ-O883vqA&oe=64522E90'),
    Person('Axl Rose', 'Basista', 'May 15, 2004',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/332929348_244391291251185_2966350295333119476_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=174925&_nc_eui2=AeFcrRq-5YYTlIO3CC6wnO0bmrlF4g9Iut-auUXiD0i638QeokUkbs9tgsIVYfOTOrf0j7OAPf8DHgrZHnKSvLu9&_nc_ohc=67KYZFYZGOAAX-bC4cL&_nc_oc=AQkcvzT56y6eCm-K6-ktpf1vHRK_RJu5Lz2s2GJmO23UIwSgfCGsWdZGYSypB_OoW7Q&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfACL2Nsx1gueNAKwf9pFekq8uwHvfhNDcjyFioHGj7jtQ&oe=64514693'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIDTERM EXAM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/2677048.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 5, 3, 3),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 13, 9, 9),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Color.fromARGB(255, 0, 0, 0),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

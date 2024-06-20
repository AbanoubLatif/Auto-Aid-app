// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api
import 'package:flutter/material.dart';
import '../constants.dart';
import 'custom_container.dart';

class CarContainer extends StatefulWidget {
  const CarContainer({super.key,
    required this.StackHeight,
    required this.CustomContainerHeight,
    required this.TopPadding,
    required this.EditDeleteTopPadding,
  });

  final double StackHeight,
      CustomContainerHeight,
      TopPadding,
      EditDeleteTopPadding;

  @override

  _CarContainerState createState() => _CarContainerState();
}

class _CarContainerState extends State<CarContainer> {
  double currentKilometers = 120516; // الكيلومترات الحالية، يمكنك تعديلها على قيمتها الافتراضية

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.StackHeight,
      child: Stack(children: [
        Positioned(
          left: 15,
          right: 20,
          top: 30,
          child: Padding(
            padding: EdgeInsets.only(top: widget.TopPadding),
            child: CustomContainer(
              height: widget.CustomContainerHeight,
              column: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, left: 17),
                    child: Text(
                      'Toyota Crolla',
                      style: TextStyle(
                        color: KeyPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, left: 27),
                    child: Text(
                      '2012',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 27),
                    child: Text(
                      '$currentKilometers km',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, left: 27),
                    child: Text(
                      'Next service:',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, left: 50),
                    child: Text(
                      '130000 km',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 29),
                    child: Text(
                      'Last Service Status:',
                      style: TextStyle(
                        color: KeyPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, left: 70),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Color(0xff04D500),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 90,
          right: 5,
          child: Image.asset(
            'assets/images/toyota icon 1.png',
            height: 110,
            width: 177,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: widget.EditDeleteTopPadding,
          right: 60,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      double newKilometers = currentKilometers;
                      return AlertDialog(
                        title: const Text('Edit Kilometers'),
                        content: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            newKilometers = double.tryParse(value) ?? currentKilometers;
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                currentKilometers = newKilometers;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    color: KeyPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: KeyPrimaryColor,
                    decorationThickness: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: widget.EditDeleteTopPadding,
          right: 110,
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}

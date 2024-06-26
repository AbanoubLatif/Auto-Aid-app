import 'package:flutter/material.dart';

// قائمة السيارات والموديلات
Map<String, List<String>> carModels = {
  'Kia': [
    'Cerato 2012-2017',
    'Grand Cerato 2018-2023',
    'Carens 2010-2013',
    'Sportage 2012-2022',
    'Rio 2010-2017',
    'Sportage Turbo GDI 2022-2024',
    'Picanto 2004-2017',
    'Soul 2009-2017'
  ],
  'Hyundai': [
    'Tucson GDI 2017-2023',
    'Accent RB 2011-2024',
    'verna',
    'Elantra MD',
    'Elantra AD',
    'Elantra HD',
    'Accent HCI'
  ],
  'Toyota': ['Corolla', 'Yaris'],
  'Nissan': ['Sunny', 'Patrol'],
  'Chevrolet': ['Lanos', 'Optra', 'New Optra', 'Captiva', 'Curze', 'New Curze'],
  'Mitsubishi': ['Eclipse', 'Lancer', 'Pajero'],
  'Peugeot': ['208', '301', '508'],
  'Renault': ['Logan', 'Megan'],
  'MG': ['MG5', 'MG6'],
};

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);
  static String id='AddCarScreen';
  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();

  // قائمة السيارات المحددة
  List<String> selectedCarModels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarMakeTextField(
              controller: _makeController,
              onSelected: (selectedMake) {
                setState(() {
                  _makeController.text = selectedMake;
                  // حدد الموديلات المتاحة للمصنع المختار
                  selectedCarModels = carModels[selectedMake] ?? [];
                  // قم بمسح النص في حقل الموديل عند تغيير المصنع
                  _modelController.clear();
                });
              },
            ),
            SizedBox(height: 16),
            CarModelTextField(
              controller: _modelController,
              carModels: selectedCarModels,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _mileageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Car Mileage',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final carMake = _makeController.text;
                final carModel = _modelController.text;
                final carMileage =
                    int.tryParse(_mileageController.text) ?? 0;

                // Validate inputs if needed

                Navigator.of(context).pop({
                  'car_make': carMake,
                  'car_model': carModel,
                  'car_mileages': carMileage,
                });
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _mileageController.dispose();
    super.dispose();
  }
}

class CarMakeTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSelected;

  const CarMakeTextField({
    Key? key,
    required this.controller,
    required this.onSelected,
  }) : super(key: key);

  @override
  _CarMakeTextFieldState createState() => _CarMakeTextFieldState();
}

class _CarMakeTextFieldState extends State<CarMakeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Car Make',
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_downward_outlined, color: Colors.blue),
          itemBuilder: (BuildContext context) {
            return carModels.keys.map((String carMake) {
              return PopupMenuItem<String>(
                value: carMake,
                child: Text(carMake),
              );
            }).toList();
          },
          onSelected: (String value) {
            widget.onSelected(value);
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}

class CarModelTextField extends StatefulWidget {
  final TextEditingController controller;
  final List<String> carModels;

  const CarModelTextField({
    Key? key,
    required this.controller,
    required this.carModels,
  }) : super(key: key);

  @override
  _CarModelTextFieldState createState() => _CarModelTextFieldState();
}

class _CarModelTextFieldState extends State<CarModelTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Car Model',
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_downward_outlined, color: Colors.blue),
          itemBuilder: (BuildContext context) {
            return widget.carModels.map((String carModel) {
              return PopupMenuItem<String>(
                value: carModel,
                child: Text(carModel),
              );
            }).toList();
          },
          onSelected: (String value) {
            setState(() {
              widget.controller.text = value;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}

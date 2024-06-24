import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/custom_container.dart';

import '../widgets/custom_icon_back.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);
  static String id = 'ServicePage';

  @override
  // ignore: library_private_types_in_public_api
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  TextStyle textStyle = const TextStyle(
    color: KeyPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  bool isLoading = true;
  List<Map<String, dynamic>> maintenanceData = [];

  @override
  void initState() {
    super.initState();
    fetchMaintenanceData();
  }

  Future<void> fetchMaintenanceData() async {
    final storage = const FlutterSecureStorage();
    final data = await storage.read(key: 'maintenance_data');

    if (data != null) {
      setState(() {
        maintenanceData = List<Map<String, dynamic>>.from(jsonDecode(data));
        isLoading = false;
      });
    } else {
      throw Exception('Failed to retrieve maintenance data from storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const CustomIconBack(),
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                  child: CustomContainer(
                    width: 360,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Text(
                            'Next Service:                        ',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...maintenanceData.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (data['full_maintenance'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 40),
                                  child: Text(
                                    'Full Maintenance:',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['oil_change'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'oil_change',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['oil_filter'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'oil_filter',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['fuel_filter_replace'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'Fuel Filter Replacement:',
                                    style: textStyle,
                                  ),
                                ),

                              if (data['air_filter'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'air_filter',
                                    style: textStyle,
                                  ),
                                ),

                              if (data['spark_plug'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'spark_plug',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_cooling_system'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_cooling_system',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['check_cooling_fan_operation'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'check_cooling_fan_operation',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['replace_engine_coolant'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'replace_engine_coolant',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['check_engine_emission_system'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'check_engine_emission_system',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_drive_belt_tension'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_drive_belt_tension',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_fuel_system'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_fuel_system',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['exhaust_system'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'exhaust_system',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['driveshaft_dust_boots'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'driveshaft_dust_boots',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['change_at_fluid'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'change_at_fluid',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_adjust_parking_brake'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_adjust_parking_brake',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['brake_clutch_fluid'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'brake_clutch_fluid',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['disc_brakes_pads'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'disc_brakes_pads',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['check_brake_fluid_hoses_lines'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'check_brake_fluid_hoses_lines',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_ac_system_operation'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_ac_system_operation',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_clean_ac_filter'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_clean_ac_filter',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_battery'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_battery',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['check_windshield_wipers'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'check_windshield_wipers',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_electrical_systems'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_electrical_systems',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_tire_pressure_tread_wear'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_tire_pressure_tread_wear',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_steering_system'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_steering_system',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['tire_rotation'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'tire_rotation',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['inspect_body_condition'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_body_condition',
                                    style: textStyle,
                                  ),
                                ),
                              if (data[
                                      'inspect_front_suspension_ball_joints'] ==
                                  1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'inspect_front_suspension_ball_joints',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['cooling_water'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'cooling_water',
                                    style: textStyle,
                                  ),
                                ),
                              if (data['walking_pulley'] == 1)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 50),
                                  child: Text(
                                    'walking_pulley',
                                    style: textStyle,
                                  ),
                                ),

                              // Add more conditions for other maintenance items
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

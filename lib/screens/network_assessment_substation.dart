// import 'dart:io';

// import 'package:aedc_disco/common/alert.dart';
// import 'package:aedc_disco/common/constants/sizes_constants.dart';
// import 'package:aedc_disco/common/take_photo.dart';
// import 'package:aedc_disco/common/themes/app_colors.dart';
// import 'package:aedc_disco/config/api_constant.dart';
// import 'package:aedc_disco/network/api_client.dart';
// import 'package:aedc_disco/screens/home_screen.dart';
// import 'package:aedc_disco/widgets/common/button_main.dart';
// import 'package:aedc_disco/widgets/common/capture_image_widget.dart';
// import 'package:aedc_disco/widgets/common/drop_down.dart';
// import 'package:aedc_disco/widgets/common/form/form_image_section.dart';
// import 'package:aedc_disco/widgets/common/general_text_box.dart';
// import 'package:aedc_disco/widgets/common/image_selector_modal.dart';
// import 'package:aedc_disco/widgets/common/success_modal.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:geolocator/geolocator.dart';

// class NetworkAssessmentSubStation extends StatefulWidget {
//   const NetworkAssessmentSubStation({Key? key}) : super(key: key);

//   @override
//   State<NetworkAssessmentSubStation> createState() => _NetworkAssessmentSubStationState();
// }

// class _NetworkAssessmentSubStationState extends State<NetworkAssessmentSubStation> {
//   List _hvLines = [
//     "Select HV Lines",
//     "Over Head",
//     "UnderGround",
//   ];

//   List _conducTorTypes = [
//     "OK",
//     "Bad",
//   ];

//   List _transformerOilLevel = ["LOW", "MEDIUM", "HIGH"];

//   List _energyMs = [
//     "Yes",
//     "No",
//   ];

//   List lighteningAresterOptions = [
//     "AVAILABLE"
//         "OK",
//     "Bad",
//   ];

//   List _circuitBreakers = [
//     "OK",
//     "Bad",
//   ];

//   List _availableOptions = [
//     "AVAILABLE",
//     "NOT AVAILABLE",
//   ];

//   List _availableOptionsOther = [
//     "OKAY",
//     "NOT OKAY",
//     "NOT AVAILABLE",
//   ];

//   List _yesNoOptions = [
//     "YES",
//     "NO",
//   ];

  
//   List _cbStatuses = [
//     "Outdoor",
//     "Indoor",
//   ];

//    List _sfGasIndicators = [
//     "OK",
//     "LOW",
//     "LEAKAGE"
//   ];

//   List _oilLevelSpace = [
//     "OK",
//     "LOW",
    
//   ];

  

//   String _hvLine = "";
//   String _dtFenced = "";
//   String _conductType = "";
//   String _energym = "";
//   String _substationPlinthStatus = "";
//   String _autoRecloserStatus = "";
//   String _stayStatus = "";
//   String _stayInsulatorStatus = "";
//   String semaphone = "";
//   String _springChargingMechanism = "";
//   String _poleDiscordance = "";
//   String _silicaGelVailble = "";
//   String _hrcFuse = "";
//   String _isolator = "";
//   String _rmu = "";
//   String _substationGravelling = "";
//   String _substationBusHy = "";

//   String _substationCableLugs = "";
//   String _feederPillarStatus = "";

//   String _feederPillarUnitStatus = "";
//   String _transOilLevel = "";
//   String _oilLeakage = "";
//   String _trippinCond = "";
//   String _cbstatus = "";
//   String _sfGasIndication="";
//   String _oil_level_space="";

//   TextEditingController _areaController = TextEditingController();
//   TextEditingController _feederNameController = TextEditingController();
//   TextEditingController _num_brokenHtPolesController = TextEditingController();
//   TextEditingController _powerFController = TextEditingController();
//   TextEditingController totalInjectionController = TextEditingController();
//   TextEditingController _upriserCableSizeController = TextEditingController();
//   TextEditingController _substationEarthResisController =
//       TextEditingController();
//   TextEditingController _diskCrackController = TextEditingController();
//   TextEditingController _numbBadMissTieSController = TextEditingController();
//   TextEditingController _noBadInsulatorController = TextEditingController();
//   TextEditingController _numBrokenHtController = TextEditingController();
//   TextEditingController _numbLeaningHtPolesController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _numLightingArresterController =
//       TextEditingController();
//   TextEditingController _vegatationLineController = TextEditingController();
//   TextEditingController _saggedHtLineController = TextEditingController();
//   TextEditingController _substationStayBusController = TextEditingController();
//   TextEditingController remarksControler = TextEditingController();
//   TextEditingController regionController = TextEditingController();
//   TextEditingController hrcFusingController = TextEditingController();
//   TextEditingController _brokenWeakCrossController = TextEditingController();
//   TextEditingController elvenFeederAverageLoadController = TextEditingController();
//   TextEditingController _othersNotHighlightedController =
//       TextEditingController();
//   TextEditingController _thermoCameraTempController = TextEditingController();
//   TextEditingController _thermoCameraColorController = TextEditingController();

//   TextEditingController _poleUnderConstThreatController =
//       TextEditingController();

//   TextEditingController serviceCenterController = TextEditingController();

//   TextEditingController _substationNameController = TextEditingController();

//   TextEditingController capacityControllerMva = TextEditingController();
//   TextEditingController _sourceFeederPeakController = TextEditingController();
//   TextEditingController _noIncomerController =
//       TextEditingController();
// String _feederPillarPlitchStatus="";

//   File? selectedImage;

//   bool isApiCallProcess = false;

//   bool _cbStatus=false;

//   // late Position _currentPosition;

//   final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey();

//   final formKey = GlobalKey<FormState>();

//   // _getCurrentLocation() async {
//   //   bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

//   //   LocationPermission permission;
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.deniedForever) {
//   //       return Future.error('Location Not Available');
//   //     }
//   //   } else {
//   //     print("eororororo");
//   //     // throw Exception('Error');
//   //   }
//   //   Geolocator.getCurrentPosition(
//   //           desiredAccuracy: LocationAccuracy.best,
//   //           forceAndroidLocationManager: true)
//   //       .then((Position position) {
//   //     print("positiojseeetion");
//   //     print(position);
//   //     setState(() {
//   //       _currentPosition = position;
//   //     });
//   //   }).catchError((e) {
//   //     print("ewerorLoc");
//   //     print(e);
//   //   });
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _hvLine = _hvLines[0];
//     _dtFenced = _yesNoOptions[0];

//     _conductType = _conducTorTypes[0];
//     _feederPillarPlitchStatus= _conducTorTypes[0];
//     _feederPillarStatus = _conducTorTypes[0];
//     _feederPillarUnitStatus = _conducTorTypes[0];
//     _energym = _energyMs[0];
//     _substationPlinthStatus = _circuitBreakers[0];
//     _substationStayBusController.text = _circuitBreakers[0];
//     _autoRecloserStatus = _circuitBreakers[0];
//     _stayStatus = _circuitBreakers[0];
//     _stayInsulatorStatus = _circuitBreakers[0];
//     _springChargingMechanism = _circuitBreakers[0];
//     semaphone = _circuitBreakers[0];
//     _poleDiscordance = _circuitBreakers[0];
//     _hrcFuse = _availableOptions[0];
//     _isolator = _availableOptions[0];
//     _rmu = _circuitBreakers[0];
//     _substationCableLugs = _circuitBreakers[0];

//     _substationGravelling = _availableOptionsOther[0];
//     _substationBusHy = _energyMs[0];
//     _silicaGelVailble = _energyMs[0];
//     _oilLeakage = _energyMs[0];
//     _transOilLevel = _transformerOilLevel[0];

//     _cbstatus=_cbStatuses[0];
//     _trippinCond=_circuitBreakers[0];
//     _sfGasIndication=_sfGasIndicators[0];
//     _oil_level_space=_oilLevelSpace[0];
//   }

//   Widget _buildHVLinTyTextField() {
//     return DropDownList(
//       items: _hvLines,
//       value: _hvLine,
//       title: "Choose Hv Line Type",
//       onChange: (val) {
//         print(val);
//         setState(() {
//           _hvLine = val.toString();
//         });
//       },
//     );
//   }

//   Widget _buildRemarks() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: TextFormField(
//         controller: remarksControler,
//         minLines: 6, //Normal textInputField will be displayed
//         maxLines: 8,
//         keyboardType: TextInputType.multiline,
//         decoration: InputDecoration(
//           fillColor: Colors.grey[200],
//           filled: true,
//           hintText: "Remarks",
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: AppColor.mainColor)),
//           contentPadding: EdgeInsets.only(top: 16.0),
//         ),
//         // onSaved: (value) => email = value
//       ),
//     );
//   }

//   _handleSubmit() async {
//     AlertToast toaster = new AlertToast(scaffold: scaffoldkey);
//     if (formKey.currentState != null && formKey.currentState!.validate()) {
//       setState(() {
//         isApiCallProcess = true;
//       });
//       try {
//         APIClient apiClient = new APIClient();

//         var data = {
//           "TRANSFORMER_ASSESSMENT_CODE": " AssessmentCode",
//           "REGION_CODE": regionController.text,
//           "REGION_NAME": regionController.text,
//           "AREA_CODE": _areaController.text,
//           "AREA_NAME": _areaController.text,
//           "FEEDER_NAME": _feederNameController.text,
//           "FEEDER_CODE": _feederNameController.text,
//           "SERVICE_CENTER_CODE": serviceCenterController.text,
//           "SERVICE_CENTER_NAME": serviceCenterController.text,
//           "TRANSFORMER_CAPACITY": _substationNameController.text,
//           "INTERMEDIATE_CABLE": capacityControllerMva.text,
//           "UPRISER_CABLE_NUMBER": totalInjectionController.text,
//           "UPRISER_CABLE": _upriserCableSizeController.text,
//           "FEEDER_PILAR_DB_STATUS": _feederPillarStatus,
//           "FEEDER_PILLAR_UNIT_STATUS": _feederPillarUnitStatus,
//           "FEEDER_PILLAR_UNIT": _sourceFeederPeakController.text,
//           "FEEDER_PILLAR_UNIT_SPARE": _noIncomerController.text,
//           "FEEDER_PILLAR_PLINTH_STATUS": _feederPillarPlitchStatus,
//           "LT_CIRCUIT_AVERAGE_LENGHT": elvenFeederAverageLoadController.text,
//           "TRANSFORMER_OIL_LEVEL": _transOilLevel,
//           "OIL_LEAKAGE": _oilLeakage,
//           "SILICA_GEL_AVAILABLE": _silicaGelVailble,
//           "HV_CABLE_STATUS": _springChargingMechanism,
//           "LIGHTENING_ARRESTER": semaphone,
//           "D_FUSE_ASSEMBLY": _poleDiscordance,
//           "HRC_FUSE_RATING": hrcFusingController.text,
//           "HRC_FUSE": _hrcFuse,
//           "ISOLATOR_AVAILABILITY": _isolator,
//           "ISOLATOR_STATUS": _isolator,
//           "RMU_STATUS": _rmu,
//           "SUBSTATION_GRAVELLING": _substationGravelling,
//           "SUBSTATION_BUSHY": _substationBusHy,
//           "SUBSTATION_PLINTH_STATUS": _substationPlinthStatus,
//           "SUBSTATION_STAY_STATUS": _substationStayBusController.text,
//           "SUBSTATION_CABLE_LUGS": _substationCableLugs,
//           "ENERGY_METER": _energym,
//           "SAGGED_LT_LINES": _saggedHtLineController.text,
//           "SUBSTATION_EARTH": _substationEarthResisController.text,
//           "RESISTANCE_VALUE": _substationEarthResisController.text,
//           "THERMO_CAMERA_COLOR": _thermoCameraTempController.text,
//           "THERMO_CAMERA_TEMPERATURE": _thermoCameraColorController.text,
//           "DATE_CAPTURED": " DateTime.Now",
//           "CAPTURED_BY": " CAPTURED_BY",
//           "REMARKS": remarksControler.text,
//         };

//         print("reee#${data}");

//         var response = await apiClient.submitPostRequest(
//             url: "${APIConstants.BASE_URL}/NetworkAssessmentSubStationR", data: data);
//         setState(() {
//           isApiCallProcess = false;
//         });
//         if (response["status"] == "success") {
//           // toaster.showSuccess("Record Saved Success");
//           return successModal();
//         } else {
//           toaster.showError("Oops!!! An error Occured!");
//         }
//       } catch (e) {
//         print(e);
//         toaster.showError("Oops!!! An error Occured!");
//         setState(() {
//           isApiCallProcess = false;
//         });
//       }
//     }
//   }

//   showSuccessDialog(contexts) {
//     return SuccessModal(
//         title: "Network Assessment",
//         description:
//             "You have successfully Saved network assessment for DTR",
//         onTap: () {
//           formKey.currentState!.reset();
//         });
//   }

//   successModal() {
//     showModalBottomSheet(
//         context: context,
//         elevation: 2.0,
//         isDismissible: false,
//         isScrollControlled: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(Sizes.dimen_10),
//               topLeft: Radius.circular(Sizes.dimen_10)),
//         ),
//         builder: (contexts) => showSuccessDialog(contexts));
//   }

//   showDocumentPicker(context) {
//     return ImageSelectorModal(
//       OnHandleGallery: () async {
//         var imageSource = await TakePhoto.takeGallery();
//         if (imageSource == null) {
//         } else {
//           setState(() {
//             selectedImage = imageSource;
//           });
//         }
//       },
//       OnHandleImage: () async {
//         var imageSource = await TakePhoto.takeCamera();
//         if (imageSource == null) {
//         } else {
//           setState(() {
//             selectedImage = imageSource;
//           });
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double deviceHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       key: scaffoldkey,
//       appBar: AppBar(
//         title: Text(
//           "Network Assessment SubStation",
//           style: TextStyle(letterSpacing: 1.2),
//         ),
//         backgroundColor: AppColor.mainColor,
//       ),
//       body: Container(
//         height: deviceHeight,
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             image: DecorationImage(
//                 image: AssetImage("assets/background-img.jpg"),
//                 fit: BoxFit.cover)),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Network Assessment SubStation",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 19),
//                       )),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   GeneralTextBox(
//                     validator: (val) {
//                       if (val == "") return "Area is required";
//                     },
//                     controller: _areaController,
//                     labelTitle: "Enter Area",
//                     placeHolderText: "Enter Area",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     // validator: (val) {
//                     //   if (val == "") return "Area is required";
//                     // },
//                     controller: regionController,
//                     labelTitle: "Enter Region",
//                     placeHolderText: "Enter Region",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     // validator: (val) {
//                     //   if (val == "") return "Area is required";
//                     // },
//                     controller: serviceCenterController,
//                     labelTitle: "Enter Service Center",
//                     placeHolderText: "Enter Service Center",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _feederNameController,
//                     labelTitle: "Enter Feeder Name",
//                     placeHolderText: "Enter Feeder Name",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _substationNameController,
//                     labelTitle: "Enter Injection Substation Name",
//                     placeHolderText: "Enter Injection Substation Name",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: capacityControllerMva,
//                     labelTitle: "Enter Capacity MVA",
//                     placeHolderText: "Enter Capacity MVA",
//                     onChange: (e) {},
//                   ),
                 
                 
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: totalInjectionController,
//                     labelTitle: "Enter Total Injection Sub. Capacity%",
//                     placeHolderText: "Enter Total Injection Sub. Capacity%",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _powerFController,
//                     labelTitle: "Enter Feeder Power Factor",
//                     placeHolderText: "Enter Feeder Power Factor",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _cbStatuses,
//                       title: "33kv CB Status",
//                       value: _cbstatus,
//                       onChange: (value) {
//                         setState(() {
//                           _cbstatus = value;
//                         });
//                       }),
                  
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _oilLevelSpace,
//                       title: "Oil Level - Provide Space for them to indicate the transformer in questions",
//                       value: _oil_level_space,
//                       onChange: (value) {
//                         setState(() {
//                           _oil_level_space = value;
//                         });
//                       }),
                  
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _sourceFeederPeakController,
//                     labelTitle: "Enter Temeperature (Degree Celcius)",
//                     placeHolderText: "Enter Temeperature (Degree Celcius)",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _noIncomerController,
//                     labelTitle: "Enter No. of Incomer 11kv",
//                     placeHolderText: "Enter No. of Incomer 11kv",
//                     onChange: (e) {},
//                   ),
                  
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _injectionSubstationPeakController,
//                     labelTitle: "Enter Injection Substation 11kv Incomer (MW)",
//                     placeHolderText: "Enter Injection Substation 11kv Incomer (MW)",
//                     onChange: (e) {},
//                   ),
                 
                 
//                   SizedBox(
//                     height: 15,
//                   ),

//                    GeneralTextBox(
//                     controller: _injectionSubstationPeakController,
//                     labelTitle: "Enter Number of Outgoing 11kv Feeders",
//                     placeHolderText: "Enter Number of Outgoing 11kv Feeders",
//                     onChange: (e) {},
//                   ),

//                   SizedBox(
//                     height: 15,
//                   ),

//                    GeneralTextBox(
//                     controller: elvenFeederAverageLoadController,
//                     labelTitle: "Enter 11kv Feeders Average Load(MW)",
//                     placeHolderText: "Enter 11kv Feeders Average Load(MW)",
//                     onChange: (e) {},
//                   ),

//                   SizedBox(
//                     height: 15,
//                   ),

//                    GeneralTextBox(
//                     controller: numberSpareController,
//                     labelTitle: "Enter Number of Spare 11kv Circuit Breakers",
//                     placeHolderText: "Enter Number of Spare 11kv Circuit Breakers",
//                     onChange: (e) {},
//                   ),

//                    SizedBox(
//                     height: 15,
//                   ),

//                   GeneralTextBox(
//                     controller: statusElevenFeederController,
//                     labelTitle: "Enter Status of 11kv Feeders",
//                     placeHolderText: "Enter Status of 11kv Feeders",
//                     onChange: (e) {},
//                   ),

//                    SizedBox(
//                     height: 15,
//                   ),

//                   GeneralTextBox(
//                     controller: numberBadElevenCbController,
//                     labelTitle: "Enter No. Bad 11kv CBs",
//                     placeHolderText: "Enter No. Bad 11kv CBs",
//                     onChange: (e) {},
//                   ),

//                   SizedBox(
//                     height: 15,
//                   ),

//                   GeneralTextBox(
//                     controller: numberGantryStatusController,
//                     labelTitle: "Enter Gantry Status",
//                     placeHolderText: "Enter Gantry Status",
//                     onChange: (e) {},
//                   ),

//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "Tripping Condition?",
//                       value: _trippinCond,
//                       onChange: (value) {
//                         setState(() {
//                           _trippinCond = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "Relay Status",
//                       value: _autoRecloserStatus,
//                       onChange: (value) {
//                         setState(() {
//                           _autoRecloserStatus = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "Spring Charging Mechanism",
//                       value: _springChargingMechanism,
//                       onChange: (value) {
//                         setState(() {
//                           _springChargingMechanism = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "SemaPhone",
//                       value: semaphone,
//                       onChange: (value) {
//                         setState(() {
//                           semaphone = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "Pole Discordance",
//                       value: _poleDiscordance,
//                       onChange: (value) {
//                         setState(() {
//                           _poleDiscordance = value;
//                         });
//                       }),

//                       SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "SF6 Gas Indication",
//                       value: _sfGasIndication,
//                       onChange: (value) {
//                         setState(() {
//                           _sfGasIndication = value;
//                         });
//                       }),

//                       SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "CB Status",
//                       value: _cbStatus,
//                       onChange: (value) {
//                         setState(() {
//                           _cbStatus = value;
//                         });
//                       }),

//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: hrcFusingController,
//                     labelTitle: "Enter HRC Fuse Rating",
//                     placeHolderText: "Enter HRC Fuse Rating",
//                     onChange: (e) {},
//                   ),
//                   // SizedBox(
//                   //   height: 15,
//                   // ),
//                   // DropDownList(
//                   //     items: _circuitBreakers,
//                   //     title: "HRC Fuse?",
//                   //     value: _hrcFuse,
//                   //     onChange: (value) {
//                   //       setState(() {
//                   //         _hrcFuse = value;
//                   //       });
//                   //     }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _availableOptions,
//                       title: "Isolator?",
//                       value: _isolator,
//                       onChange: (value) {
//                         setState(() {
//                           _isolator = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "RMU Status?",
//                       value: _rmu,
//                       onChange: (value) {
//                         setState(() {
//                           _rmu = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   // DropDownList(
//                   //     items: _circuitBreakers,
//                   //     title: "Substationbus  HY",
//                   //     value: _substationBusHy,
//                   //     onChange: (value) {
//                   //       setState(() {
//                   //         _substationBusHy = value;
//                   //       });
//                   //     }),
//                   // SizedBox(
//                   //   height: 15,
//                   // ),
//                   GeneralTextBox(
//                     controller: _substationEarthResisController,
//                     labelTitle: "Enter Substation Earth Resistance(OHMS)",
//                     placeHolderText: "Enter Substation Earth Resistance(OHMS)",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
                  
//                   DropDownList(
//                       items: _energyMs,
//                       title: "Energy Meter?",
//                       value: _energym,
//                       onChange: (value) {
//                         setState(() {
//                           _energym = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "SubStation Plinth Status",
//                       value: _substationPlinthStatus,
//                       onChange: (value) {
//                         setState(() {
//                           _substationPlinthStatus = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "Substation Stay bus",
//                       value: _substationStayBusController.text,
//                       onChange: (value) {
//                         setState(() {
//                           _substationStayBusController.text = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownList(
//                       items: _circuitBreakers,
//                       title: "Substation Cable Lugs",
//                       value: _substationCableLugs,
//                       onChange: (value) {
//                         setState(() {
//                           _substationCableLugs = value;
//                         });
//                       }),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _thermoCameraTempController,
//                     labelTitle: "Enter Thermographic Camera Temperature",
//                     placeHolderText: "Enter Thermographic Camera Temperature",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _thermoCameraColorController,
//                     labelTitle: "Enter Thermographic Color of Object",
//                     placeHolderText: "Enter Thermographic Color of Object",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GeneralTextBox(
//                     controller: _othersNotHighlightedController,
//                     labelTitle: "Others Not Highlighted",
//                     placeHolderText: "Others Not Highlighted",
//                     onChange: (e) {},
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   _buildRemarks(),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                       height: 50.0,
//                       width: double.infinity,
//                       child: ButtonMain(
//                         isLoading: isApiCallProcess,
//                         btn_txt: "Submit",
//                         ontap: () => _handleSubmit(),
//                       ))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

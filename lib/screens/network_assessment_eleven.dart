import 'dart:io';

import 'package:aedc_disco/common/alert.dart';
import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/take_photo.dart';
import 'package:aedc_disco/config/api_constant.dart';
import 'package:aedc_disco/network/api_client.dart';
import 'package:aedc_disco/screens/home_screen.dart';
import 'package:aedc_disco/widgets/common/button_main.dart';
import 'package:aedc_disco/widgets/common/capture_image_widget.dart';
import 'package:aedc_disco/widgets/common/drop_down.dart';
import 'package:aedc_disco/widgets/common/form/form_image_section.dart';
import 'package:aedc_disco/widgets/common/general_text_box.dart';
import 'package:aedc_disco/widgets/common/image_selector_modal.dart';
import 'package:aedc_disco/widgets/common/success_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';

class NetworkAssessmentEleven extends StatefulWidget {
  const NetworkAssessmentEleven({Key? key}) : super(key: key);

  @override
  State<NetworkAssessmentEleven> createState() => _NetworkAssessmentElevenState();
}

class _NetworkAssessmentElevenState extends State<NetworkAssessmentEleven> {
  Color _maincolor = Color(0xff000375);
  bool _obscureText = false;
  List _hvLines = [
    "Select HV Lines",
    "Over Head",
    "UnderGround",
  ];

  List _conducTorTypes = [
    "AAC",
    "ACSR",
  ];

  List _energyMs = [
    "Yes",
    "No",
  ];

  List _circuitBreakers = [
    "OK",
    "Bad",
  ];

  String _hvLine = "";
  String _conductType = "";
  String _energym = "";
  String _circuitBreaker = "";
  String _autoRecloserStatus = "";
  String _stayStatus = "";
  String _stayInsulatorStatus = "";
  TextEditingController _areaController = new TextEditingController();
  TextEditingController _feederNameController = new TextEditingController();
  TextEditingController _num_brokenHtPolesController =
      new TextEditingController();
  TextEditingController _powerFController = new TextEditingController();
  TextEditingController _feederPeakLoadContoller = new TextEditingController();
  TextEditingController _weakUControlller = new TextEditingController();
  TextEditingController _crackpotInsullatorController =
      new TextEditingController();
  TextEditingController _diskCrackController = new TextEditingController();
  TextEditingController _numbBadMissTieSController =
      new TextEditingController();
  TextEditingController _noBadInsulatorController = new TextEditingController();
  TextEditingController _numBrokenHtController = new TextEditingController();
  TextEditingController _numbLeaningHtPolesController =
      new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _numLightingArresterController =
      new TextEditingController();
  TextEditingController _vegatationLineController = new TextEditingController();
  TextEditingController _saggedHtLineController = new TextEditingController();
  TextEditingController _relayStatusController = new TextEditingController();
  TextEditingController remarksControler = new TextEditingController();
  TextEditingController regionController = new TextEditingController();
  TextEditingController weakJumperController = new TextEditingController();
  TextEditingController _brokenWeakCrossController =
      new TextEditingController();
  TextEditingController _undergroudCableTypeController =
      new TextEditingController();
  TextEditingController _othersNotHighlightedController =
      new TextEditingController();
  TextEditingController _thermoCameraTempController =
      new TextEditingController();
  TextEditingController _thermoCameraColorController =
      new TextEditingController();

       TextEditingController _poleUnderConstThreatController =
      new TextEditingController();

  File? selectedImage;

  bool isApiCallProcess = false;

  // late Position _currentPosition;

  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey();

  final formKey = GlobalKey<FormState>();

  // _getCurrentLocation() async {
  //   bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

  //   LocationPermission permission;
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.deniedForever) {
  //       return Future.error('Location Not Available');
  //     }
  //   } else {
  //     print("eororororo");
  //     // throw Exception('Error');
  //   }
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     print("positiojseeetion");
  //     print(position);
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print("ewerorLoc");
  //     print(e);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _hvLine = _hvLines[0];
    _conductType = _conducTorTypes[0];
    _energym = _energyMs[0];
    _circuitBreaker = _circuitBreakers[0];
    _relayStatusController.text = _circuitBreakers[0];
    _autoRecloserStatus = _circuitBreakers[0];
    _stayStatus = _circuitBreakers[0];
    _stayInsulatorStatus = _circuitBreakers[0];
    // _getCurrentLocation();
  }

  Widget _buildHVLinTyTextField() {
    return DropDownList(
      items: _hvLines,
      value: _hvLine,
      title: "Choose Hv Line Type",
      onChange: (val) {
        print(val);
        setState(() {
          _hvLine = val.toString();
        });
      },
    );
  }

  Widget _buildRemarks() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: remarksControler,
        minLines: 6, //Normal textInputField will be displayed
        maxLines: 8,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          hintText: "Remarks",
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: _maincolor)),
          contentPadding: EdgeInsets.only(top: 16.0),
        ),
        // onSaved: (value) => email = value
      ),
    );
  }

  _handleSubmit() async {
    AlertToast toaster = new AlertToast(scaffold: scaffoldkey);
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      if (selectedImage == null) {
        toaster.showError("Please Upload Feeder Image");

        return;
      }
      setState(() {
        isApiCallProcess = true;
      });
      try {
        APIClient apiClient = new APIClient();

        //         FormData data =FormData.fromMap({
        //   "AREA_CODE": _areaController.text,
        //   "NETWORK_ASSESSMENT_11KV_CODE": "AssessmentCode",
        //   "CRACKED_SHATTERED_POT_INSULATOR": _crackpotInsullatorController,
        //   "UNDER_GROUND_CABLE_TYPE": _undergroudCableTypeController.text,
        //   "CONDUCTOR_TYPE": _conductType,
        //   "WEAK_UNDERSIZED_CONDUCTOR": _weakUControlller.text,
        //   "FEEDER_PEAK_LOAD": _feederPeakLoadContoller.text,
        //   "HIGH_VOLTAGE_LINE_TYPE": _hvLine,
        //   "FEEDER_POWER_FACTOR": _powerFController.text,
        //   "FEEDER_ROUTE_LENGTH": "FEEDER_ROUTE_LENGTH",
        //   "FEEDER_CODE": "FEEDER_CODE",
        //   "FEEDER_NAME": _feederNameController.text,
        //   "AREA_NAME": _areaController.text,
        //   "REGION_NAME": regionController.text,
        //   "REGION_CODE": "REGION_CODE",
        //   "HT_LINES": "HT_LINES",
        //   "LINE_SAGGED": _saggedHtLineController.text,
        //   "VEGETATION_FOULING": _vegatationLineController.text,
        //   "BAD_LIGHTNING_ARRESTER": _numLightingArresterController.text,
        //   "LEANING_HT_POLES": _numbLeaningHtPolesController.text,
        //   "BROKEN_HT_POLES": _numBrokenHtController.text,
        //   "BAD_ISOLATORS": _noBadInsulatorController.text,
        //   "POLE_UNDER_EROSION_THREAT": "POLE_UNDER_EROSION_THREAT",
        //   "STAY_INSULATOR_STATUS":_stayInsulatorStatus,
        //   "STAY_STATUS": _stayStatus,
        //   "WEAK_JUMPER_HOTSPOT": weakJumperController.text,
        //   "BAD_MISSING_TIE_STRAPS": _numbBadMissTieSController.text,
        //   "CRACKED_SHATTERED_DISC_INSULATOR":
        //       "CRACKED_SHATTERED_DISC_INSULATOR",
        //   "LONGITUDE": "00",
        //   "LATITUDE": "00",
        //   "IMAGE_LOCATION":await MultipartFile.fromFile(selectedImage!.path),
        //   "CAPTURED_BY": "CAPTURED_BY",
        //   "DATE_CAPTURED": "DATE_CAPTURED",
        //   "REMARKS": "REMARKS",
        //   "OTHERS_STATUS": "OTHERS_STATUS",
        //   "OTHERS_NOT_HIGHLIGHTED": "Exim",
        //   "AUTORECLOSER_STATUS": _autoRecloserStatus,
        //   "THERMO_CAMERA_TEMPERATURE": "Exim",
        //   "THERMO_CAMERA_COLOR": "Exim",
        //   "RELAY_TYPE": "Exim",
        //   "RELAY_STATUS": _relayStatusController.text,
        //   "CIRCUIT_BREAKER_STATUS": _circuitBreaker,
        //   "ENERGY_METER": _energym
        // });

        var data = {
          "AREA_CODE": _areaController.text,
          "NETWORK_ASSESSMENT_11KV_CODE": "AssessmentCode",
          "CRACKED_SHATTERED_POT_INSULATOR": _crackpotInsullatorController.text,
          "UNDER_GROUND_CABLE_TYPE": _undergroudCableTypeController.text,
          "CONDUCTOR_TYPE": _conductType,
          "WEAK_UNDERSIZED_CONDUCTOR": _weakUControlller.text,
          "FEEDER_PEAK_LOAD": _feederPeakLoadContoller.text,
          "HIGH_VOLTAGE_LINE_TYPE": _hvLine,
          "FEEDER_POWER_FACTOR": _powerFController.text,
          "FEEDER_ROUTE_LENGTH": "FEEDER_ROUTE_LENGTH",
          "FEEDER_CODE": "FEEDER_CODE",
          "FEEDER_NAME": _feederNameController.text,
          "AREA_NAME": _areaController.text,
          "REGION_NAME": regionController.text,
          "REGION_CODE": "REGION_CODE",
          "HT_LINES": "HT_LINES",
          "LINE_SAGGED": _saggedHtLineController.text,
          "VEGETATION_FOULING": _vegatationLineController.text,
          "BAD_LIGHTNING_ARRESTER": _numLightingArresterController.text,
          "LEANING_HT_POLES": _numbLeaningHtPolesController.text,
          "BROKEN_HT_POLES": _numBrokenHtController.text,
          "BAD_ISOLATORS": _noBadInsulatorController.text,
          "POLE_UNDER_EROSION_THREAT": _poleUnderConstThreatController.text,
          "STAY_INSULATOR_STATUS": _stayInsulatorStatus,
          "STAY_STATUS": _stayStatus,
          "WEAK_JUMPER_HOTSPOT": weakJumperController.text,
          "BAD_MISSING_TIE_STRAPS": _numbBadMissTieSController.text,
          "CRACKED_SHATTERED_DISC_INSULATOR":
              _diskCrackController.text,
          "LONGITUDE": "00",
          "LATITUDE": "00",
          "IMAGE_LOCATION": "",
          "CAPTURED_BY": "CAPTURED_BY",
          "DATE_CAPTURED": "DATE_CAPTURED",
          "REMARKS": remarksControler.text,
          "OTHERS_STATUS": "OTHERS_STATUS",
          "OTHERS_NOT_HIGHLIGHTED": _othersNotHighlightedController.text,
          "AUTORECLOSER_STATUS": _autoRecloserStatus,
          "THERMO_CAMERA_TEMPERATURE": _thermoCameraTempController.text,
          "THERMO_CAMERA_COLOR": _thermoCameraColorController.text,
          "RELAY_TYPE": "Exim",
          "RELAY_STATUS": _relayStatusController.text,
          "CIRCUIT_BREAKER_STATUS": _circuitBreaker,
          "ENERGY_METER": _energym
        };

        print("reee#${data}");

        var response = await apiClient.submitPostRequest(
            url: "${APIConstants.BASE_URL}/NetworkAssessment11kv", data: data);
        setState(() {
          isApiCallProcess = false;
        });
        if (response["status"] == "success") {
          // toaster.showSuccess("Record Saved Success");
          return successModal();
        } else {
          toaster.showError("Oops!!! An error Occured!");
        }
      } catch (e) {
        print(e);
        toaster.showError("Oops!!! An error Occured!");
        setState(() {
          isApiCallProcess = false;
        });
      }
    }
  }

  showSuccessDialog(contexts) {
    return SuccessModal(
        title: "Network Assessment",
        description:
            "You have successfully Saved network assessment for 11kv feeder",
        onTap: () {
          formKey.currentState!.reset();
        });
  }

  successModal() {
    showModalBottomSheet(
        context: context,
        elevation: 2.0,
        isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Sizes.dimen_10),
              topLeft: Radius.circular(Sizes.dimen_10)),
        ),
        builder: (contexts) => showSuccessDialog(contexts));
  }

  showDocumentPicker(context) {
    return ImageSelectorModal(
      OnHandleGallery: () async {
        var imageSource = await TakePhoto.takeGallery();
        if (imageSource == null) {
        } else {
          setState(() {
            selectedImage = imageSource;
          });
        }
      },
      OnHandleImage: () async {
        var imageSource = await TakePhoto.takeCamera();
        if (imageSource == null) {
        } else {
          setState(() {
            selectedImage = imageSource;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Network Assessment 11kv Feeder",
          style: TextStyle(letterSpacing: 1.2),
        ),
        backgroundColor: _maincolor,
      ),
      body: Container(
        height: deviceHeight,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/background-img.jpg"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Network Assessment 11kv Feeder",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  GeneralTextBox(
                    validator: (val) {
                      if (val == "") return "Area is required";
                    },
                    controller: _areaController,
                    labelTitle: "Enter Area",
                    placeHolderText: "Enter Area",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    // validator: (val) {
                    //   if (val == "") return "Area is required";
                    // },
                    controller: regionController,
                    labelTitle: "Enter Region",
                    placeHolderText: "Enter Region",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _feederNameController,
                    labelTitle: "Enter Feeder 11kv",
                    placeHolderText: "Enter Feeder 11kv",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _numBrokenHtController,
                    labelTitle: "Enter No. of Broken HT Poles",
                    placeHolderText: "No. of Broken HT Poles",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _powerFController,
                    labelTitle: "Enter Feeder Power Factor",
                    placeHolderText: "Enter Feeder Power Factor",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildHVLinTyTextField(),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _feederPeakLoadContoller,
                    labelTitle: "Enter Feeder Peak Load",
                    placeHolderText: "Enter Feeder Peak Load",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _weakUControlller,
                    labelTitle: "Weak Undersized Conductor",
                    placeHolderText: "Weak Undersized Conductor",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _conducTorTypes,
                      title: "Choose Conductor Type",
                      value: _conductType,
                      onChange: (value) {
                        setState(() {
                          _conductType = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _undergroudCableTypeController,
                    labelTitle: "Enter Underground Cable Type",
                    placeHolderText: "Enter Underground Cable Type",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: weakJumperController,
                    labelTitle: "Enter Underground Cable Type",
                    placeHolderText: "Enter Underground Cable Type",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _brokenWeakCrossController,
                    labelTitle:
                        "Enter 11kv Broken/Weak Cross Arms(Indicate Type- Wooden/Fibre/Channel)",
                    placeHolderText: "Enter Underground Cable Type",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _crackpotInsullatorController,
                    labelTitle: "Enter No. Cracked Pot Insulator",
                    placeHolderText: "Enter No. Cracked Pot Insulator",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _poleUnderConstThreatController,
                    labelTitle: "Enter No. Pole Under Erosion Threat",
                    placeHolderText: "Enter No. Pole Under Erosion Threat",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _diskCrackController,
                    labelTitle: "Enter No. Crack Disk Insulator",
                    placeHolderText: "Enter No. Crack Disk Insulator",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _numbBadMissTieSController,
                    labelTitle: "Enter No. Missing TieStraps",
                    placeHolderText: "Enter No. Missing TieStraps",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _noBadInsulatorController,
                    labelTitle: "Enter No. Bad Insulator",
                    placeHolderText: "Enter No. Bad Insulator",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _numBrokenHtController,
                    labelTitle: "Enter No. Of Broken HT Poles",
                    placeHolderText: "Enter No. Of Broken HT Poles",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _numbLeaningHtPolesController,
                    labelTitle: "Enter No. of Leaning HT Poles",
                    placeHolderText: "Enter No. of Leaning HT Poles",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _numLightingArresterController,
                    labelTitle: "Enter No. Bad Lightening Arrester",
                    placeHolderText: "Enter No. Bad Lightening Arrester",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _vegatationLineController,
                    labelTitle: "Enter Vegetation Fouling Line(Spans)",
                    placeHolderText: "Enter Vegetation Fouling Line(Spans)",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _powerFController,
                    labelTitle: "Enter Sagged HT Lines(Spans)",
                    placeHolderText: "Enter Sagged HT Lines(Spans)",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _energyMs,
                      title: "Energy Meter?",
                      value: _energym,
                      onChange: (value) {
                        setState(() {
                          _energym = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Circuit Breaker Status",
                      value: _circuitBreaker,
                      onChange: (value) {
                        setState(() {
                          _circuitBreaker = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Relay Status",
                      value: _relayStatusController.text,
                      onChange: (value) {
                        setState(() {
                          _relayStatusController.text = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _thermoCameraTempController,
                    labelTitle: "Enter Thermographic Camera Temperature",
                    placeHolderText: "Enter Thermographic Camera Temperature",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _thermoCameraColorController,
                    labelTitle: "Enter Thermographic Color of Object",
                    placeHolderText: "Enter Thermographic Color of Object",
                    onChange: (e) {},
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Auto-Recloser Status",
                      value: _autoRecloserStatus,
                      onChange: (value) {
                        setState(() {
                          _autoRecloserStatus = value;
                        });
                      }),
                  CaptureImage(
                    title: "Capture Image",
                    onTap: () {
                      showModalBottomSheet(
                          context: (context),
                          elevation: 2.0,
                          isDismissible: false,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Sizes.dimen_10),
                                topLeft: Radius.circular(Sizes.dimen_10)),
                          ),
                          builder: (context) => showDocumentPicker(context));
                    },
                  ),
                  SizedBox(
                    height: Sizes.dimen_5,
                  ),
                  FormImageSection(file: selectedImage),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _othersNotHighlightedController,
                    labelTitle: "Others Not Highlighted",
                    placeHolderText: "Others Not Highlighted",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _buildRemarks(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 50.0,
                      width: double.infinity,
                      child: ButtonMain(
                        isLoading: isApiCallProcess,
                        btn_txt: "Submit",
                        ontap: () => _handleSubmit(),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

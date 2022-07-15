import 'dart:io';

import 'package:aedc_disco/common/alert.dart';
import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/take_photo.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
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

class NetworkAssessmentDt extends StatefulWidget {
  const NetworkAssessmentDt({Key? key}) : super(key: key);

  @override
  State<NetworkAssessmentDt> createState() => _NetworkAssessmentDtState();
}

class _NetworkAssessmentDtState extends State<NetworkAssessmentDt> {
  List _hvLines = [
    "Select HV Lines",
    "Over Head",
    "UnderGround",
  ];

  List _conducTorTypes = [
    "OK",
    "Bad",
  ];

  List _transformerOilLevel = ["LOW", "MEDIUM", "HIGH"];

  List _energyMs = [
    "Yes",
    "No",
  ];

  List lighteningAresterOptions = [
    "AVAILABLE"
        "OK",
    "Bad",
  ];

  List _circuitBreakers = [
    "OK",
    "Bad",
  ];

  List _availableOptions = [
    "AVAILABLE",
    "NOT AVAILABLE",
  ];

  List _availableOptionsOther = [
    "OKAY",
    "NOT OKAY",
    "NOT AVAILABLE",
  ];

  List _yesNoOptions = [
    "YES",
    "NO",
  ];

  String _hvLine = "";
  String _dtFenced = "";
  String _conductType = "";
  String _energym = "";
  String _substationPlinthStatus = "";
  String _autoRecloserStatus = "";
  String _stayStatus = "";
  String _stayInsulatorStatus = "";
  String _lighteningArester = "";
  String _hvCableStatus = "";
  String _dfuseAss = "";
  String _silicaGelVailble = "";
  String _hrcFuse = "";
  String _isolator = "";
  String _rmu = "";
  String _substationGravelling = "";
  String _substationBusHy = "";

  String _substationCableLugs = "";
  String _feederPillarStatus = "";

  String _feederPillarUnitStatus = "";
  String _transOilLevel = "";
  String _oilLeakage = "";

  TextEditingController _areaController = TextEditingController();
  TextEditingController _feederNameController = TextEditingController();
  TextEditingController _num_brokenHtPolesController = TextEditingController();
  TextEditingController _powerFController = TextEditingController();
  TextEditingController _upriserCableNoController = TextEditingController();
  TextEditingController _upriserCableSizeController = TextEditingController();
  TextEditingController _substationEarthResisController =
      TextEditingController();
  TextEditingController _diskCrackController = TextEditingController();
  TextEditingController _numbBadMissTieSController = TextEditingController();
  TextEditingController _noBadInsulatorController = TextEditingController();
  TextEditingController _numBrokenHtController = TextEditingController();
  TextEditingController _numbLeaningHtPolesController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numLightingArresterController =
      TextEditingController();
  TextEditingController _vegatationLineController = TextEditingController();
  TextEditingController _saggedHtLineController = TextEditingController();
  TextEditingController _substationStayBusController = TextEditingController();
  TextEditingController remarksControler = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController hrcFusingController = TextEditingController();
  TextEditingController _brokenWeakCrossController = TextEditingController();
  TextEditingController _ltCircuitAverageLeController = TextEditingController();
  TextEditingController _othersNotHighlightedController =
      TextEditingController();
  TextEditingController _thermoCameraTempController = TextEditingController();
  TextEditingController _thermoCameraColorController = TextEditingController();

  TextEditingController _poleUnderConstThreatController =
      TextEditingController();

  TextEditingController serviceCenterController = TextEditingController();

  TextEditingController _transforCapacityContoller = TextEditingController();

  TextEditingController _intermediateInController = TextEditingController();
  TextEditingController _nofeederPillerUnitController = TextEditingController();
  TextEditingController _nofeederPillerUnitSpareController =
      TextEditingController();
String _feederPillarPlitchStatus="";

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
    _dtFenced = _yesNoOptions[0];

    _conductType = _conducTorTypes[0];
    _feederPillarPlitchStatus= _conducTorTypes[0];
    _feederPillarStatus = _conducTorTypes[0];
    _feederPillarUnitStatus = _conducTorTypes[0];
    _energym = _energyMs[0];
    _substationPlinthStatus = _circuitBreakers[0];
    _substationStayBusController.text = _circuitBreakers[0];
    _autoRecloserStatus = _circuitBreakers[0];
    _stayStatus = _circuitBreakers[0];
    _stayInsulatorStatus = _circuitBreakers[0];
    _hvCableStatus = _circuitBreakers[0];
    _lighteningArester = lighteningAresterOptions[0];
    _dfuseAss = _circuitBreakers[0];
    _hrcFuse = _availableOptions[0];
    _isolator = _availableOptions[0];
    _rmu = _circuitBreakers[0];
    _substationCableLugs = _circuitBreakers[0];

    _substationGravelling = _availableOptionsOther[0];
    _substationBusHy = _energyMs[0];
    _silicaGelVailble = _energyMs[0];
    _oilLeakage = _energyMs[0];
    _transOilLevel = _transformerOilLevel[0];
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
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.mainColor)),
          contentPadding: EdgeInsets.only(top: 16.0),
        ),
        // onSaved: (value) => email = value
      ),
    );
  }

  _handleSubmit() async {
    AlertToast toaster = new AlertToast(scaffold: scaffoldkey);
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      setState(() {
        isApiCallProcess = true;
      });
      try {
        APIClient apiClient = new APIClient();

        var data = {
          "TRANSFORMER_ASSESSMENT_CODE": " AssessmentCode",
          "REGION_CODE": regionController.text,
          "REGION_NAME": regionController.text,
          "AREA_CODE": _areaController.text,
          "AREA_NAME": _areaController.text,
          "FEEDER_NAME": _feederNameController.text,
          "FEEDER_CODE": _feederNameController.text,
          "SERVICE_CENTER_CODE": serviceCenterController.text,
          "SERVICE_CENTER_NAME": serviceCenterController.text,
          "TRANSFORMER_CAPACITY": _transforCapacityContoller.text,
          "INTERMEDIATE_CABLE": _intermediateInController.text,
          "UPRISER_CABLE_NUMBER": _upriserCableNoController.text,
          "UPRISER_CABLE": _upriserCableSizeController.text,
          "FEEDER_PILAR_DB_STATUS": _feederPillarStatus,
          "FEEDER_PILLAR_UNIT_STATUS": _feederPillarUnitStatus,
          "FEEDER_PILLAR_UNIT": _nofeederPillerUnitController.text,
          "FEEDER_PILLAR_UNIT_SPARE": _nofeederPillerUnitSpareController.text,
          "FEEDER_PILLAR_PLINTH_STATUS": _feederPillarPlitchStatus,
          "LT_CIRCUIT_AVERAGE_LENGHT": _ltCircuitAverageLeController.text,
          "TRANSFORMER_OIL_LEVEL": _transOilLevel,
          "OIL_LEAKAGE": _oilLeakage,
          "SILICA_GEL_AVAILABLE": _silicaGelVailble,
          "HV_CABLE_STATUS": _hvCableStatus,
          "LIGHTENING_ARRESTER": _lighteningArester,
          "D_FUSE_ASSEMBLY": _dfuseAss,
          "HRC_FUSE_RATING": hrcFusingController.text,
          "HRC_FUSE": _hrcFuse,
          "ISOLATOR_AVAILABILITY": _isolator,
          "ISOLATOR_STATUS": _isolator,
          "RMU_STATUS": _rmu,
          "SUBSTATION_GRAVELLING": _substationGravelling,
          "SUBSTATION_BUSHY": _substationBusHy,
          "SUBSTATION_PLINTH_STATUS": _substationPlinthStatus,
          "SUBSTATION_STAY_STATUS": _substationStayBusController.text,
          "SUBSTATION_CABLE_LUGS": _substationCableLugs,
          "ENERGY_METER": _energym,
          "SAGGED_LT_LINES": _saggedHtLineController.text,
          "SUBSTATION_EARTH": _substationEarthResisController.text,
          "RESISTANCE_VALUE": _substationEarthResisController.text,
          "THERMO_CAMERA_COLOR": _thermoCameraTempController.text,
          "THERMO_CAMERA_TEMPERATURE": _thermoCameraColorController.text,
          "DATE_CAPTURED": " DateTime.Now",
          "CAPTURED_BY": " CAPTURED_BY",
          "REMARKS": remarksControler.text,
        };

        print("reee#${data}");

        var response = await apiClient.submitPostRequest(
            url: "${APIConstants.BASE_URL}/NetworkAssessmentDTR", data: data);
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
            "You have successfully Saved network assessment for DTR",
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
          "Network Assessment DTR",
          style: TextStyle(letterSpacing: 1.2),
        ),
        backgroundColor: AppColor.mainColor,
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
                        "Network Assessment DTR",
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
                    // validator: (val) {
                    //   if (val == "") return "Area is required";
                    // },
                    controller: serviceCenterController,
                    labelTitle: "Enter Service Center",
                    placeHolderText: "Enter Service Center",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _feederNameController,
                    labelTitle: "Enter Feeder Name",
                    placeHolderText: "Enter Feeder Name",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _transforCapacityContoller,
                    labelTitle: "Enter Transformer Capacity",
                    placeHolderText: "Enter Transformer Capacity",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _intermediateInController,
                    labelTitle: "Enter Intermediate Incomer Size",
                    placeHolderText: "Enter Intermediate Incomer Size",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                    items: _yesNoOptions,
                    value: _dtFenced,
                    title: "DT FENCED?",
                    onChange: (val) {
                      print(val);
                      setState(() {
                        _dtFenced = val.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildHVLinTyTextField(),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _upriserCableNoController,
                    labelTitle: "Enter No of Upriser Cable",
                    placeHolderText: "Enter No of Upriser Cable",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _upriserCableSizeController,
                    labelTitle: "Enter Upriser Cable Size/Rating",
                    placeHolderText: "Enter Upriser Cable Size/Rating",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _conducTorTypes,
                      title: "Feeder Pillar/DB Status",
                      value: _feederPillarStatus,
                      onChange: (value) {
                        setState(() {
                          _feederPillarStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _conducTorTypes,
                      title: "Feeder Pillar Unit Status",
                      value: _feederPillarUnitStatus,
                      onChange: (value) {
                        setState(() {
                          _feederPillarUnitStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _nofeederPillerUnitController,
                    labelTitle: "Enter No. Feeder Pillar Unit",
                    placeHolderText: "Enter No. Feeder Pillar Unit",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _nofeederPillerUnitSpareController,
                    labelTitle: "Enter No. of Feeder Pillar Unit Spare",
                    placeHolderText: "Enter No. of Feeder Pillar Unit Spare",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _conducTorTypes,
                      title: "Feeder Pillar Plintch Status",
                      value: _feederPillarPlitchStatus,
                      onChange: (value) {
                        setState(() {
                          _feederPillarPlitchStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _ltCircuitAverageLeController,
                    labelTitle: "Enter LT Circuit Average Length",
                    placeHolderText: "Enter LT Circuit Average Length",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _transformerOilLevel,
                      title: "Transformer Oil Level",
                      value: _transOilLevel,
                      onChange: (value) {
                        setState(() {
                          _transOilLevel = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _energyMs,
                      title: "Oil Leakage",
                      value: _oilLeakage,
                      onChange: (value) {
                        setState(() {
                          _oilLeakage = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _energyMs,
                      title: "Silica Gel Available?",
                      value: _silicaGelVailble,
                      onChange: (value) {
                        setState(() {
                          _silicaGelVailble = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "HV Cable (Down-Droper) Status",
                      value: _hvCableStatus,
                      onChange: (value) {
                        setState(() {
                          _hvCableStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: lighteningAresterOptions,
                      title: "Lightening Arrester",
                      value: _lighteningArester,
                      onChange: (value) {
                        setState(() {
                          _lighteningArester = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "D Fuse Assembly",
                      value: _dfuseAss,
                      onChange: (value) {
                        setState(() {
                          _dfuseAss = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: hrcFusingController,
                    labelTitle: "Enter HRC Fuse Rating",
                    placeHolderText: "Enter HRC Fuse Rating",
                    onChange: (e) {},
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // DropDownList(
                  //     items: _circuitBreakers,
                  //     title: "HRC Fuse?",
                  //     value: _hrcFuse,
                  //     onChange: (value) {
                  //       setState(() {
                  //         _hrcFuse = value;
                  //       });
                  //     }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _availableOptions,
                      title: "Isolator?",
                      value: _isolator,
                      onChange: (value) {
                        setState(() {
                          _isolator = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "RMU Status?",
                      value: _rmu,
                      onChange: (value) {
                        setState(() {
                          _rmu = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  // DropDownList(
                  //     items: _circuitBreakers,
                  //     title: "Substationbus  HY",
                  //     value: _substationBusHy,
                  //     onChange: (value) {
                  //       setState(() {
                  //         _substationBusHy = value;
                  //       });
                  //     }),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  GeneralTextBox(
                    controller: _substationEarthResisController,
                    labelTitle: "Enter Substation Earth Resistance(OHMS)",
                    placeHolderText: "Enter Substation Earth Resistance(OHMS)",
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
                      title: "SubStation Plinth Status",
                      value: _substationPlinthStatus,
                      onChange: (value) {
                        setState(() {
                          _substationPlinthStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Substation Stay bus",
                      value: _substationStayBusController.text,
                      onChange: (value) {
                        setState(() {
                          _substationStayBusController.text = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Substation Cable Lugs",
                      value: _substationCableLugs,
                      onChange: (value) {
                        setState(() {
                          _substationCableLugs = value;
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

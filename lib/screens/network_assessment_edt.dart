import 'dart:convert';
import 'dart:io';

import 'package:aedc_disco/common/alert.dart';
import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/take_photo.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:aedc_disco/common/utility.dart';
import 'package:aedc_disco/config/api_constant.dart';
import 'package:aedc_disco/network/api_client.dart';
import 'package:aedc_disco/screens/home_screen.dart';
import 'package:aedc_disco/widgets/common/button_main.dart';
import 'package:aedc_disco/widgets/common/capture_image_widget.dart';
import 'package:aedc_disco/widgets/common/drop_down.dart';
import 'package:aedc_disco/widgets/common/form/drop_down_feeder_thirty_three.dart';
import 'package:aedc_disco/widgets/common/form/drop_down_region.dart';
import 'package:aedc_disco/widgets/common/form/form_image_section.dart';
import 'package:aedc_disco/widgets/common/general_text_box.dart';
import 'package:aedc_disco/widgets/common/image_selector_modal.dart';
import 'package:aedc_disco/widgets/common/success_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geolocator/geolocator.dart';

class NetworkAssessmentDt extends StatefulWidget {
  const NetworkAssessmentDt({Key? key}) : super(key: key);

  @override
  State<NetworkAssessmentDt> createState() => _NetworkAssessmentDtState();
}

class _NetworkAssessmentDtState extends State<NetworkAssessmentDt> {
  List _hvLines = [
    "Select",
    "Over Head",
    "UnderGround",
  ];

  List _conducTorTypes = [
    "Select",
    "GOOD",
    "BAD",
  ];

  List _transformerOilLevel = ["Select", "LOW", "MEDIUM", "HIGH"];

  List _energyMs = [
    "Select",
    "YES",
    "NO",
  ];

  List lighteningAresterOptions = [
    "Select",
    "AVAILABLE",
        "GOOD",
    "BAD",
  ];

  List _circuitBreakers = [
    "Select",
    "GOOD",
    "BAD",
  ];

  List _availableOptions = [
    "Select",
    "AVAILABLE",
    "NOT AVAILABLE",
  ];

  List _availableOptionsOther = [
    "Select",
    "OKAY",
    "NOT OKAY",
    "NOT AVAILABLE",
  ];

  List _yesNoOptions = [
    "Select",
    "YES",
    "NO",
  ];

  String selectedBDate = "";

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
  String _feederPillarPlitchStatus = "";

  List<File?> selectedImage = <File>[];

  bool isApiCallProcess = false;
  bool _isLoadingArea = false;
  bool _isLoadingFeeder = false;

  bool _isLoadingServiceArea = false;

  List _areaList = [];
  List _serviceAreas = [];
  List _feeder_eleven_list = [];

  var _feeder_thirty_three;
  var service_area_selected;
  var _feeder_eleven;

  var _region_selected;

  var _areaSelected;

  APIClient apiClient = new APIClient();

  // late Position _currentPosition;

  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey();

  final formKey = GlobalKey<FormState>();

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
      long = position.longitude.toString();
      lat = position.latitude.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _hvLine = _hvLines[0];
    _dtFenced = _yesNoOptions[0];

    _conductType = _conducTorTypes[0];
    _feederPillarPlitchStatus = _conducTorTypes[0];
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
    _hrcFuse = _circuitBreakers[0];
    _isolator = _availableOptions[0];
    _rmu = _circuitBreakers[0];
    _substationCableLugs = _circuitBreakers[0];

    _substationGravelling = _availableOptionsOther[0];
    _substationBusHy = _circuitBreakers[0];
    _silicaGelVailble = _energyMs[0];
    _oilLeakage = _energyMs[0];
    _transOilLevel = _transformerOilLevel[0];
    checkGps();
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
      if (selectedImage.length == 0) {
        toaster.showError("Please Upload Feeder Image");

        return;
      }
      if (_region_selected == null) {
        toaster.showError("Region Name is reqiured");

        return;
      }
      if (_areaSelected == null) {
        toaster.showError("Area Name is reqiured");

        return;
      }
      if (_feeder_eleven == null) {
        toaster.showError("Feeder Name is reqiured");

        return;
      }

      //  if(selectedBDate==""){
      //   toaster.showError("Date is reqiured");

      //   return;
      // }

      

      if(_energym=="Select"){
        toaster.showError("Energy Meter Status  is reqiured");

        return;
      }

      if(_oilLeakage=="Select"){
        toaster.showError("Oil Leakage Status  is reqiured");

        return;
      }

      if(_dtFenced=="Select"){
        toaster.showError("DT Fenced Status  is reqiured");

        return;
      }

      if(_feederPillarStatus=="Select"){
        toaster.showError("Feeder Pillar/DB Status  is reqiured");

        return;
      }

      if(_feederPillarUnitStatus=="Select"){
        toaster.showError("Feeder Pillar Unit Status  is reqiured");

        return;
      }

      if(_transOilLevel=="Select"){
        toaster.showError("Tranformer Oil Level  is reqiured");

        return;
      }

      if(_silicaGelVailble=="Select"){
        toaster.showError("Silica Gel Status  is reqiured");

        return;
      }

      if(_lighteningArester=="Select"){
        toaster.showError("Lightening Status  is reqiured");

        return;
      }

      if(hrcFusingController.text==""){
        toaster.showError("HrC Status  is reqiured");

        return;
      }

      if(_isolator=="Select"){
        toaster.showError("Isolator Status  is reqiured");

        return;
      }

      if(_hvCableStatus=="Select"){
        toaster.showError("HV Cable Status  is reqiured");

        return;
      }
    
    
    

    if(_rmu=="Select"){
        toaster.showError("RMU Status  is reqiured");

        return;
      }

      if(_substationBusHy=="Select"){
        toaster.showError("Substation Stay Status  is reqiured");

        return;
      }
    
    
    
    
    
    


      setState(() {
        isApiCallProcess = true;
      });
      try {
        final prefs = await SharedPreferences.getInstance();

        var user = prefs.getString('user');
        var responseFile =
            await Utitlity.uploadMultiFileOnCloudinary(selectedImage);
        print("sewehere${responseFile}");
        String imagePath = Utitlity.convertArrayToString(responseFile);

        var _user = json.decode(user!);

        var data = {
          "TRANSFORMER_ASSESSMENT_CODE": " AssessmentCode",
          "AREA_CODE": _areaSelected["AREA_CODE"] ?? "",
          "FEEDER_CODE": _feeder_eleven["FEEDER_11KV_CODE"] ?? "",
          "FEEDER_NAME": _feeder_eleven["FEEDER_11KV_NAME"] ?? "",
          "AREA_NAME": _areaSelected["AREA_NAME"] ?? "",
          "REGION_NAME": _region_selected["REGION_NAME"] ?? "",
          "REGION_CODE": _region_selected["REGION_CODE"] ?? "",
          "IMAGE_LOCATION": imagePath,
          // "DATE": selectedBDate.toString(),
          "SERVICE_CENTER_CODE":
              service_area_selected["SERVICE_CENTER_CODE"] ?? "",
          "SERVICE_CENTER_NAME":
              service_area_selected["SERVICE_CENTER_NAME"] ?? "",
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
          "LONGITUDE": long,
          "LATITUDE": lat,
          "CAPTURED_BY":
              "${_user["StaffEmail"]} ${_user["StaffId"]} ${_user["StaffName"]}",
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
        description: "You have successfully Saved network assessment for DTR",
        onTap: () {
          setState(() {
            selectedImage.clear();
          });
          formKey.currentState!.reset();
          _areaController.text = "";
          _feederNameController.text = "";
          _num_brokenHtPolesController.text = "";
          _powerFController.text = "";
          _upriserCableNoController.text = "";
          _upriserCableSizeController.text = "";
          _substationEarthResisController.text = "";
          _diskCrackController.text = "";
          _numbBadMissTieSController.text = "";
          _noBadInsulatorController.text = "";
          _numBrokenHtController.text = "";
          _numbLeaningHtPolesController.text = "";
          _emailController.text = "";
          _numLightingArresterController.text = "";
          _vegatationLineController.text = "";
          _saggedHtLineController.text = "";
          //  _substationStayBusController.text="";
          remarksControler.text = "";
          regionController.text = "";
          hrcFusingController.text = "";
          _brokenWeakCrossController.text = "";
          _ltCircuitAverageLeController.text = "";
          _othersNotHighlightedController.text = "";
          _thermoCameraTempController.text = "";
          _thermoCameraColorController.text = "";

          _poleUnderConstThreatController.text = "";

          serviceCenterController.text = "";

          _transforCapacityContoller.text = "";

          _intermediateInController.text = "";
          _nofeederPillerUnitController.text = "";
          _nofeederPillerUnitSpareController.text = "";
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
    AlertToast toaster = new AlertToast(scaffold: scaffoldkey);
    return ImageSelectorModal(
      OnHandleGallery: () async {
        var imageSource = await TakePhoto.takeGallery();
        if (imageSource == null) {
        } else {
          if (selectedImage.length > 5) {
            toaster.showError("Max. image upload is 5.");
            return;
          } else {
            setState(() {
              selectedImage.add(imageSource);
            });
          }
        }
      },
      OnHandleImage: () async {
        var imageSource = await TakePhoto.takeCamera();
        if (imageSource == null) {
        } else {
          if (selectedImage.length > 5) {
            toaster.showError("Max. image upload is 5.");
            return;
          } else {
            setState(() {
              selectedImage.add(imageSource);
            });
          }
        }
      },
    );
  }

  fetchElevenFeeder(feeder) async {
    print("dsdsd${feeder}");
    try {
      setState(() {
        _isLoadingFeeder = true;
      });
      var response = await apiClient.submitPostRequest(
          url: "${APIConstants.BASE_URL}/Get11KVFeederList",
          data: {"FEEDER_33KV_CODE": feeder["FEEDER_CODE_33KV"]});

      if (response["status"] == "success") {
        print("feeders${response["data"]}");
        // toaster.showSuccess("Record Saved Success");
        setState(() {
          _isLoadingFeeder = false;
          _feeder_eleven_list = response["data"];
        });
      } else {
        setState(() {
          _isLoadingFeeder = false;
          // _feeders=response["data"];
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingFeeder = false;
      });
    }
  }

  fetchServiceAreas(area) async {
    print(area);
    try {
      setState(() {
        _isLoadingServiceArea = true;
      });
      var response = await apiClient.submitPostRequest(
          url: "${APIConstants.BASE_URL}/GetServiceCenter",
          data: {"AREA_CODE": area["AREA_CODE"]});

      if (response["status"] == "success") {
        print("feeders${response["data"]}");
        // toaster.showSuccess("Record Saved Success");
        setState(() {
          _isLoadingServiceArea = false;
          _serviceAreas = response["data"];
        });
      } else {
        setState(() {
          _isLoadingServiceArea = false;
          // _feeders=response["data"];
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingServiceArea = false;
      });
    }
  }

  fetchAreas(region) async {
    print(region);
    try {
      setState(() {
        _isLoadingArea = true;
      });
      var response = await apiClient.submitPostRequest(
          url: "${APIConstants.BASE_URL}/GetAreaList",
          data: {"REGION_CODE": region["REGION_CODE"]});

      if (response["status"] == "success") {
        print("feeders${response["data"]}");
        // toaster.showSuccess("Record Saved Success");
        setState(() {
          _isLoadingArea = false;
          _areaList = response["data"];
        });
      } else {
        setState(() {
          _isLoadingArea = false;
          // _feeders=response["data"];
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingArea = false;
      });
    }
  }

  Widget _progress() {
    return Center(
      child: Column(
        children: [
          SizedBox(
              height: 20,
              width: 20,
              child: Center(
                  child: CircularProgressIndicator(
                color: AppColor.mainColor,
              ))),
          SizedBox(
            height: 10,
          ),
          Text(
            "Fetching...",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: Sizes.dimen_11),
          )
        ],
      ),
    );
  }

  showDatePickerDialog() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2032),
    );
    print(date);
    if (date != null) {
      final formatter = DateFormat('dd MMM yyyy');
      final formattedText = formatter.format(date);
      setState(() => selectedBDate = formattedText);
    }
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
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: Sizes.dimen_50,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //         color: AppColor.gray, width: Sizes.dimen_1),
                  //     borderRadius: const BorderRadius.all(
                  //         Radius.circular(Sizes.dimen_6)),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 10),
                  //     child: TextFormField(
                  //       readOnly: true,
                  //       onTap: () {
                  //         showDatePickerDialog();
                  //       },
                  //       decoration: InputDecoration(
                  //           suffixIcon: Icon(
                  //             Icons.calendar_today,
                  //             size: 17,
                  //             color: Colors.black,
                  //           ),
                  //           border: InputBorder.none,
                  //           focusedBorder: InputBorder.none,
                  //           enabledBorder: InputBorder.none,
                  //           errorBorder: InputBorder.none,
                  //           disabledBorder: InputBorder.none,
                  //           hintText: selectedBDate == ""
                  //               ? "Select Date"
                  //               : "${selectedBDate}"),
                  //     ),
                  //   ),
                  // ),
                  DropDownRegion(
                      selectedValue: _region_selected,
                      title: "Select Region",
                      onSelected: (value) {
                        print("fds${value}");

                        fetchAreas(value);
                        setState(() {
                          _region_selected = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  _isLoadingArea
                      ? _progress()
                      : _areaList.length == 0
                          ? Container()
                          : DropDownList(
                              fieldMap: "AREA_NAME",
                              isMap: true,
                              items: _areaList,
                              title: "Choose Area",
                              value: _areaSelected,
                              onChange: (value) {
                                print("heree${value}");
                                fetchServiceAreas(value);
                                setState(() {
                                  _areaSelected = value;
                                });
                              }),
                  _isLoadingServiceArea
                      ? _progress()
                      : _serviceAreas.length == 0
                          ? Container()
                          : DropDownList(
                              fieldMap: "SERVICE_CENTER_NAME",
                              isMap: true,
                              items: _serviceAreas,
                              title: "Choose Service Area",
                              value: service_area_selected,
                              onChange: (value) {
                                print("heree${value}");
                                setState(() {
                                  service_area_selected = value;
                                });
                              }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownFeederThirtyThree(
                      selectedValue: _feeder_thirty_three,
                      title: "Select 33kv Feeder",
                      onSelected: (value) {
                        print("herEE${value}");
                        fetchElevenFeeder(value);
                        setState(() {
                          _feeder_thirty_three = value;
                        });
                      }),
                  _isLoadingFeeder
                      ? _progress()
                      : _feeder_eleven_list.length == 0
                          ? Container()
                          : DropDownList(
                              fieldMap: "FEEDER_11KV_NAME",
                              isMap: true,
                              items: _feeder_eleven_list,
                              title: "Choose 11kv Feeder",
                              value: _feeder_eleven,
                              onChange: (value) {
                                print("heree${value}");
                                setState(() {
                                  _feeder_eleven = value;
                                });
                              }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _transforCapacityContoller,
                    labelTitle: "Enter Transformer Capacity (KVA)",
                    placeHolderText: "Enter Transformer Capacity (KVA)",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
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
                    isNumeric: true,
                    controller: _upriserCableNoController,
                    labelTitle: "Enter No of Upriser Cable",
                    placeHolderText: "Enter No of Upriser Cable",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
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
                    isNumeric: true,
                    controller: _nofeederPillerUnitController,
                    labelTitle: "Enter No. of Feeder Pillar Unit",
                    placeHolderText: "Enter No. of Feeder Pillar Unit",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
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
                    isNumeric: true,
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
                    isNumeric: true,
                    controller: hrcFusingController,
                    labelTitle: "Enter HRC Fuse Rating",
                    placeHolderText: "Enter HRC Fuse Rating",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "HRC Fuse?",
                      value: _hrcFuse,
                      onChange: (value) {
                        setState(() {
                          _hrcFuse = value;
                        });
                      }),
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
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Substationbus  HY",
                      value: _substationBusHy,
                      onChange: (value) {
                        setState(() {
                          _substationBusHy = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
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
                  FormImageSection(
                      file: selectedImage,
                      onRemove: (index) {
                        print("dsddE,${index}");
                        setState(() {
                          selectedImage.removeAt(index);
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
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

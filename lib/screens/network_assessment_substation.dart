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
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geolocator/geolocator.dart';

class NetworkAssessmentSubStation extends StatefulWidget {
  const NetworkAssessmentSubStation({Key? key}) : super(key: key);

  @override
  State<NetworkAssessmentSubStation> createState() =>
      _NetworkAssessmentSubStationState();
}

class _NetworkAssessmentSubStationState
    extends State<NetworkAssessmentSubStation> {
  List _hvLines = [
    "Select",
    "Over Head",
    "UnderGround",
  ];

  List _conducTorTypes = [
    "Select",
    "GOOD",
    "Bad",
  ];

  List _transformerOilLevel = ["Select","LOW", "MEDIUM", "HIGH"];

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

  List _circuitBreakersMain = [
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

  List _cbStatuses = [
    "Select",
    "OUTDOOR",
    "INDOOR",
  ];

  List _sfGasIndicators = ["Select","OK", "LOW", "LEAKAGE"];

  List _oilLevelSpace = [
    "Select",
    "HIGH",
    "LOW",
  ];

   bool _isLoadingArea = false;
   bool _isLoadingFeeder = false;

 bool  _isLoadingServiceArea=false;

  List _areaList = [];
  List _serviceAreas = [];
  List _feeder_eleven_list = [];

   var _feeder_thirty_three;
   var service_area_selected;
   var _feeder_eleven;

  var _region_selected;

  var _areaSelected;

  APIClient apiClient = new APIClient();



  String _hvLine = "";
  String _radioStatus = "";
  String _chargerorBattStatus = "";
  String _mast_atenna = "";
  String _dtFenced = "";
  String _conductType = "";
  String _energym = "";
  String _substationPlinthStatus = "";
  String _autoRecloserStatus = "";
  String _stayStatus = "";
  String _stayInsulatorStatus = "";
  String _auxTransStatus = "";
  String semaphone = "";
  String _springChargingMechanism = "";
  String _poleDiscordance = "";
  String _silicaGelVailble = "";
  String _hrcFuse = "";
  String _isolator = "";
  String _voltageTransStatus = "";
  String _currentTransformerStatus = "";

  String _substationGravelling = "";
  String _substationBusHy = "";

  String _substationCableLugs = "";
  String _feederPillarStatus = "";

  String _feederPillarUnitStatus = "";
  String _transOilLevel = "";
  String _oilLeakage = "";
  String _trippinCond = "";
  String _cbstatus = "";
  String _thirtyThreeCBStatus = "";
  String _elevenCBStatus = "";
  String _sfGasIndication = "";
  String _oil_level_space = "";
  String _chargerStatus = "";
  String _batterBank = "";

  String selectedBDate = "";

  TextEditingController _areaController = TextEditingController();
  TextEditingController _feederNameController = TextEditingController();
  TextEditingController _num_brokenHtPolesController = TextEditingController();
  TextEditingController _powerFController = TextEditingController();
  TextEditingController totalInjectionController = TextEditingController();
  TextEditingController _upriserCableSizeController = TextEditingController();
  TextEditingController _substationEarthResisController =
      TextEditingController();

  TextEditingController _ligteningController = TextEditingController();

  TextEditingController _transformerPeakLoadController =
      TextEditingController();

  TextEditingController _switchYardController = TextEditingController();

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
  TextEditingController _sourceFeederController = TextEditingController();

  TextEditingController temperaure_degController = TextEditingController();
  TextEditingController _silicaGelRemarkController = TextEditingController();
  TextEditingController _oilLeakageRemarkController = TextEditingController();
  TextEditingController _brokenWeakCrossController = TextEditingController();
  TextEditingController elvenFeederAverageLoadController =
      TextEditingController();
  TextEditingController _othersNotHighlightedController =
      TextEditingController();
  TextEditingController _thermoCameraTempController = TextEditingController();
  TextEditingController _thermoCameraColorController = TextEditingController();

  TextEditingController _poleUnderConstThreatController =
      TextEditingController();

  TextEditingController numberSpareController = TextEditingController();

  TextEditingController statusElevenFeederController = TextEditingController();
  TextEditingController numberBadElevenCbController = TextEditingController();

  TextEditingController numberGantryStatusController = TextEditingController();

  TextEditingController serviceCenterController = TextEditingController();

  TextEditingController _substationNameController = TextEditingController();

  TextEditingController capacityControllerMva = TextEditingController();
  TextEditingController _sourceFeederPeakController = TextEditingController();
  TextEditingController _oil_level_remarController = TextEditingController();
  TextEditingController _noIncomerController = TextEditingController();
  TextEditingController _injectionSubElevenController = TextEditingController();
  TextEditingController _outGoingElevenController = TextEditingController();

  TextEditingController relayStatusRemarkController = TextEditingController();
  String _feederPillarPlitchStatus = "";

  List<File?> selectedImage = <File>[];

  bool isApiCallProcess = false;

  // bool _cbStatus=false;

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

    _radioStatus = lighteningAresterOptions[0];
    _chargerorBattStatus = lighteningAresterOptions[0];
    _mast_atenna = lighteningAresterOptions[0];
    _chargerStatus = lighteningAresterOptions[0];
    _batterBank = lighteningAresterOptions[0];
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
    _springChargingMechanism = _circuitBreakers[0];
    semaphone = _circuitBreakers[0];
    _poleDiscordance = _circuitBreakers[0];
    _hrcFuse = _availableOptions[0];
    _isolator = _circuitBreakers[0];
    _voltageTransStatus = _circuitBreakers[0];
    _substationCableLugs = _circuitBreakers[0];

    _substationGravelling = _availableOptionsOther[0];
    _substationBusHy = _energyMs[0];
    _silicaGelVailble = _energyMs[0];
    _oilLeakage = _energyMs[0];
    _transOilLevel = _transformerOilLevel[0];

    _cbstatus = _circuitBreakers[0];
    _thirtyThreeCBStatus = _cbStatuses[0];
    _elevenCBStatus = _cbStatuses[0];
    _trippinCond = _circuitBreakers[0];
    _auxTransStatus = _circuitBreakers[0];
    _currentTransformerStatus = _circuitBreakers[0];
    _sfGasIndication = _sfGasIndicators[0];
    _oil_level_space = _oilLevelSpace[0];
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
        if(_region_selected==null){
         toaster.showError("Region Name is reqiured");

        return;
      }
        if(_areaSelected==null){
         toaster.showError("Area Name is reqiured");

        return;
      }
      if(_feeder_eleven==null){
         toaster.showError("Feeder Name is reqiured");

        return;
      }
      //  if(selectedBDate==""){
      //   toaster.showError("Date is reqiured");

      //   return;
      // } 

       if(_thirtyThreeCBStatus=="Select"){
        toaster.showError("33kv CB Status reqiured");

        return;
      } 

   if(_elevenCBStatus=="Select"){
        toaster.showError("11kv CB Status reqiured");

        return;
      } 

       if(_oilLeakage=="Select"){
        toaster.showError("Oil Leakage Status reqiured");

        return;
      } 

       if(_oilLevelSpace=="Select"){
        toaster.showError("Oil Level Status reqiured");

        return;
      } 

       if(_trippinCond=="Select"){
        toaster.showError("Tripping Condition Status reqiured");

        return;
      } 

       if(_autoRecloserStatus=="Select"){
        toaster.showError("Relay Status reqiured");

        return;
      } 

       if(_springChargingMechanism=="Select"){
        toaster.showError("Charging Mech Status reqiured");

        return;
      } 

      setState(() {
        isApiCallProcess = true;
      });
      try {
        APIClient apiClient = new APIClient();

        final prefs = await SharedPreferences.getInstance();

        var user = prefs.getString('user');

        var _user = json.decode(user!);

        var responseFile =
            await Utitlity.uploadMultiFileOnCloudinary(selectedImage);
        print("sewehere${responseFile}");
        String imagePath = Utitlity.convertArrayToString(responseFile);

        print("imagePath ${imagePath}");

        var data = {
          // "DATE":selectedBDate,
          "INJECTION_SUBSTATION_ASSESSMENT_CODE ": " AssessmentCode",
          "AREA_CODE": _areaSelected["AREA_CODE"]??"",
          
          "FEEDER_CODE": _feeder_eleven["FEEDER_11KV_CODE"]??"",
          "FEEDER_NAME": _feeder_eleven["FEEDER_11KV_NAME"]??"",
           "AREA_NAME":_areaSelected["AREA_NAME"]??"",
          "REGION_NAME": _region_selected["REGION_NAME"]??"",
          "REGION_CODE":  _region_selected["REGION_CODE"]??"",

          
          "SERVICE_CENTER_CODE": service_area_selected["SERVICE_CENTER_CODE"]??"",
          "SERVICE_CENTER_NAME":service_area_selected["SERVICE_CENTER_NAME"]??"",

      
          "SEMAPHONE ": semaphone,
          "SPRING_CHARGING_MECHNISM ": _springChargingMechanism,
          "RELAY_STATUS ": _autoRecloserStatus,
          "TRIPPING_CONDITION ": _trippinCond,
          "GANTRY_STATUS ": numberGantryStatusController.text,
          "NUMBER_OF_BAD_11KV_CBs ": numberSpareController.text,
          "STATUS_OF_11KV_FEEDERS ": statusElevenFeederController.text,
          "NUMBER_OF_SPARE_11KV_CIRCUIT_BREAKERS ": numberSpareController.text,
          "FEEDERS_AVERAGE_LOAD_11KV ": elvenFeederAverageLoadController.text,

          "NUMBER_OF_OUTGOING_11KV_FEEDERS": _outGoingElevenController.text,
          "INJECTION_SUBTATION_11KV_INCOMERS_PEAK_LOAD_SUM":
              _injectionSubElevenController.text,
          "NUMBER_OF_INCOMER_11KV_CB": numberBadElevenCbController.text,
          "PEAK_LOAD": " PEAK_LOAD",
          "SOURCE_FEEDER": _sourceFeederController.text,
          "CB_STATUS_11KV": _elevenCBStatus,
          "CB_STATUS_33KV": _thirtyThreeCBStatus,
          "FEEDER_POWER_FACTOR": _powerFController.text,
          "TOTAL_INJECTION_SUB_CAPACITY_LOADING": totalInjectionController.text,
          "INJECTION_SUBSTATION_CAPACITY": capacityControllerMva.text,
          "INJECTION_SUBSTATION_CODE": " INJECTION_SUBSTATION_CODE",
          "INJECTION_SUBSTATION_NAME": _substationNameController.text,
          "REMARKS": remarksControler.text,
          "LONGITUDE": long,
          "LATITUDE": lat,
          "IMAGE_LOCATION": imagePath,
          "CAPTURED_BY":
              "${_user["StaffEmail"]} ${_user["StaffId"]} ${_user["StaffName"]}",
// "DATE_CAPTURED":" DateTime.Now",
          "THERMO_CAMERA_TEMPERATURE": _thermoCameraTempController.text,
          "THERMO_CAMERA_COLOR": _thermoCameraColorController.text,
          "COMMENT": " COMMENT",
          "OTHER_CONDITIONS": " OTHER_CONDITIONS",
          "SWITCHYARD_STATUS": _switchYardController.text,

          "CURRENT_TRANSFORMER_STATUS": _currentTransformerStatus,
          "VOLTAGE_TRANSFORMER_STATUS": _voltageTransStatus,
          "GANG_ISOLATOR_STATUS": _isolator,
          "TEMPERATURE": temperaure_degController.text,
          "SILICA_GEL": _silicaGelVailble,
          "OIL_LEAKAGE": _oilLeakage,
          "OIL_LEVEL": _oilLevelSpace,
          "CB_STATUS": _cbstatus,
          "BAD_INSULATOR":_noBadInsulatorController.text,
          "SF6_GAS_INDICATION": _sfGasIndication,
          "POLE_DISCORDANCE": _poleDiscordance,
          "LIGHTENING_ARRESTER_CONDITION": _ligteningController.text,
          "INJECTION_SUBSTATION_EARTH_READING":
              " INJECTION_SUBSTATION_EARTH_READING",
          "TRANSFORMER_PEAK_LOAD": _transformerPeakLoadController.text,

          "AUXILLIARY_TRANSFORMER_STATUS": _auxTransStatus,
          "COMMUNICATION_EQUIPMENT_STATUS": " COMMUNICATION_EQUIPMENT_STATUS",
          "TRIPPING_UNIT": " TRIPPING_UNIT",
          "RADIO": _radioStatus,
          "CHARGER_BATTERY": _chargerorBattStatus,
          "MAST_ANTENNA": _mast_atenna,
          "CHARGER": _chargerStatus,
          "BATTERY_BANK": _batterBank,
        };

        var response = await apiClient.submitPostRequest(
            url: "${APIConstants.BASE_URL}/SubstationAssessment", data: data);
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
          formKey.currentState!.reset();
          setState(() {
            selectedImage.clear();
          });

          _areaController.text = "";
          _feederNameController.text = "";
          _num_brokenHtPolesController.text = "";
          _powerFController.text = "";
          totalInjectionController.text = "";
          _upriserCableSizeController.text = "";
          _substationEarthResisController.text = "";

          _ligteningController.text = "";

          _transformerPeakLoadController.text = "";

          _switchYardController.text = "";

          _diskCrackController.text = "";
          _numbBadMissTieSController.text = "";
          _noBadInsulatorController.text = "";
          _numBrokenHtController.text = "";
          _numbLeaningHtPolesController.text = "";
          _emailController.text = "";
          _numLightingArresterController.text = "";
          _vegatationLineController.text = "";
          _saggedHtLineController.text = "";
          _substationStayBusController.text = "";
          remarksControler.text = "";
          regionController.text = "";
          _sourceFeederController.text = "";

          temperaure_degController.text = "";
          _silicaGelRemarkController.text = "";
          _oilLeakageRemarkController.text = "";
          _brokenWeakCrossController.text = "";
          elvenFeederAverageLoadController.text = "";
          _othersNotHighlightedController.text = "";
          _thermoCameraTempController.text = "";
          _thermoCameraColorController.text = "";

          _poleUnderConstThreatController.text = "";

          numberSpareController.text = "";

          statusElevenFeederController.text = "";
          numberBadElevenCbController.text = "";

          numberGantryStatusController.text = "";

          serviceCenterController.text = "";

          _substationNameController.text = "";

          capacityControllerMva.text = "";
          _sourceFeederPeakController.text = "";
          _oil_level_remarController.text = "";
          _noIncomerController.text = "";
          _injectionSubElevenController.text = "";
          _outGoingElevenController.text = "";

          relayStatusRemarkController.text = "";
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
          "Network Assessment SubStation",
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
                        "Network Assessment SubStation",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      )),
                  SizedBox(
                    height: 40,
                  ),

                  //  Container(
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

                    SizedBox(height:15),

                
                  GeneralTextBox(
                    // validator: (val) {
                    //   if (val == "") return "Area is required";
                    // },
                    controller: _sourceFeederController,
                    labelTitle: "Enter Source of Feeder",
                    placeHolderText: "Enter Source of Feeder",
                    onChange: (e) {},
                  ),

                 
                  
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GeneralTextBox(
                  //   controller: _feederNameController,
                  //   labelTitle: "Enter Feeder Name",
                  //   placeHolderText: "Enter Feeder Name",
                  //   onChange: (e) {},
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _substationNameController,
                    labelTitle: "Enter Injection Substation Name",
                    placeHolderText: "Enter Injection Substation Name",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: capacityControllerMva,
                    labelTitle: "Enter Capacity MVA",
                    placeHolderText: "Enter Capacity MVA",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: totalInjectionController,
                    labelTitle: "Enter Total Injection Sub. Capacity%",
                    placeHolderText: "Enter Total Injection Sub. Capacity%",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _powerFController,
                    labelTitle: "Enter Feeder Power Factor",
                    placeHolderText: "Enter Feeder Power Factor",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _cbStatuses,
                      title: "33kv CB Status",
                      value: _thirtyThreeCBStatus,
                      onChange: (value) {
                        setState(() {
                          _thirtyThreeCBStatus = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),

                  DropDownList(
                      items: _cbStatuses,
                      title: "11kv CB Status",
                      value: _elevenCBStatus,
                      onChange: (value) {
                        setState(() {
                          _elevenCBStatus = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _oilLevelSpace,
                      title: "Oil Level",
                      value: _oil_level_space,
                      onChange: (value) {
                        setState(() {
                          _oil_level_space = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _oil_level_remarController,
                    labelTitle: "Enter Oil Level Remark",
                    placeHolderText: "Enter Oil Level Remark",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _sourceFeederPeakController,
                    labelTitle: "Enter Temeperature (Degree Celcius)",
                    placeHolderText: "Enter Temeperature (Degree Celcius)",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _noIncomerController,
                    labelTitle: "Enter No. of Incomer 11kv",
                    placeHolderText: "Enter No. of Incomer 11kv",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _injectionSubElevenController,
                    labelTitle: "Enter Injection Substation 11kv Incomer (MW)",
                    placeHolderText:
                        "Enter Injection Substation 11kv Incomer (MW)",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  GeneralTextBox(
                    isNumeric: true,
                    controller: _outGoingElevenController,
                    labelTitle: "Enter Number of Outgoing 11kv Feeders",
                    placeHolderText: "Enter Number of Outgoing 11kv Feeders",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  GeneralTextBox(
                    isNumeric: true,
                    controller: elvenFeederAverageLoadController,
                    labelTitle: "Enter 11kv Feeders Average Load(MW)",
                    placeHolderText: "Enter 11kv Feeders Average Load(MW)",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  GeneralTextBox(
                    isNumeric: true,
                    controller: numberSpareController,
                    labelTitle: "Enter Number of Spare 11kv Circuit Breakers",
                    placeHolderText:
                        "Enter Number of Spare 11kv Circuit Breakers",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  GeneralTextBox(
                    controller: statusElevenFeederController,
                    labelTitle: "Enter Status of 11kv Feeders",
                    placeHolderText: "Enter Status of 11kv Feeders",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  GeneralTextBox(
                    isNumeric: true,
                    controller: numberBadElevenCbController,
                    labelTitle: "Enter No. of Bad 11kv CBs",
                    placeHolderText: "Enter No. of Bad 11kv CBs",
                    onChange: (e) {},
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  GeneralTextBox(
                    controller: numberGantryStatusController,
                    labelTitle: "Enter Gantry Status",
                    placeHolderText: "Enter Gantry Status",
                    onChange: (e) {},
                  ),

                  DropDownList(
                      items: _circuitBreakers,
                      title: "Tripping Condition?",
                      value: _trippinCond,
                      onChange: (value) {
                        setState(() {
                          _trippinCond = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Relay Status",
                      value: _autoRecloserStatus,
                      onChange: (value) {
                        setState(() {
                          _autoRecloserStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: relayStatusRemarkController,
                    labelTitle: "Relay Status Remark",
                    placeHolderText: "Relay Status Remark",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Spring Charging Mechanism",
                      value: _springChargingMechanism,
                      onChange: (value) {
                        setState(() {
                          _springChargingMechanism = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "SemaPhone",
                      value: semaphone,
                      onChange: (value) {
                        setState(() {
                          semaphone = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Pole Discordance",
                      value: _poleDiscordance,
                      onChange: (value) {
                        setState(() {
                          _poleDiscordance = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "SF6 Gas Indication",
                      value: _sfGasIndication,
                      onChange: (value) {
                        setState(() {
                          _sfGasIndication = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "CB Status",
                      value: _cbstatus,
                      onChange: (value) {
                        setState(() {
                          _cbstatus = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: temperaure_degController,
                    labelTitle: "Temperature Degree",
                    placeHolderText: "Temperature Degree",
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

                  GeneralTextBox(
                    controller: _silicaGelRemarkController,
                    labelTitle: "Silica Gel Remark",
                    placeHolderText: "Silica Gel Remark",
                    onChange: (e) {},
                  ),
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
                  GeneralTextBox(
                    controller: _oilLeakageRemarkController,
                    labelTitle: "Oil Leakage Remark",
                    placeHolderText: "Oil Leakage Remark",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Gang Isolator Status?",
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
                      title: "Voltage Transformer Status?",
                      value: _voltageTransStatus,
                      onChange: (value) {
                        setState(() {
                          _voltageTransStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),

                  DropDownList(
                      items: _circuitBreakers,
                      title: "Current Transformer Status",
                      value: _currentTransformerStatus,
                      onChange: (value) {
                        setState(() {
                          _currentTransformerStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    controller: _switchYardController,
                    labelTitle: "Enter Switch Yard Status",
                    placeHolderText: "Enter Switch Yard Status",
                    onChange: (e) {},
                  ),

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
                    isNumeric: true,
                    controller: _noBadInsulatorController,
                    labelTitle:
                        "Enter 33kv Bad Insulator",
                    placeHolderText:
                        "Enter 33kv Bad Insulator",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _substationEarthResisController,
                    labelTitle:
                        "Enter Injection Substation Earth Reading(OHMS)",
                    placeHolderText:
                        "Enter Injection Substation Earth Reading(OHMS)",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  GeneralTextBox(
                    controller: _ligteningController,
                    labelTitle: "Enter Ligtening Arrester condition",
                    placeHolderText: "Enter Ligtening Arrester condition",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _transformerPeakLoadController,
                    labelTitle: "Enter Transformer Peak Load (MW)",
                    placeHolderText: "Enter Transformer Peak Load (MW)",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Auxillary Transformer Status",
                      value: _auxTransStatus,
                      onChange: (value) {
                        setState(() {
                          _auxTransStatus = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: lighteningAresterOptions,
                      title: "Radio",
                      value: _radioStatus,
                      onChange: (value) {
                        setState(() {
                          _radioStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: lighteningAresterOptions,
                      title: "Charger/ Battery",
                      value: _chargerorBattStatus,
                      onChange: (value) {
                        setState(() {
                          _chargerorBattStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: lighteningAresterOptions,
                      title: "Mast/ Atenna",
                      value: _mast_atenna,
                      onChange: (value) {
                        setState(() {
                          _mast_atenna = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: lighteningAresterOptions,
                      title: "Charger",
                      value: _chargerStatus,
                      onChange: (value) {
                        setState(() {
                          _chargerStatus = value;
                        });
                      }),

                  SizedBox(
                    height: 15,
                  ),

                  DropDownList(
                      items: lighteningAresterOptions,
                      title: "Battery Bank",
                      value: _batterBank,
                      onChange: (value) {
                        setState(() {
                          _batterBank = value;
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
                    height: 30,
                  ),
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

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
import 'package:aedc_disco/widgets/common/form/drop_down_cable_type.dart';
import 'package:aedc_disco/widgets/common/form/drop_down_feeder_thirty_three.dart';
import 'package:aedc_disco/widgets/common/form/form_image_section.dart';
import 'package:aedc_disco/widgets/common/general_text_box.dart';
import 'package:aedc_disco/widgets/common/image_selector_modal.dart';
import 'package:aedc_disco/widgets/common/success_modal.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/common/form/drop_down_region.dart';
// import 'package:geolocator/geolocator.dart';

class NetworkAssessmentEleven extends StatefulWidget {
  const NetworkAssessmentEleven({Key? key}) : super(key: key);

  @override
  State<NetworkAssessmentEleven> createState() =>
      _NetworkAssessmentElevenState();
}

class _NetworkAssessmentElevenState extends State<NetworkAssessmentEleven> {
  Color _maincolor = Color(0xff000375);
  bool _obscureText = false;
  List _hvLines = [
    "Select",
    "Over Head",
    "UnderGround",
  ];

  List _conducTorTypes = [
   "Select",
    "AAC",
    "ACSR",
  ];

  List _energyMs = [
    "Select",
    "YES",
    "NO",
  ];

    List _relayTypes = [
     "Select",
    "DIGITAL",
    "ANALOG",
  ];

  List _circuitBreakers = [
    "Select",
    "GOOD",
    "BAD",
  ];

  List _cableTypes = [
    "Select",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",

  ];

   String _selectedCableType = "";

   bool _isLoadingArea = false;
   bool _isLoadingFeeder = false;
    List _serviceAreas = [];
    bool  _isLoadingServiceArea=false;
     var service_area_selected;

  List _areaList = [];
  List _feeder_eleven_list = [];

   var _feeder_thirty_three;
   var _feeder_eleven;
    var _cable_type_selected;

  var _region_selected;

  var _areaSelected;

  APIClient apiClient = new APIClient();

  String _showPeakError="";
  String _hvLine = "";
  String _conductType = "";
  String _relayType="";
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
  TextEditingController _feederRouteLengthController = new TextEditingController();
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

   List<File?> selectedImage=<File>[];

  bool isApiCallProcess = false;

  // late Position _currentPosition;

  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey();

  final formKey = GlobalKey<FormState>();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
       String long = "", lat = "";
         String selectedBDate = "";
 

   checkGps() async {
      servicestatus = await Geolocator.isLocationServiceEnabled();
      if(servicestatus){
            permission = await Geolocator.checkPermission();
          
            if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.denied) {
                    print('Location permissions are denied');
                }else if(permission == LocationPermission.deniedForever){
                    print("'Location permissions are permanently denied");
                }else{
                   haspermission = true;
                }
            }else{
               haspermission = true;
            }

            if(haspermission){
                setState(() {
                  //refresh the UI
                });

                getLocation();
            }
      }else{
        
        print("GPS Service is not enabled, turn on GPS location");
      }

      setState(() {
         //refresh the UI
      });
  }

  getLocation() async {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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
    _relayType=_relayTypes[0];
    _selectedCableType=_cableTypes[0];
    checkGps();
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

       if (_cable_type_selected == null) {
        toaster.showError("Cable type is reqiured");

        return;
      }

      if(_feederPeakLoadContoller.text.isEmpty){
        toaster.showError("Peak Load is reqiured");

        return;
      }
      // if(selectedBDate==""){
      //   toaster.showError("Date is reqiured");

      //   return;
      // }

      if(double.parse(_feederPeakLoadContoller.text)>7.0){
        toaster.showError("Invalid max Peak Load");

        return;
      }

  if(_conductType=="Select"){
        toaster.showError("Conductor Status  is reqiured");

        return;
      }

      if(_energym=="Select"){
        toaster.showError("Energy Meter Status  is reqiured");

        return;
      }
      if(_circuitBreaker=="Select"){
        toaster.showError("Circuit Breaker Status  is reqiured");

        return;
      }
      if(_stayStatus=="Select"){
        toaster.showError("Stay Status  is reqiured");

        return;
      }

      if(_relayStatusController.text==""){
        toaster.showError("Relay Status  is reqiured");

        return;
      }
      if(_autoRecloserStatus=="Select"){
        toaster.showError("Auto Recloser Status  is reqiured");

        return;
      }
       if(_stayInsulatorStatus=="Select"){
        toaster.showError("Stay Insulator Status  is reqiured");

        return;
      }

      if (_selectedCableType == "Select") {
        toaster.showError("Cable Type  is reqiured");
        return;
      }

      


      setState(() {
        isApiCallProcess = true;
      });
      try {
      

        final prefs = await SharedPreferences.getInstance();

        var user = prefs.getString('user');

        var _user = json.decode(user!);

          var responseFile =
            await Utitlity.uploadMultiFileOnCloudinary(selectedImage);
            print("sewehere${responseFile}");
         String imagePath=   Utitlity.convertArrayToString(responseFile);

        var data = {
          // "DATE":selectedBDate,
          "AREA_CODE": _areaSelected["AREA_CODE"],
          "NETWORK_ASSESSMENT_11KV_CODE": "AssessmentCode",
          "CRACKED_SHATTERED_POT_INSULATOR": _crackpotInsullatorController.text,
          "UNDER_GROUND_CABLE_TYPE": _undergroudCableTypeController.text,
          "CONDUCTOR_TYPE": _conductType,
         "CABLE_TYPE": _cable_type_selected["CableTypeName"],
          "WEAK_UNDERSIZED_CONDUCTOR": _weakUControlller.text,
          "FEEDER_PEAK_LOAD": _feederPeakLoadContoller.text,
          "HIGH_VOLTAGE_LINE_TYPE": _hvLine,
          "FEEDER_POWER_FACTOR": _powerFController.text,
          "FEEDER_ROUTE_LENGTH": _feederRouteLengthController.text,
          "FEEDER_CODE": _feeder_eleven["FEEDER_11KV_CODE"],
          "FEEDER_NAME": _feeder_eleven["FEEDER_11KV_NAME"],
           "AREA_NAME":_areaSelected["AREA_NAME"],
          "REGION_NAME": _region_selected["REGION_NAME"],
          "REGION_CODE":  _region_selected["REGION_CODE"],
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
          "CRACKED_SHATTERED_DISC_INSULATOR": _diskCrackController.text,
           "SERVICE_CENTER_CODE": service_area_selected["SERVICE_CENTER_CODE"]??"",
          "SERVICE_CENTER_NAME":service_area_selected["SERVICE_CENTER_NAME"]??"",
          "LONGITUDE": long,
          "LATITUDE": lat,
          "IMAGE_LOCATION": imagePath,
          "CAPTURED_BY":"${_user["StaffEmail"]} ${_user["StaffId"]} ${_user["StaffName"]}",
          "REMARKS": remarksControler.text,
          "OTHERS_STATUS": "OTHERS_STATUS",
          "OTHERS_NOT_HIGHLIGHTED": _othersNotHighlightedController.text,
          "AUTORECLOSER_STATUS": _autoRecloserStatus,
          "THERMO_CAMERA_TEMPERATURE": _thermoCameraTempController.text,
          "THERMO_CAMERA_COLOR": _thermoCameraColorController.text,
          "RELAY_TYPE": _relayType,
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
          setState(() {
            selectedImage.clear();
           });

          _areaController.text="";
          _feederNameController.text="";
          _num_brokenHtPolesController.text="";
          _powerFController.text="";
          _feederPeakLoadContoller.text="";
          _weakUControlller.text="";
          _crackpotInsullatorController.text="";
          _diskCrackController.text="";
          _numbBadMissTieSController.text="";
          _noBadInsulatorController.text="";
          _numBrokenHtController.text="";
          _numbLeaningHtPolesController.text="";
          _emailController.text="";
          _numLightingArresterController.text="";
          _vegatationLineController.text="";
          _saggedHtLineController.text="";
          // _relayStatusController.text="";
          remarksControler.text="";
          regionController.text="";
          weakJumperController.text="";
          _brokenWeakCrossController.text="";
          _undergroudCableTypeController.text="";
          _othersNotHighlightedController.text="";
          _thermoCameraTempController.text="";
          _thermoCameraColorController.text="";

          _poleUnderConstThreatController.text="";

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
          if (selectedImage.length>5) {
            toaster.showError("Max. image upload is 5.");
            return;
          }else{
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
            if (selectedImage.length>5) {
            toaster.showError("Max. image upload is 5.");
            return;
          }else{
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

                     
                  
                    DropDownCableType(selectedValue: _cable_type_selected, onSelected: (value) {
                        setState(() {
                          _cable_type_selected = value;
                        });
                      }, title: "Select Cable Type"),
                  
                  SizedBox(
                    height: 15,
                  ),
                  
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _feederRouteLengthController,
                    labelTitle: "Enter Feeder Route Length(KM)",
                    placeHolderText: "Enter Feeder Route Length",
                    onChange: (e) {},
                  ),
                   SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _numBrokenHtController,
                    labelTitle: "Enter No. of Broken HT Poles",
                    placeHolderText: "No. of Broken HT Poles",
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
                  _buildHVLinTyTextField(),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _feederPeakLoadContoller,
                    labelTitle: "Enter Feeder Peak Load(MW)",
                    placeHolderText: "Enter Feeder Peak Load(MW)",
                    onChange: (val) {
                       if(double.parse(val)>7.0){
                        setState(() {
                          _showPeakError="Peak Load is Invalid";
                        });
                      }else{
                        setState(() {
                          _showPeakError="";
                        });
                        
                      }
                    },
                  ),
                  _showPeakError!=""?Align(alignment: Alignment.topLeft, child: Text(_showPeakError,style: TextStyle(color:AppColor.primaryRed),)):

                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _weakUControlller,
                    labelTitle: "Weak Undersized Conductor(Meter)",
                    placeHolderText: "Weak Undersized Conductor(Meter)",
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

                      SizedBox(height: 15,),
                      DropDownList(
                      items: _relayTypes,
                      title: "Choose Relay Type",
                      value: _relayType,
                      onChange: (value) {
                        setState(() {
                          _relayType = value;
                        });
                      }),

                      
                  SizedBox(
                    height: 15,
                  ),
                    DropDownList(
                      items: _circuitBreakers,
                      title: "Stay Status",
                      value: _stayStatus,
                      onChange: (value) {
                        setState(() {
                          _stayStatus = value;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropDownList(
                      items: _circuitBreakers,
                      title: "Stay Insulator Status",
                      value: _stayInsulatorStatus,
                      onChange: (value) {
                        setState(() {
                          _stayInsulatorStatus = value;
                        });
                      }),

                       DropDownList(
                      items: _cableTypes,
                      title: "Choose Cable Type",
                      value: _selectedCableType,
                      onChange: (value) {
                        setState(() {
                          _selectedCableType = value;
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
                    isNumeric: true,
                    controller: weakJumperController,
                    labelTitle: "Enter No Weak Jumper/Hotspot",
                    placeHolderText: "Enter No Weak Jumper/Hotspot",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    // isNumeric: true,
                    controller: _brokenWeakCrossController,
                    labelTitle:
                        "Enter 11kv Broken/Weak Cross Arms(Indicate Type- Wooden/Fibre/Channel)",
                    placeHolderText: "Enter 11kv Broken/Weak",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _crackpotInsullatorController,
                    labelTitle: "Enter No. of Cracked Pot Insulator",
                    placeHolderText: "Enter No. of Cracked Pot Insulator",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _poleUnderConstThreatController,
                    labelTitle: "Enter No. of Pole Under Erosion Threat",
                    placeHolderText: "Enter No. of Pole Under Erosion Threat",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _diskCrackController,
                    labelTitle: "Enter No. of Crack Disk Insulator",
                    placeHolderText: "Enter No. of Crack Disk Insulator",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _numbBadMissTieSController,
                    labelTitle: "Enter No. of Missing TieStraps",
                    placeHolderText: "Enter No. of Missing TieStraps",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _noBadInsulatorController,
                    labelTitle: "Enter No. of Bad Insulator",
                    placeHolderText: "Enter No. of Bad Insulator",
                    onChange: (e) {},
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // GeneralTextBox(
                  //   controller: _numBrokenHtController,
                  //   labelTitle: "Enter No. Of Broken HT Poles",
                  //   placeHolderText: "Enter No. Of Broken HT Poles",
                  //   onChange: (e) {},
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _numbLeaningHtPolesController,
                    labelTitle: "Enter No. of Leaning HT Poles",
                    placeHolderText: "Enter No. of Leaning HT Poles",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _numLightingArresterController,
                    labelTitle: "Enter No. of Bad Lightening Arrester",
                    placeHolderText: "Enter No. of Bad Lightening Arrester",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _vegatationLineController,
                    labelTitle: "Enter Vegetation Fouling Line(Spans)",
                    placeHolderText: "Enter Vegetation Fouling Line(Spans)",
                    onChange: (e) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GeneralTextBox(
                    isNumeric: true,
                    controller: _saggedHtLineController,
                    labelTitle: "Enter Sagged HT Lines(Meter)",
                    placeHolderText: "Enter Sagged HT Lines(Meter)",
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
                  FormImageSection(file: selectedImage,onRemove: (index){
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

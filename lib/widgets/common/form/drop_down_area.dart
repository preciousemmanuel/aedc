import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:aedc_disco/config/api_constant.dart';
import 'package:aedc_disco/network/api_client.dart';
import 'package:aedc_disco/widgets/common/drop_down.dart';
import 'package:flutter/material.dart';

class DropDownArea extends StatefulWidget {
  final selectedValue;
  final Function onSelected;
  final String title;
  const DropDownArea(
      {Key? key,
      required this.selectedValue,
      required this.onSelected,
      required this.title})
      : super(key: key);

  @override
  State<DropDownArea> createState() =>
      _DropDownAreaState();
}

class _DropDownAreaState extends State<DropDownArea> {
  List _feeders = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchFeeders();
  }

  APIClient apiClient = new APIClient();

  fetchFeeders() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var response = await apiClient.getApiRequest(
          url: "${APIConstants.BASE_URL}/GetRegionList", data: {});

      if (response["status"] == "success") {
        print("feeders${response["data"]}");
        // toaster.showSuccess("Record Saved Success");
        setState(() {
          _isLoading = false;
          _feeders = response["data"];
        });
      } else {
        setState(() {
          _isLoading = false;
          // _feeders=response["data"];
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
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
            "Fetching Areas...",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: Sizes.dimen_11),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? _progress()
        : _feeders.length == 0
            ? TextButton(
                onPressed: () {
                  fetchFeeders();
                },
                child: Text(
                  "Refresh",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: Sizes.dimen_5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        //padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton(
                            value: widget.selectedValue,
                            hint: Text(widget.title),
                            items: _feeders
                                .map<DropdownMenuItem<dynamic>>((identity) {
                              return DropdownMenuItem(
                                child: Text(identity["REGION_NAME"]),
                                value: identity["REGION_NAME"],
                              );
                            }).toList(),
                            onChanged: (dynamic e) {
                              widget.onSelected(e);
                            }),
                      )
                    ])

                // onSaved: (value) => email = value

                );
    ;
  }
}

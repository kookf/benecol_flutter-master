import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/user_provider.dart';
import 'package:benecol_flutter/screens/profile/exchange_products/exchange_product_form/widgets/edit_address.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef AddressCallback = void Function(Map<String, dynamic>);

class AddressList extends StatefulWidget {
  AddressCallback onSelectAddressCallback;

  AddressList({ 
    Key? key,
    required this.onSelectAddressCallback
  }) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  var _userAddressList;
  int? _hoverIndex;
  late AppLocalizations T;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      getUserAddressList(context);
    });
  }

  Future<void> getUserAddressList(BuildContext context) async {
    await context.read<UserProvider>().getUserAddressList(context);
  }
  
  void showEditAddressModal(BuildContext context, int addressId, Map<String, dynamic> data){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return EditAddress(
            id: addressId,
            data: data,
            dismissCallback:(){
              getUserAddressList(context);
            }
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void onAddAddressBtnClick(){
    showEditAddressModal(context, 0, {});
  }

  void onAddressTapDown(int index){
    setState(() {
      _hoverIndex = index;
    });
  }

  void onAddressTapUp(Map<String, dynamic> address){
    onAddressTapCancel();
    // print('onAddressTapUp: $address');
    Map<String, dynamic> _sendObj = {
      'id': address['id'],
      'address': address['address'],
      'name': address['name'],
      'phone': address['phone']
    };
    widget.onSelectAddressCallback(_sendObj);
    Navigator.pop(context);
  }

  void onAddressTapCancel(){
    setState(() {
      _hoverIndex = null;
    });
  }

  Future<void> onRemoveAddress(int id) async {
    var result = await context.read<UserProvider>().deleteUserAddress(context, id);
  }

  void onEditAddress(int id, Map<String, dynamic> data){
    showEditAddressModal(context, id, data);
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _userAddressList = context.watch<UserProvider>().userAddressList;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kAppBarHeight,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          // '地址信息',
          T.exchangeProductAddressListTitle,
          style: TextStyle(
            fontSize: kAppBarFontSize
          )
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10, 
                  vertical: 10
                ),
                child: Column(
                  children: [
                    if((_userAddressList?.length ?? 0) != 0)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            T.exchangeProductAddressListChooseTitle,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20
                            )
                          )
                        ],
                      ),
                    ),
                    if((_userAddressList?.length ?? 0) == 0)
                    Text(
                      T.exchangeProductAddressListNoRecord
                    ),
                    ...List.generate(
                      _userAddressList.length, 
                      (index) => AddressRow(
                        index: index,
                        data: _userAddressList[index],
                        hovered: _hoverIndex == index,
                        onTapUp: onAddressTapUp,
                        onTapDown: onAddressTapDown,
                        onTapCancel: onAddressTapCancel,
                        onEditAddress: onEditAddress,
                        onRemoveAddress: onRemoveAddress,
                      )
                    )
                  ]
                ),
              )
            ),
          ),
          BottomButton(
            // buttonText: '添加地址',
            buttonText: T.exchangeProductAddressListAddAddress,
            press: onAddAddressBtnClick
          )
        ]
      )
    );
  }
}

class AddressRow extends StatelessWidget {
  int index;
  bool hovered;
  Function onTapUp;
  Function onTapDown;
  Function onTapCancel;
  Function onEditAddress;
  Function onRemoveAddress;
  Map<String, dynamic> data;

  AddressRow({
    Key? key,
    required this.data,
    required this.index,
    required this.hovered,
    required this.onTapUp,
    required this.onTapDown,
    required this.onTapCancel,
    required this.onEditAddress,
    required this.onRemoveAddress
  }) : super(key: key);

  var icon = {
  	"address":"assets/icons/icon-15.png"
  };

  void onEditAddressClick(Map<String, dynamic> $data){
    int id = $data['id'];
    Map<String, dynamic> _sendObj = {
      "name": $data['name'],
      "address": $data['address'],
      "phone": $data['phone']
    };
    onEditAddress(id, _sendObj);
  }
  Future<void> onRemoveAddressClick(BuildContext context, $data) async {
    AppLocalizations T = AppLocalizations.of(context)!;
    bool _isDelete = await showAlertDialogWithConfirmAndCancel(
      context,
      // content: '確定刪除？',
      content: T.exchangeProductAddressListDeleteMessage,
      // confirmActionText: '確定',
      confirmActionText: T.dialogConfirm,
      // cancelActionText: '取消',
      cancelActionText: T.dialogCancel,
    );
    if(!_isDelete) return;
    int id = $data['id'];
    onRemoveAddress(id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (evt){
        onTapDown(index);
      },
      onTapUp: (evt){
        onTapUp(data);
      },
      onTapCancel: (){
        onTapCancel();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade100,
              width: 1
            )
          ),
          color: hovered ? Colors.grey.shade100 : Colors.transparent
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only( 
                right: 15,
                top: 10,
                bottom: 10,
              ),
              child: Image.asset(
                icon['address']!
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data["name"]} ${data["phone"]}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${data["address"]}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      height: 1,
                    )
                  )
                ],
              )
            ),
            Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      onEditAddressClick(data);
                    },
                    child: Container(
                      width:30,
                      height:30,
                      child: Icon(
                        Icons.mode_edit,
                        size: 30
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      onRemoveAddressClick(context, data);
                    },
                    child: Container(
                      width:30,
                      height:30,
                      child: Icon(
                        Icons.delete_outline,
                        size: 30
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
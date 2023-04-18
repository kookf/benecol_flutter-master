
import 'dart:convert';
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/providers/content_provider.dart';
import 'package:benecol_flutter/models/event.dart';
import 'package:benecol_flutter/screens/reminder/widgets/reminder_content.dart';
import 'package:benecol_flutter/services/localStorage.dart';
import 'package:benecol_flutter/util/size.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart'; 
import 'package:benecol_flutter/services/notificationService.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReminderBody extends StatefulWidget {
  ReminderBody({ Key? key }) : super(key: key);

  @override
  _ReminderBodyState createState() => _ReminderBodyState();
}

class _ReminderBodyState extends State<ReminderBody> {
  Map<String, dynamic>? _reminderContent;
  late Map<String, List<Event>> selectedEvents;
  int notificationTimes = 21;
  DateTime? selectedDateTime;
  bool isSetEvent = false;
  LocalStorageSingleton localStorageSingleton = LocalStorageSingleton();
  late AppLocalizations T;

  var icon = {
  	"intake":"assets/icons/intake_Icon.png",
  };

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    Future.delayed(Duration.zero).then((value) async{
      getReminderContent(context);
      Map<String, List<Event>> newSelectedEvents = await initSelectedEvent();
      setState(() {
        selectedEvents = newSelectedEvents;
        if(newSelectedEvents.keys.length > 0){
          isSetEvent = true;
        }
      });
    });
  }

  Future<Map<String, List<Event>>> initSelectedEvent() async{
    String selectedEventsStr = await localStorageSingleton.getValue('events') ?? '';
    if(selectedEventsStr != ''){
      try{ //Rebuild Map of selectedEvents
        var selectedEventsJson = json.decode(selectedEventsStr);
        Map<String, List<Event>> newSelectedEvents = {};
        for(String dateTimeStr in selectedEventsJson.keys){
          newSelectedEvents[dateTimeStr] = [];
          List<Event> _eventList = [];
          for(int i = 0; i < selectedEventsJson[dateTimeStr].length; i++){
            Event _event = new Event(title: selectedEventsJson[dateTimeStr][i]['title']);
            _eventList.add(_event);
          }
          newSelectedEvents[dateTimeStr] = _eventList;
        }
        return newSelectedEvents;
      }catch(e){
        return {};
      }
    }
    return {};
  }

  Future<void> getReminderContent(BuildContext context) async{
    int _currentId = getCurrentLangId(context);
    await context.read<ContentProvider>().getReminderContent(context, _currentId.toString());
  }

  List<Event> getEventFromDay(DateTime date){
    return selectedEvents[date.toString()] ?? [];
  }

  Future<void> resetEventAndSchedule() async {
    EasyLoading.show();
    setState(() {
      selectedEvents = {};
      isSetEvent = false;
    });
    await localStorageSingleton.setValue('events', '');

    await clearAllScheduleNotification();
    EasyLoading.dismiss();
  }

  Future<void> addEvents(DateTime dateTime) async {
    EasyLoading.show();
    int year,
      month,
      day;

    year = dateTime.year;
    month = dateTime.month;
    for(int i=0; i<notificationTimes; i++){
      day = dateTime.day + i;
      DateTime eventDay = DateTime.utc(year, month, day);
      Event newEvent = Event(title: 'Benecol Remind');

      setState(() {
        if(selectedEvents[eventDay.toString()]!=null){
          selectedEvents[eventDay.toString()]!.add(newEvent);
        }else{
          selectedEvents[eventDay.toString()] = [newEvent];
        }
      });
    }
    setState(() {
      isSetEvent = true;
    });
    await localStorageSingleton.setValue('events', json.encode(selectedEvents));
    EasyLoading.dismiss();
  }

  void scheduleNotification(DateTime dateTime){
    Duration duration;
    int id;
    // String message = 'Benecol提提你\n係時候飲用一支Benecol降低壞膽固醇，為健康打氣：）';
    String message = T.reminderMessage;
    bool isPassedToday = false;
    DateTime now = DateTime.now();
    int differenceInSeconds = dateTime.difference(now).inSeconds;
    int oneDayInSeconds = 86400;
    isPassedToday = differenceInSeconds <= 0;

    for(int i = 0; i < notificationTimes; i++){
      if(i==0 && isPassedToday) continue; // Escape first schedule when dateTime set is passed current time
      id = (i*100+i); // special id to avoid collision
      duration = Duration(seconds: differenceInSeconds + (oneDayInSeconds * i));
      // if(i == notificationTimes - 1) message = '恭喜你完成了3星期療程，測試一下你的膽固醇水平吧！';
      if(i == notificationTimes - 1) message = T.reminderFinishedMessage;
      NotificationService.scheduleNotification(id, '', message, duration);
    }
  }

  Future<void> clearAllScheduleNotification() async {
    await NotificationService.clearAllSchedule();
  }

  Future<void> showTimePicker() async {
    // String actionText = '確認';
    String actionText = T.dialogConfirm;
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.time;
    void resetSelectedDateTime(){
      setState(() {
        selectedDateTime = DateTime.now();
      });
    }
    resetSelectedDateTime();

    showSheet(
      context, 
      child: SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: mode,
          onDateTimeChanged: (dateTime){
            selectedDateTime = dateTime;
          }
        )
      ), 
      actionText: actionText,
      onClicked: (){
        if(selectedDateTime == null) return;
        addEvents(selectedDateTime!);
        scheduleNotification(selectedDateTime!);
        Navigator.pop(context);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    _reminderContent = context.watch<ContentProvider>().reminderContent;

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children:[ 
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: TableCalendar(
                  locale : Localizations.localeOf(context).toString(),
                  firstDay: DateTime.utc(1970, 1, 1),
                  lastDay: DateTime.utc(2100, 1, 1),
                  focusedDay: DateTime.now(),
                  eventLoader: (day){
                    return getEventFromDay(day);
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, data, events){
                      return Stack(
                        children: [
                          if(events.length > 0)
                          Positioned(
                            bottom: 0,
                            right: 3,
                            child: Icon(
                              Icons.check_circle,
                              color: kSecondaryColor,
                              size: 15
                            )
                          )
                        ]
                      );
                    },
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                      color: kPrimaryColor,
                    ),
                    headerPadding: EdgeInsets.zero,
                    titleCentered: true,
                    formatButtonVisible: false
                  ),
                  daysOfWeekHeight: 20,
                  rowHeight: 30,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                    ),
                    weekendStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                    )
                  ),
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    todayDecoration: BoxDecoration(
                      color: kPrimaryColor, 
                      shape: BoxShape.circle
                    ),
                    defaultTextStyle: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 12
                    ),
                    weekendTextStyle: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 12
                    ),
                    outsideTextStyle: TextStyle(
                      color: Color(4289638062),
                      fontSize: 12
                    ),
                  )
                ),
              ),
              ReminderContent(reminderContent: _reminderContent),
            ]
          ),
        ),
        Positioned(
          bottom: 22,
          child: Container(
            width: SizeConfig.screenWidth,
            height: 45,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: TextButton(
              onPressed: (){
                if(!isSetEvent){
                  showTimePicker();
                }else{
                  resetEventAndSchedule();
                }
              }, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(!isSetEvent)
                  Image.asset(
                    icon['intake']!,
                    width: 40,
                  ),
                  Text(
                    // (!isSetEvent) ? '設定飲用提醒' : '取消',
                    (!isSetEvent) ? T.reminderSetBtnText : T.reminderCancelBtnText,
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                      letterSpacing: 2,
                    )
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.white
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  )
                )
              ),
            ),
          ),
        )
      ]
    );
  }
}

import 'package:anime_catalogue/models/db.dart';
import 'package:anime_catalogue/services/notif_services.dart';
import 'package:anime_catalogue/theme/theme_data.dart';
import 'package:anime_catalogue/views/detail_topanime.dart';
import 'package:anime_catalogue/views/detail_topmanga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:timezone/timezone.dart' as tz;

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late final NotificationApi notificationApi;
  DateTime scheduleTime = DateTime.now();

  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Bookmark> bookmarks = [];

  @override
  void initState() {
    notificationApi = NotificationApi();
    notificationApi.initApi();
    super.initState();
    refreshBookmarkList();
  }

  void refreshBookmarkList() {
    databaseHelper.listBookmark().then((list) {
      setState(() {
        bookmarks = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark List'),
      ),
      body: bookmarks.isEmpty
          ? const Center(
              child: Text('Tidak ada bookmark.'),
            )
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final Bookmark bookmark = bookmarks[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      showBookmarkDetailsDialog(bookmark);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 80.0, // Sesuaikan dengan kebutuhan Anda
                            height: 80.0, // Sesuaikan dengan kebutuhan Anda
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(bookmark.img),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookmark.title,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  bookmark.type,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteBookmark(bookmark);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void deleteBookmark(Bookmark bookmark) {
    databaseHelper.deleteBookmark(bookmark).then((_) {
      refreshBookmarkList();
    });
  }

  void showBookmarkDetailsDialog(Bookmark bookmark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detail Bookmark'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title: ${bookmark.title}'),
              Text('Type: ${bookmark.type}'),
              Text('Reminder: ${bookmark.reminderwaktu}'),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showReminderDialog(bookmark);
                    },
                    child: Text('Set Reminder'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Warna untuk "Set Reminder"
                      onPrimary: Colors.white, // Warna teks di atas tombol
                      padding: EdgeInsets.symmetric(horizontal: 16), // Sesuaikan ukuran horizontal
                    ),
                  ),
                  SizedBox(width: 8), // Spasi antara tombol
                  ElevatedButton(
                    onPressed: () {
                      databaseHelper.updateReminderWaktu(bookmark.malid);
                      notificationApi.cancelNotif(int.parse(bookmark.malid));
                      refreshBookmarkList();
                      Navigator.pop(context);
                    },
                    child: Text('Delete Reminder'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16), // Sesuaikan ukuran horizontal
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: warnaUngu,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            bookmark.type.toString() == 'Manga' ||
                                    bookmark.type.toString() == 'Light Novel'
                                ? DetailTopMangaScreenPage(id: bookmark.malid)
                                : DetailTopAnimeScreenPage(id: bookmark.malid),
                      ));
                },
                child: Text(
                  'Detail Page',
                  style: TextStyle(
                    color: Colors.white, // Warna teks
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showReminderDialog(Bookmark bookmark) {
    picker.DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        scheduleTime = date;
        print('confirm $scheduleTime');
        setState(() {
          Bookmark bookmarkupdate = Bookmark(
            malid: bookmark.malid,
            title: bookmark.title,
            img: bookmark.img,
            type: bookmark.type,
            reminderwaktu: scheduleTime.toString(),
          );
          tz.TZDateTime timeZoneDateTime =
              tz.TZDateTime.from(scheduleTime, tz.local);
          print(timeZoneDateTime);
          notificationApi.showScheduledNotification(
            id: int.parse(bookmark.malid),
            title: '${bookmark.title} Reminder',
            body: 'Time to Watch/Read! ${bookmark.title}',
            date: timeZoneDateTime,
            payload: "",
          );
          databaseHelper.updateBookmark(bookmarkupdate);
          refreshBookmarkList();
          Navigator.pop(context);
        });
      },
      currentTime: DateTime.now(),
    );
  }

// void showReminderDialog(Bookmark bookmark) {
//   DatePicker.showDatePicker(
//     context,
//     dateFormat: 'dd MMMM yyyy HH:mm',
//     onConfirm: (dateTime, List<int> index) {
//       setState(() {
//         Bookmark bookmarkupdate = Bookmark(
//           malid: bookmark.malid,
//           title: bookmark.title,
//           type: bookmark.type,
//           reminderwaktu: dateTime.toString(),
//         );
//         NotificationService().cancel(int.parse(bookmark.malid));
//         NotificationService().showScheduleNotification(
//           id: int.parse(bookmark.malid),
//           title: bookmark.title,
//           body: bookmark.type,
//           time: dateTime,
//           payload: 'test',
//         );
//
//         databaseHelper.updateBookmark(bookmarkupdate);
//         refreshBookmarkList();
//       });
//     },
//   );
// }
}

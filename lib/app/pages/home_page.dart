import 'dart:convert';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_drag_drop/app/utils/image_utils.dart';
import 'package:flutter_desktop_drag_drop/app/widgets/drop_area_widget.dart';
import 'package:flutter_desktop_drag_drop/app/widgets/toolbar_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:window_manager/window_manager.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/toast/overlay.dart';
import '../responsives/layout.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  //
    TextEditingController _controller = TextEditingController();
  bool hovering = false;

  //

  @override
  void onWindowFocus() {
    super.onWindowFocus();
    setState(() {});
  }

 
  List<XFile> droppedFiles = [];
 void _uploadFiles() async {
   setState(() {
      isloading = true;

    });

  if (droppedFiles.isEmpty) {
       setState(() {
      isloading = false;
      gagaltoaast();
    });
    return ; // Tidak ada file yang akan diunggah
  }

  final dio = Dio();
  final baseUrl =
      'http://simrs.onthewifi.com:1842/rsummi-api/SendHasilRadiologi'; // Ganti dengan endpoint API Anda

  List<String> results = [];

  try {
    for (var i = 0; i < droppedFiles.length; i++) {
      var file = droppedFiles[i];
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });

      final response = await dio.post('$baseUrl', data: formData);
      var data = jsonEncode(response.data);
      var z = jsonDecode(data);
      
      if (response.statusCode == 200 && z['metadata']['code'] == 200) {
        results.add('${file.name} - berhasil');
      } else {
        results.add('${file.name} - gagal');
      }
    }

  
    String message = '';
    for (var result in results) {
      message += '$result\n';
    }
    showDialog(
      context: context, // Pastikan Anda memiliki context yang sesuai
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hasil Pengunggahan'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
         setState(() {
                  droppedFiles.clear();
         });
                Navigator.of(context).pop(); 
              // Menutup dialog
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );

    // Mengosongkan daftar file yang diunggah jika diperlukan
    setState(() {
      isloading = false;
    });

    // Memanggil fungsi sccshtoast() jika diperlukan
    sccshtoast();
  } catch (e) {
    setState(() {
      isloading = false;
    });
    print('Error mengunggah file: $e');
  }
}




  bool _isValidNumber(String value) {
    if (value.isEmpty) {
      return true; // Biarkan kosong jika Anda inginkan
    }
    final numericRegex = RegExp(r'^-?[0-9]+$');
    return numericRegex.hasMatch(value);
  }
  bool _isInputValid = true;
    void _showPopupModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();
        bool _isInputValid = true;

        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
              onWillPop: (){},
              child: AlertDialog(
                title: Text('Pengiriman Berkas'),
                content: SizedBox(
                  height: 150,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Masukan Norekam Pasien'),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                              setState(() {
                              _isInputValid = _isValidNumber(value);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "contoh: 123424",
                            labelText: "Norekam",
                            errorText: _isInputValid ? null : "Input tidak valid",
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Tutup'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_isInputValid) {
                        // Lakukan tindakan yang diperlukan dengan input yang valid
                        Navigator.of(context).pop();
                                       check();
                      }
                    },
                    child: Text('Cari'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

 void _removePath(int index) {
    setState(() {
      droppedFiles.removeAt(index);
    });
  }
void _showPopupModal2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();
        bool _isInputValid = true;

        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
              onWillPop: (){},
              child: AlertDialog(
                title: Text('Informasi Penerima Berkas'),
                content: SizedBox(
                  height: 150,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama : Bagus Andre Wijaya'),
                      Text('Norekam : 5210223'),
                      Text('Jenis Kelamin : Laki-Laki'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Batal Kirim'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_isInputValid) {
                        // Lakukan tindakan yang diperlukan dengan input yang valid
                        Navigator.of(context).pop();
                                 check2();
                      }
                    },
                    child: Text('Kirim'),
                  ),
                     TextButton(
                    onPressed: () {
                      if (_isInputValid) {
                        // Lakukan tindakan yang diperlukan dengan input yang valid
                        Navigator.of(context).pop();
                                 _showPopupModal(context);
                                    
                      }
                    },
                    child: Text('Cari Ulang'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
bool isloading = false;
 
void check() async {
setState(() {
  isloading = true;
});
 
Future.delayed(Duration(seconds: 3)).then( (value ){
  setState(() {
  isloading = false;
  _showPopupModal2(context);
   
});
});
}


void check2() async {
setState(() {
  isloading = true;
});
     _uploadFiles();

}


@override
Widget build(BuildContext context) {
  SizeConfig().init(context);
  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      children: [
        const ToolbarWidget(
          title: 'Radiologi Sender',
        ),
        Expanded(
          child: Stack(
              children: [
                 droppedFiles.isEmpty ? SizedBox() : Positioned(
                    right: 20,
                    top: 60,
                    child: GestureDetector(
                      onTap: () {
                         _showPopupModal(context);
                      },
                      child: Container(
                        
                        width: 150,height: 50,
                                      decoration: BoxDecoration(
                          color: Color(0xff2e4786),
                          borderRadius: BorderRadius.circular(8)
                                      ),
                    child: Center(child: 
                    Text("Kirim",style: TextStyle(
                      fontSize: 20
                    ),),),
                      ),
                    )
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kirim Hasil Radiologi',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Color(0xff2e4786)),
                      ),
                      Text(
                        'MP4, JPG, PNG, JPEG',
                        style: TextStyle(
                          color: Color(0xff2e4786),
                          fontSize: 16,
                        ),
                      ),
                  
                      const SizedBox(height: 16),
                      Expanded(
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: !isloading ? DropAreaWidget(
                                onFiles: (files) {
                                  for (var file in files) {
                                    if (!droppedFiles.any((element) => element.path == file.path)) {
                                      droppedFiles.add(file);
                                    }
                                  }
                                  setState(() {});
                                },
                              ) : Stack(
                                children: [
                                  AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:  Colors.white10,
                border: Border.all(
                  color:Color(0xff2e4786),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(FontAwesomeIcons.ban, size: 96,color: Colors.grey,),
                  const SizedBox(height: 8),
                  Text('Tidak Bisa Upload',
                      style: TextStyle(
                        color:Colors.black
                      )),
                ],
              ),
            )
                                ],
                              ) ,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Files',
                                        style: TextStyle(color: Colors.black, fontSize: 22),
                                      ),
                                      if (droppedFiles.isNotEmpty)
                                        TextButton(
                                          onPressed: () {
                                            droppedFiles.clear();
                                            setState(() {});
                                          },
                                          child: const Text('Hapus Semua',style: TextStyle(
                                            color:  Color.fromARGB(255, 250, 127, 119),
                                          fontSize: 18
                                          ),),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: droppedFiles.length,
                                      separatorBuilder: (context, index) => const SizedBox(height: 4),
                                      itemBuilder: (context, index) => ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        onTap: () {},
                                        leading: Image.asset(
                                          ImageUtils.imgeByMimeType(droppedFiles[index].path),
                                          width: 50,
                                          height: 50,
                                        ),
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              droppedFiles[index].name,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _removePath(index);
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.trashCan,color: Color.fromARGB(255, 250, 127, 119),
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               isloading ?  // Indicator Progress di tengah layar
                Center(
                  child:  SpinKitFadingCircle(
    color: Color(0xff2e4786),
    size: 90.0,
    ),
                ):  SizedBox(),
                // Blur background saat Indicator muncul
                  isloading ?    Opacity(
                  opacity: 0.5,
                  child: Container(
                    color: Colors.grey,
                  ),
                ) : SizedBox(),
              ],
            )
        ),
      ],
    ),
  );
}


void sccshtoast(){
  ScaffoldMessenger.of(context).showSnackBar(
                            
                            SnackBar(
                              
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.fixed,
                              backgroundColor: Colors.green,
                              elevation: 0,
                              content: Container(
                           
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                              
                                  borderRadius: BorderRadius.circular(20)

                                ),

child: 
Column(
  crossAxisAlignment: CrossAxisAlignment.start,

  children: [
    Text(
      "Berhasil!",style: TextStyle(
        color: Colors.white,fontSize: 18
      ),
    ),
     Text(
      "Berhasi mengirim gambar ke pasien!",style: TextStyle(
        color: Colors.white,fontSize: 20
      ),
    )
  ],
),                              ))
                          );
}



void gagaltoaast(){
  ScaffoldMessenger.of(context).showSnackBar(
                            
                            SnackBar(
                              
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.fixed,
                              backgroundColor: Color.fromARGB(255, 175, 76, 76),
                              elevation: 0,
                              content: Container(
                           
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                              
                                  borderRadius: BorderRadius.circular(20)

                                ),

child: 
Column(
  crossAxisAlignment: CrossAxisAlignment.start,

  children: [
    Text(
      "Gagal!",style: TextStyle(
        color: Colors.white,fontSize: 18
      ),
    ),
     Text(
      "Gagal mengirim gambar ke pasien!",style: TextStyle(
        color: Colors.white,fontSize: 20
      ),
    )
  ],
),                              ))
                          );
}
}
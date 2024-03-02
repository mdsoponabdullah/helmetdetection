import 'package:flutter/material.dart';

import '../color/parse_color.dart';

class BangladeshPlaces extends StatefulWidget {
  final Function(String,String,String) callback;
  const BangladeshPlaces({Key? key, required this.callback}) : super(key: key);

  @override
  _BangladeshPlacesState createState() => _BangladeshPlacesState();
}

class _BangladeshPlacesState extends State<BangladeshPlaces> {
  Map<String, Map<String, List<String>>> placesInBangladesh = {
    'Barisal': {
      'Barguna': [
        'Amtali',
        'Bamna',
        'Barguna Sadar',
        'Betagi',
        'Patharghata',
        'Taltali'
      ],
      'Barisal': [
        'Agailjhara',
        'Babuganj',
        'Bakerganj',
        'Banaripara',
        'Gaurnadi',
        'Hizla',
        'Barishal Sadar',
        'Mehendiganj',
        'Muladi',
        'Wazirpur'
      ],
      'Bhola': [
        'Bhola Sadar',
        'Burhanuddin',
        'Char Fasson',
        'Daulatkhan',
        'Lalmohan',
        'Manpura',
        'Tazumuddin'
      ],
      'Jhalokati': ['Jhalokati Sadar', 'Kathalia', 'Nalchity', 'Rajapur'],
      'Patuakhali': [
        'Bauphal',
        'Dashmina',
        'Galachipa',
        'Kalapara',
        'Mirzaganj',
        'Patuakhali Sadar',
        'Rangabali',
        'Dumki'
      ],
      'Pirojpur': [
        'Bhandaria',
        'Kawkhali',
        'Mathbaria',
        'Nazirpur',
        'Pirojpur Sadar',
        'Nesarabad (Swarupkati)',
        'Zianagar'
      ],
    },
    'Chittagong': {
      'Bandarban': [
        'Ali Kadam',
        'Bandarban Sadar',
        'Lama',
        'Naikhongchhari',
        'Rowangchhari',
        'Ruma',
        'Thanchi'
      ],
      'Brahmanbaria': [
        'Akhaura',
        'Bancharampur',
        'Brahmanbaria Sadar',
        'Kasba',
        'Nabinagar',
        'Nasirnagar',
        'Sarail',
        'Ashuganj',
        'Bijoynagar'
      ],
      'Chandpur': [
        'Chandpur Sadar',
        'Faridganj',
        'Haimchar',
        'Haziganj',
        'Kachua',
        'Matlab Dakshin',
        'Matlab Uttar',
        'Shahrasti'
      ],
      'Chittagong': [
        'Anwara',
        'Banshkhali',
        'Boalkhali',
        'Chandanaish',
        'Fatikchhari',
        'Hathazari',
        'Karnaphuli',
        'Lohagara',
        'Mirsharai',
        'Patiya',
        'Rangunia',
        'Raozan',
        'Sandwip',
        'Satkania',
        'Sitakunda',
        'Bandar Thana',
        'Chandgaon Thana',
        'Double Mooring Thana',
        'Kotwali Thana',
        'Pahartali Thana',
        'Panchlaish Thana',
        'Bhujpur Thana'
      ],
      'Comilla': [
        'Barura',
        'Brahmanpara',
        'Burichang',
        'Chandina',
        'Chauddagram',
        'Daudkandi',
        'Debidwar',
        'Homna',
        'Laksam',
        'Muradnagar',
        'Nangalkot',
        'Cumilla Adarsha Sadar',
        'Meghna',
        'Titas',
        'Monohargonj',
        'Cumilla Sadar Dakshin'
      ],
      'Cox\'s Bazar': [
        'Chakaria',
        'Cox\'s Bazar Sadar',
        'Kutubdia',
        'Maheshkhali',
        'Ramu',
        'Teknaf',
        'Ukhia',
        'Pekua'
      ],
      'Feni': [
        'Chhagalnaiya',
        'Daganbhuiyan',
        'Feni Sadar',
        'Parshuram',
        'Sonagazi',
        'Fulgazi'
      ],
      'Khagrachhari': [
        'Dighinala',
        'Khagrachhari',
        'Lakshmichhari',
        'Mahalchhari',
        'Manikchhari',
        'Matiranga',
        'Panchhari',
        'Ramgarh'
      ],
      'Lakshmipur': [
        'Lakshmipur Sadar',
        'Raipur',
        'Ramganj',
        'Ramgati',
        'Kamalnagar'
      ],
      'Noakhali': [
        'Begumganj',
        'Noakhali Sadar',
        'Chatkhil',
        'Companiganj',
        'Hatiya',
        'Senbagh',
        'Sonaimuri',
        'Subarnachar',
        'Kabirhat'
      ],
      'Rangamati': [
        'Bagaichhari',
        'Barkal',
        'Kawkhali (Betbunia)',
        'Belaichhari',
        'Kaptai',
        'Juraichhari',
        'Langadu',
        'Naniyachar',
        'Rajasthali',
        'Rangamati Sadar'
      ],
    },
    'Dhaka': {
      'Dhaka': [
        'Dhamrai',
        'Dohar',
        'Keraniganj',
        'Nawabganj',
        'Savar',
        'Tejgaon Circle'
      ],
      'Faridpur': [
        'Alfadanga',
        'Bhanga',
        'Boalmari',
        'Charbhadrasan',
        'Faridpur Sadar',
        'Madhukhali',
        'Nagarkanda',
        'Sadarpur',
        'Saltha'
      ],
      'Gazipur': [
        'Gazipur Sadar',
        'Kaliakair',
        'Kaliganj',
        'Kapasia',
        'Sreepur'
      ],
      'Gopalganj': [
        'Gopalganj Sadar',
        'Kashiani',
        'Kotalipara',
        'Muksudpur',
        'Tungipara'
      ],
      'Kishoreganj': [
        'Austagram',
        'Bajitpur',
        'Bhairab',
        'Hossainpur',
        'Itna',
        'Karimganj',
        'Katiadi',
        'Kishoreganj Sadar',
        'Kuliarchar',
        'Mithamain',
        'Nikli',
        'Pakundia'
      ],
      'Madaripur': ['Rajoir', 'Madaripur Sadar', 'Kalkini', 'Shibchar'],
      'Manikganj': [
        'Daulatpur',
        'Ghior',
        'Harirampur',
        'Manikgonj Sadar',
        'Saturia',
        'Shivalaya',
        'Singair'
      ],
      'Munshiganj': [
        'Gazaria',
        'Lohajang',
        'Munshiganj Sadar',
        'Sirajdikhan',
        'Sreenagar',
        'Tongibari'
      ],
      'Narayanganj': [
        'Araihazar',
        'Bandar',
        'Narayanganj Sadar',
        'Rupganj',
        'Sonargaon'
      ],
      'Narsingdi': [
        'Narsingdi Sadar',
        'Belabo',
        'Monohardi',
        'Palash',
        'Raipura',
        'Shibpur'
      ],
      'Rajbari': [
        'Baliakandi',
        'Goalandaghat',
        'Pangsha',
        'Rajbari Sadar',
        'Kalukhali'
      ],
      'Shariatpur': [
        'Bhedarganj',
        'Damudya',
        'Gosairhat',
        'Naria',
        'Shariatpur Sadar',
        'Zajira',
        'Shakhipur'
      ],
      'Tangail': [
        'Gopalpur',
        'Basail',
        'Bhuapur',
        'Delduar',
        'Ghatail',
        'Kalihati',
        'Madhupur',
        'Mirzapur',
        'Nagarpur',
        'Sakhipur',
        'Dhanbari',
        'Tangail Sadar'
      ],
    },
    'Khulna': {
      'Bagerhat': [
        'Bagerhat Sadar',
        'Chitalmari',
        'Fakirhat',
        'Kachua',
        'Mollahat',
        'Mongla',
        'Morrelganj',
        'Rampal',
        'Sarankhola'
      ],
      'Chuadanga': ['Alamdanga', 'Chuadanga Sadar', 'Damurhuda', 'Jibannagar'],
      'Jessore': [
        'Abhaynagar',
        'Bagherpara',
        'Chaugachha',
        'Jhikargachha',
        'Keshabpur',
        'Jashore Sadar',
        'Manirampur',
        'Sharsha'
      ],
      'Jhenaidah': [
        'Harinakunda',
        'Jhenaidah Sadar',
        'Kaliganj',
        'Kotchandpur',
        'Maheshpur',
        'Shailkupa'
      ],
      'Khulna': [
        'Batiaghata',
        'Dacope',
        'Dumuria',
        'Dighalia',
        'Koyra',
        'Paikgachha',
        'Phultala',
        'Rupsha',
        'Terokhada',
        'Daulatpur Thana',
        'Khalishpur Thana',
        'Khan Jahan Ali Thana',
        'Kotwali Thana',
        'Sonadanga Thana',
        'Harintana Thana'
      ],
      'Kushtia': [
        'Bheramara',
        'Daulatpur',
        'Khoksa',
        'Kumarkhali',
        'Kushtia Sadar',
        'Mirpur'
      ],
      'Magura': ['Magura Sadar', 'Mohammadpur', 'Shalikha', 'Sreepur'],
      'Meherpur': ['Gangni', 'Meherpur Sadar', 'Mujibnagar'],
      'Narail': ['Kalia', 'Lohagara', 'Narail Sadar', 'Naragati Thana'],
      'Satkhira': [
        'Assasuni',
        'Debhata',
        'Kalaroa',
        'Kaliganj',
        'Satkhira Sadar',
        'Shyamnagar',
        'Tala'
      ],
    },
    'Mymensingh': {
      'Jamalpur': [
        'Baksiganj',
        'Dewanganj',
        'Islampur',
        'Jamalpur Sadar',
        'Madarganj',
        'Melandaha',
        'Sarishabari'
      ],
      'Mymensingh': [
        'Trishal',
        'Dhobaura',
        'Fulbaria',
        'Gaffargaon',
        'Gauripur',
        'Haluaghat',
        'Ishwarganj',
        'Mymensingh Sadar',
        'Muktagachha',
        'Nandail',
        'Phulpur',
        'Bhaluka',
        'Tara Khanda'
      ],
      'Netrakona': [
        'Atpara',
        'Barhatta',
        'Durgapur',
        'Khaliajuri',
        'Kalmakanda',
        'Kendua',
        'Madan',
        'Mohanganj',
        'Netrokona Sadar',
        'Purbadhala'
      ],
      'Sherpur': [
        'Jhenaigati',
        'Nakla',
        'Nalitabari',
        'Sherpur Sadar',
        'Sreebardi'
      ],
    },
    'Rajshahi': {
      'Bogra': [
        'Adamdighi',
        'Bogura Sadar',
        'Dhunat',
        'Dhupchanchia',
        'Gabtali',
        'Kahaloo',
        'Nandigram',
        'Sariakandi',
        'Shajahanpur',
        'Sherpur',
        'Shibganj',
        'Sonatola'
      ],
      'Chapainawabganj': [
        'Bholahat',
        'Gomastapur',
        'Nachole',
        'Nawabganj Sadar',
        'Shibganj'
      ],
      'Joypurhat': [
        'Akkelpur',
        'Joypurhat Sadar',
        'Kalai',
        'Khetlal',
        'Panchbibi'
      ],
      'Naogaon': [
        'Atrai',
        'Badalgachhi',
        'Manda',
        'Dhamoirhat',
        'Mohadevpur',
        'Naogaon Sadar',
        'Niamatpur',
        'Patnitala',
        'Porsha',
        'Raninagar',
        'Sapahar'
      ],
      'Natore': [
        'Bagatipara',
        'Baraigram',
        'Gurudaspur',
        'Lalpur',
        'Natore Sadar',
        'Singra',
        'Naldanga'
      ],
      'Pabna': [
        'Atgharia',
        'Bera',
        'Bhangura',
        'Chatmohar',
        'Faridpur',
        'Ishwardi',
        'Pabna Sadar',
        'Santhia',
        'Sujanagar'
      ],
      'Rajshahi': [
        'Bagha',
        'Bagmara',
        'Charghat',
        'Durgapur',
        'Godagari',
        'Mohanpur',
        'Paba',
        'Puthia',
        'Tanore'
      ],
      'Sirajganj': [
        'Belkuchi',
        'Chauhali',
        'Kamarkhanda',
        'Kazipur',
        'Raiganj',
        'Shahjadpur',
        'Sirajganj Sadar',
        'Tarash',
        'Ullahpara'
      ],
    },
    'Rangpur': {
      'Dinajpur': [
        'Birampur',
        'Birganj',
        'Biral',
        'Bochaganj',
        'Chirirbandar',
        'Phulbari',
        'Ghoraghat',
        'Hakimpur',
        'Kaharole',
        'Khansama',
        'Dinajpur Sadar',
        'Nawabganj',
        'Parbatipur'
      ],
      'Gaibandha': [
        'Phulchhari',
        'Gaibandha Sadar',
        'Gobindaganj',
        'Palashbari',
        'Sadullapur',
        'Sughatta',
        'Sundarganj'
      ],
      'Kurigram': [
        'Bhurungamari',
        'Char Rajibpur',
        'Chilmari',
        'Phulbari',
        'Kurigram Sadar',
        'Nageshwari',
        'Rajarhat',
        'Raomari',
        'Ulipur'
      ],
      'Lalmonirhat': [
        'Aditmari',
        'Hatibandha',
        'Kalachandpur',
        'Lalmonirhat Sadar',
        'Patgram'
      ],
      'Nilphamari': [
        'Dimla',
        'Domar',
        'Jaldhaka',
        'Kishoreganj',
        'Nilphamari Sadar',
        'Saidpur'
      ],
      'Panchagarh': [
        'Atwari',
        'Boda',
        'Debiganj',
        'Panchagarh Sadar',
        'Tetulia'
      ],
      'Rangpur': [
        'Badarganj',
        'Gangachara',
        'Kaunia',
        'Mithapukur',
        'Pirgachha',
        'Pirganj',
        'Rangpur Sadar',
        'Taraganj'
      ],
      'Thakurgaon': [
        'Baliadangi',
        'Haripur',
        'Pirganj',
        'Ranisankail',
        'Thakurgaon Sadar'
      ],
    },
    'Sylhet': {
      'Habiganj': [
        'Azmireeganj',
        'Bahubal',
        'Baniachang',
        'Chunarughat',
        'Habiganj Sadar',
        'Lakhai',
        'Madhabpur',
        'Nabiganj'
      ],
      'Moulvibazar': [
        'Barlekha',
        'Juri',
        'Kamalganj',
        'Kulaura',
        'Moulvibazar Sadar',
        'Rajnagar',
        'Sreemangal'
      ],
      'Sunamganj': [
        'Bishwambarpur',
        'Chhatak',
        'Dakshin Sunamganj',
        'Derai',
        'Dharampasha',
        'Dowarabazar',
        'Jagannathpur',
        'Jamalganj',
        'Sachna'
      ],
      'Sylhet': [
        'Balaganj',
        'Beanibazar',
        'Bishwanath',
        'Companiganj',
        'Fenchuganj',
        'Golapganj',
        'Gowainghat',
        'Jaintiapur',
        'Kanaighat',
        'Zakiganj',
        'South Surma',
        'Sylhet Sadar'
      ],
    },
  };
  String? selectedCategory;
  String? selectedSubcategory;
  String? selectedSubSubcategory;
  @override
  Widget build(BuildContext context) {

    widget.callback(selectedCategory??"",selectedSubcategory??"",selectedSubcategory??"");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: ParseColor.parseColor("#E7DFEC"),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InputDecorator(
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.location_on,
                color: Colors.black45,
                size: 40,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                style: const TextStyle(fontSize: 15, color: Colors.black45),
                value: selectedCategory,
                hint: const Text('Select Division'),
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value!;
                    selectedSubcategory =
                        null; // Reset subcategory on category change
                    selectedSubSubcategory =
                        null; // Reset subsubcategory on category change
                  });
                },
                items: placesInBangladesh.keys.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        selectedCategory != null? SizedBox(height: 30):SizedBox(),
        selectedCategory != null
            ? Container(
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: ParseColor.parseColor("#E7DFEC"),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.black45,
                      size: 40,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black45),
                      value: selectedSubcategory,
                      hint: const Text('Select District'),
                      onChanged: (String? value) {
                        setState(() {
                          selectedSubcategory = value!;
                          selectedSubSubcategory =
                              null; // Reset subsubcategory on subcategory change
                        });
                      },
                      items: selectedCategory != null
                          ? placesInBangladesh[selectedCategory]!
                              .keys
                              .map((String subcategory) {
                              return DropdownMenuItem<String>(
                                value: subcategory,
                                child: Text(subcategory),
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                ),
              )
            : SizedBox(),
        selectedCategory != null? SizedBox(height: 30):SizedBox(),
        selectedSubcategory != null
            ? Container(
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: ParseColor.parseColor("#E7DFEC"),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.black45,
                      size: 40,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black45),
                      value: selectedSubSubcategory,
                      hint: const Text('Select Upozela'),
                      onChanged: (String? value) {
                        setState(() {
                          selectedSubSubcategory = value!;
                        });
                      },
                      items: selectedCategory != null &&
                              selectedSubcategory != null
                          ? placesInBangladesh[selectedCategory]![
                                  selectedSubcategory]!
                              .map((String subsubcategory) {
                              return DropdownMenuItem<String>(
                                value: subsubcategory,
                                child: Text(subsubcategory),
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

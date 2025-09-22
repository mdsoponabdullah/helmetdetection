import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class CucumberInfoPage extends StatefulWidget {
  const CucumberInfoPage({super.key});

  static const String routeName = '/CucumberInfoPage';

  @override
  State<CucumberInfoPage> createState() => _CucumberInfoPageState();
}

class _CucumberInfoPageState extends State<CucumberInfoPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 12, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 220,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  '',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green[900]!,
                        Colors.green[700]!,
                        Colors.green[500]!,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(Icons.eco, size: 200, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(Icons.agriculture, size: 150, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildConditionalImage(
                              'assets/cucumber.png',
                              width: 150,
                              height: 100,
                              fallback: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.eco,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Cucumis ',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.3),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.8),
                tabs: const [
                  Tab(icon: Icon(Icons.info, size: 20), text: 'Overview'),
                  Tab(icon: Icon(Icons.nature, size: 20), text: 'Botany'),
                  Tab(icon: Icon(Icons.agriculture, size: 20), text: 'Varieties'),
                  Tab(icon: Icon(Icons.psychology, size: 20), text: 'Cultivation'),
                  Tab(icon: Icon(Icons.eco, size: 20), text: 'Propagation'),
                  Tab(icon: Icon(Icons.shopping_basket, size: 20), text: 'Harvesting'),
                  Tab(icon: Icon(Icons.restaurant, size: 20), text: 'Nutrition'),
                  Tab(icon: Icon(Icons.favorite, size: 20), text: 'Health'),
                  Tab(icon: Icon(Icons.menu_book, size: 20), text: 'Recipes'),
                  Tab(icon: Icon(Icons.health_and_safety, size: 20), text: 'Diseases'),
                  Tab(icon: Icon(Icons.bug_report, size: 20), text: 'Pests'),
                  Tab(icon: Icon(Icons.history, size: 20), text: 'History'),
                ],
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green[50]!,
                Colors.green[100]!,
              ],
            ),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(),
              _buildBotanyTab(),
              _buildVarietiesTab(),
              _buildCultivationTab(),
              _buildPropagationTab(),
              _buildHarvestingTab(),
              _buildNutritionTab(),
              _buildHealthTab(),
              _buildRecipesTab(),
              _buildDiseasesTab(),
              _buildPestsTab(),
              _buildHistoryTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConditionalImage(String imagePath, {
    double width = double.infinity,
    double height = 200,
    Widget? fallback,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        // Return nothing if image is unavailable
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContentCard(String title, String content, String imagePath, {IconData? icon, Color? accentColor}) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              (accentColor ?? Colors.green[100])!.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentColor ?? Colors.green[600],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon ?? Icons.eco,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.green[900],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                  color: accentColor ?? Colors.green[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              
              // Conditional Image - shows only if available
              _buildConditionalImage(
                imagePath,
                height: 200,
              ),
              
              const SizedBox(height: 20),
              SelectableText(
                content,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  height: 1.7,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TAB 1: OVERVIEW
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '🌿 Complete Cucumber Overview',
        '''
Cucumber (Cucumis sativus) is one of the most widely cultivated crops globally, belonging to the Cucurbitaceae family alongside melons, squash, and pumpkins. This annual vine has been domesticated for over 3,000 years and continues to be a staple in diets worldwide.

🌟 Global Significance:
• Fourth most widely cultivated vegetable globally
• Annual production exceeds 90 million metric tons
• China leads production with over 60% of world output
• Grown in over 130 countries worldwide

💼 Economic Importance:
• Multi-billion dollar global industry
• Major export crop for many developing countries
• Supports millions of small-scale farmers
• Significant processing industry for pickles

This versatile crop continues to evolve with new varieties being developed for specific climates, tastes, and growing methods, ensuring its place as a vital food source for future generations.
''',
        'assets/images/cucumber_plant.jpg',
        icon: Icons.public,
        accentColor: Colors.blue[600],
      ),
    );
  }

  // TAB 2: BOTANY
  Widget _buildBotanyTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '🔬 Botanical Characteristics',
        '''
Cucumber plants exhibit distinct botanical features that make them unique among cultivated plants:

📊 Taxonomic Classification:
Kingdom: Plantae | Order: Cucurbitales
Family: Cucurbitaceae | Genus: Cucumis
Species: C. sativus

🌿 Plant Morphology:
• Root System: Shallow, fibrous roots extending 30-60 cm deep
• Stem: Angular, hairy, climbing or trailing vines
• Leaves: Palmately lobed with 3-7 pointed lobes
• Petioles: Long, hairy, containing vascular bundles

🌸 Floral Biology:
• Flower Type: Monoecious with separate male and female flowers
• Male Flowers: Appear first, in clusters of 5-15
• Female Flowers: Solitary, with inferior ovary
• Pollination: Entomophilous (insect-pollinated)

🍈 Fruit Development:
• Fruit Type: Pepo, a type of berry with hard rind
• Development: Parthenocarpic varieties available
• Seed Development: Requires pollination in standard varieties
• Color Changes: Immature green to mature yellow

Understanding these botanical characteristics is crucial for effective cultivation and breeding of cucumber varieties.
''',
        'assets/images/cucumber_flower.jpg',
        icon: Icons.science,
        accentColor: Colors.purple[600],
      ),
    );
  }

  // TAB 3: VARIETIES
  Widget _buildVarietiesTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '🌱 Cucumber Varieties and Types',
        '''
Cucumbers exhibit remarkable diversity with hundreds of varieties developed for specific purposes:

🥒 Slicing Cucumbers:
• Long, smooth fruits for fresh consumption
• Thin skin, minimal seeds, crisp texture
• Examples: Marketmore, Straight Eight, Diva
• Typical length: 20-30 cm

🥫 Pickling Cucumbers:
• Shorter, blocky fruits with firm flesh
• Thicker skin, higher dry matter content
• Examples: National Pickling, Boston Pickling
• Ideal length: 8-15 cm

😌 Burpless Varieties:
• Reduced cucurbitacin content
• Easier digestion, milder flavor
• Examples: Sweet Success, Tasty Green
• Seedless or thin-skinned types

🎯 Specialty Varieties:
• Lemon Cucumbers: Round, yellow, mild flavor
• Armenian Cucumbers: Ribbed, very long fruits
• Japanese Cucumbers: Slim, dark green, sweet

The continuous breeding efforts ensure availability of varieties suitable for every climate and growing method.
''',
        'assets/images/cucumber_varieties.jpg',
        icon: Icons.agriculture,
        accentColor: Colors.orange[600],
      ),
    );
  }

  // TAB 4: CULTIVATION
  Widget _buildCultivationTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '🌾 Advanced Cultivation Techniques',
        '''
Modern cucumber cultivation employs sophisticated techniques for optimal yield and quality:

🌱 Soil Management:
• Deep plowing to 30-40 cm depth
• Soil solarization for disease control
• pH adjustment to 6.0-6.8 range
• Organic matter incorporation

💧 Water Management:
• Drip irrigation for water efficiency
• Moisture sensors for precision watering
• Mulching to reduce evaporation
• Rainwater harvesting systems

🌿 Training Systems:
• Vertical trellising for better light exposure
• Pruning for optimal fruit production
• Espalier training for small spaces
• Overhead netting for support

🏡 Protected Cultivation:
• Greenhouse production for year-round supply
• Hydroponic systems for controlled environment
• Shade netting for heat protection
• Polyhouse cultivation for early crops

These advanced techniques enable growers to achieve higher yields and better quality.
''',

        'assets/images/cucumber_cultivation.jpg',
        icon: Icons.engineering,
        accentColor: Colors.teal[600],
      ),
    );
  }

  // TAB 5: PROPAGATION
  Widget _buildPropagationTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '🌱 Propagation Methods and Techniques',
        '''
Cucumber propagation involves both traditional and modern methods:

🌱 Seed Propagation:
• Seed viability: 5-8 years under proper storage
• Germination temperature: 20-30°C optimal
• Pre-soaking seeds for 12-24 hours
• Seed treatment with fungicides and bio-agents

🏡 Nursery Management:
• Raised seed beds with proper drainage
• Soil sterilization for disease prevention
• Optimal spacing: 5x5 cm between seedlings
• Hardening off before transplanting

🔬 Grafting Techniques:
• Rootstocks: Bottle gourd, squash, resistant varieties
• Methods: Tongue approach, cleft grafting
• Success rate: 85-95% under controlled conditions
• Benefits: Disease resistance, vigor improvement

Advanced propagation techniques ensure healthy, vigorous plants with desired genetic characteristics.
''',
        'assets/images/cucumber_seedlings.jpg',
        icon: Icons.eco,
        accentColor: Colors.lightGreen[600],
      ),
    );
  }

  // TAB 6: HARVESTING
  Widget _buildHarvestingTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '📦 Harvesting and Post-Harvest Management',
        '''
Proper harvesting and handling are crucial for maintaining cucumber quality:

🎯 Harvesting Indicators:
• Fruit size: Variety-specific optimal length
• Color: Uniform dark green for most varieties
• Firmness: Firm to touch, not soft
• Spine condition: Soft, easily removable spines

⚡ Harvesting Techniques:
• Manual harvesting for fresh market
• Mechanical harvesters for processing
• Harvesting in early morning for better quality
• Using sharp knives to avoid vine damage

📦 Post-Harvest Handling:
• Immediate cooling to 10-12°C
• Proper packaging to prevent bruising
• Humidity maintenance at 90-95%

🌡️ Storage Conditions:
• Temperature: 10-12°C for 10-14 days
• Relative humidity: 90-95%
• Chilling injury below 7°C

Proper post-harvest management ensures cucumbers reach consumers with optimal quality.
''',
        'assets/images/cucumber_harvest.jpg',
        icon: Icons.shopping_basket,
        accentColor: Colors.amber[600],
      ),
    );
  }

  // TAB 7: NUTRITION
  Widget _buildNutritionTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '🍎 Nutritional Composition and Value',
        '''
Cucumbers are nutritionally dense despite their high water content:

📊 Macronutrient Profile (per 100g fresh weight):
• Water Content: 95.23g
• Energy: 15 kcal
• Protein: 0.65g
• Carbohydrate: 3.63g
• Fiber: 0.5g
• Sugars: 1.67g

💊 Vitamin Content:
• Vitamin K: 16.4μg (20% RDI)
• Vitamin C: 2.8mg (5% RDI)
• Vitamin A: 105 IU (2% RDI)

⚡ Mineral Content:
• Potassium: 147mg (4% RDI)
• Magnesium: 13mg (3% RDI)
• Calcium: 16mg (2% RDI)

🌟 Nutritional Benefits:
• Excellent hydration due to high water content
• Low calorie density for weight management
• Dietary fiber for digestive health
• Electrolyte balance maintenance

Cucumbers provide significant nutritional benefits while being low in calories.
''',
        'assets/images/cucumber_nutrition.jpg',
        icon: Icons.restaurant,
        accentColor: Colors.red[600],
      ),
    );
  }

  // TAB 8: HEALTH
  Widget _buildHealthTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '❤️ Health Benefits and Medicinal Uses',
        '''
Cucumbers offer numerous health benefits supported by scientific research:

💧 Hydration and Detoxification:
• 95% water content promotes optimal hydration
• Natural diuretic properties aid detoxification
• Electrolyte balance maintenance

🌡️ Anti-inflammatory Properties:
• Cucurbitacins inhibit inflammatory pathways
• Reduces swelling and inflammation
• Beneficial for arthritis sufferers

🛡️ Antioxidant Effects:
• Contains antioxidants like beta-carotene
• Fights free radical damage
• Anti-aging properties

🎗️ Cancer Prevention:
• Cucurbitacins show anti-cancer activity
• Lignans reduce hormone-related cancer risk
• Antioxidants prevent DNA damage

❤️ Cardiovascular Health:
• Potassium regulates blood pressure
• Fiber reduces cholesterol levels
• Low sodium content benefits hypertension

Scientific evidence continues to support the traditional uses of cucumbers.
''',
        'assets/images/cucumber_health.jpg',
        icon: Icons.favorite,
        accentColor: Colors.pink[600],
      ),
    );
  }

  // TAB 9: RECIPES
  Widget _buildRecipesTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '🍽️ Culinary Uses and Recipes',
        '''
Cucumbers are incredibly versatile in culinary applications worldwide:

🥗 Fresh Preparations:
• Salads: Greek salad, cucumber tomato salad
• Sandwiches: Tea sandwiches, club sandwiches
• Appetizers: Cucumber canapés, sushi rolls
• Beverages: Cucumber water, smoothies

🌍 International Cuisine:
• Mediterranean: Tzatziki, Greek salad
• Asian: Sunomono, kimchi, summer rolls
• Middle Eastern: Fattoush, tabbouleh
• European: Gazpacho, cucumber soup

🥒 Pickling Recipes:
• Quick Pickles: Refrigerator pickles
• Fermented: Traditional dill pickles
• Sweet Pickles: Bread and butter pickles
• Spicy Pickles: Hot and sour pickles

🍳 Cooked Dishes:
• Stir-fries: Cucumber retains crispness
• Soups: Chilled cucumber soup
• Curries: Cucumber curry preparations

Cucumbers adapt to virtually any cuisine, offering freshness and hydration.
''',
        'assets/images/cucumber_recipes.jpg',
        icon: Icons.menu_book,
        accentColor: Colors.brown[600],
      ),
    );
  }

  // TAB 10: DISEASES
  Widget _buildDiseasesTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.red[50]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[600],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.health_and_safety, size: 24, color: Colors.white),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '🛡️ Comprehensive Disease Management',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.red[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Conditional Disease Image
                    _buildConditionalImage(
                      'assets/images/cucumber_diseases.jpg',
                      height: 200,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    _buildDiseaseCategory(
                      '🍄 Fungal Diseases',
                      [
                        _buildDiseaseItem('Powdery Mildew', 'White fungal growth on leaves', 'Sulfur sprays, resistant varieties'),
                        _buildDiseaseItem('Downy Mildew', 'Yellow angular spots, purple underside', 'Copper fungicides, proper spacing'),
                      ],
                      Colors.orange[100]!,
                    ),

                    _buildDiseaseCategory(
                      '🦠 Bacterial Diseases',
                      [
                        _buildDiseaseItem('Angular Leaf Spot', 'Water-soaked angular lesions', 'Copper sprays, disease-free seeds'),
                        _buildDiseaseItem('Bacterial Wilt', 'Sudden wilting, sticky ooze', 'Beetle control, resistant varieties'),
                      ],
                      Colors.blue[100]!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseCategory(String title, List<Widget> diseases, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          ...diseases,
        ],
      ),
    );
  }

  Widget _buildDiseaseItem(String name, String symptoms, String management) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red[700],
            ),
          ),
          const SizedBox(height: 6),
          Text('🩺 Symptoms: $symptoms', 
            style: GoogleFonts.poppins(fontSize: 16, height: 1.4)),
          const SizedBox(height: 4),
          Text('🛠️ Management: $management', 
            style: GoogleFonts.poppins(fontSize: 16, height: 1.4)),
        ],
      ),
    );
  }

  // TAB 11: PESTS
  Widget _buildPestsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.orange[50]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange[600],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.bug_report, size: 24, color: Colors.white),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '🐛 Integrated Pest Management',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Conditional Pest Image
                    _buildConditionalImage(
                      'assets/images/cucumber_pests.jpg',
                      height: 200,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    _buildPestCategory('🦟 Insects', [
                      _buildPestItem('Aphids', 'Sap-sucking, colony formation', 'Neem oil, ladybugs, reflective mulch'),
                      _buildPestItem('Cucumber Beetles', 'Striped/spotted, vector diseases', 'Row covers, kaolin clay, traps'),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPestCategory(String title, List<Widget> pests) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          ...pests,
        ],
      ),
    );
  }

  Widget _buildPestItem(String name, String damage, String control) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.yellow[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.orange[700],
            ),
          ),
          const SizedBox(height: 6),
          Text('💥 Damage: $damage', 
            style: GoogleFonts.poppins(fontSize: 16, height: 1.4)),
          const SizedBox(height: 4),
          Text('🛡️ Control: $control', 
            style: GoogleFonts.poppins(fontSize: 16, height: 1.4)),
        ],
      ),
    );
  }

  // TAB 12: HISTORY
  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      child: _buildContentCard(
        '📜 Historical Development and Evolution',
        '''
Cucumbers have a rich history spanning millennia and continents:

🏺 Ancient Origins:
• Wild ancestors in Himalayan foothills (India)
• Domestication around 3000 BCE in Northern India
• Spread to Middle East via trade routes by 2000 BCE
• Mentioned in Sanskrit writings as "Sushruta"

🏛️ Classical Antiquity:
• Cultivated in ancient Egypt since 2000 BCE
• Included in offerings to Egyptian gods
• Greek and Roman adoption around 500 BCE
• Roman Empire spread cultivation throughout Europe

⚓ Age of Exploration:
• Columbus brought cucumbers to Americas (1494)
• Spread throughout New World by Spanish and Portuguese
• Native American adoption and cultivation

🚀 Modern Era:
• Scientific breeding programs (20th century)
• Development of disease-resistant varieties
• Hydroponic and controlled environment agriculture

The cucumber journey from wild Himalayan vines to global supermarket staple represents one of agriculture most successful domestication stories.
''',
        'assets/images/cucumber_history.jpg',
        icon: Icons.history,
        accentColor: Colors.deepPurple[600],
      ),
    );
  }
}
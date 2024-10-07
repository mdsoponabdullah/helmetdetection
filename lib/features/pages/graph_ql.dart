import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryListPage extends StatefulWidget {
  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  int _currentPage = 1;
  int _countriesPerPage = 15;
  List<dynamic> _countries = [];

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://countries.trevorblades.com/',
    );

    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 10,
          title: const Text(
            "All Countries",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Query(
          options: QueryOptions(
            document: gql("""
              query GetCountries {
                countries {
                  name,capital
                }
              }
            """),
          ),
          builder: (QueryResult result,
              {Refetch? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            _countries = result.data!['countries'];

            final int startIndex = (_currentPage - 1) * _countriesPerPage;
            final int endIndex = startIndex + _countriesPerPage;
            final displayedCountries = _countries.sublist(
                startIndex, endIndex.clamp(0, _countries.length));

            return Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  // Table Header
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2), // Country column width
                        1: FlexColumnWidth(1), // Capital column width
                      },
                      border: TableBorder.all(
                          width: 1.0, color: Colors.grey), // Table borders
                      children: const [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.blueAccent),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Country",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Capital",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Table Rows (Countries and Capitals)
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayedCountries.length,
                      itemBuilder: (BuildContext context, int index) {
                        final country = displayedCountries[index];
                        return Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2), // Country column width
                            1: FlexColumnWidth(1), // Capital column width
                          },
                          border: TableBorder.all(
                              width: 1.0, color: Colors.grey), // Table borders
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    country['name'] ?? "N/A",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    country['capital'] ?? "N/A",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _currentPage > 1
                              ? () => _loadPreviousPage()
                              : null,
                          child: Text('Previous'),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 1; i <= _getTotalPages(); i++)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      backgroundColor: i == _currentPage
                                          ? Colors.blue
                                          : null,
                                      padding: EdgeInsets.all(12.0),
                                    ),
                                    onPressed: () => _loadPage(i),
                                    child: Text(i.toString(),
                                        style: TextStyle(
                                            color: i == _currentPage
                                                ? Colors.white
                                                : Colors.black)),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _currentPage < _getTotalPages()
                              ? () => _loadNextPage()
                              : null,
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _loadPreviousPage() {
    setState(() {
      _currentPage--;
    });
  }

  void _loadNextPage() {
    setState(() {
      _currentPage++;
    });
  }

  void _loadPage(int pageNumber) {
    setState(() {
      _currentPage = pageNumber;
    });
  }

  int _getTotalPages() {
    return (_countries.length / _countriesPerPage).ceil();
  }
}

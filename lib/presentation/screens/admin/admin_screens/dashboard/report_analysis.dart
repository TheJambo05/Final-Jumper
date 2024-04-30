// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class ReportAnalysisPage extends StatelessWidget {
//   const ReportAnalysisPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Report Analysis'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Sales Data',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             SizedBox(
//               height: 200,
//               child: charts.BarChart(
//                 _createSampleData(),
//                 animate: true,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'User Growth',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             SizedBox(
//               height: 200,
//               child: charts.LineChart(
//                 _createSampleLineData(),
//                 animate: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   static List<charts.Series<Sales, String>> _createSampleData() {
//     final data = [
//       Sales('Jan', 50),
//       Sales('Feb', 100),
//       Sales('Mar', 150),
//       Sales('Apr', 200),
//     ];

//     return [
//       charts.Series<Sales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (Sales sales, _) => sales.month,
//         measureFn: (Sales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }

//   static List<charts.Series<UserGrowth, int>> _createSampleLineData() {
//     final data = [
//       UserGrowth(1, 20),
//       UserGrowth(2, 35),
//       UserGrowth(3, 50),
//       UserGrowth(4, 65),
//     ];

//     return [
//       charts.Series<UserGrowth, int>(
//         id: 'User Growth',
//         colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//         domainFn: (UserGrowth growth, _) => growth.month,
//         measureFn: (UserGrowth growth, _) => growth.users,
//         data: data,
//       )
//     ];
//   }
// }

// class Sales {
//   final String month;
//   final int sales;

//   Sales(this.month, this.sales);
// }

// class UserGrowth {
//   final int month;
//   final int users;

//   UserGrowth(this.month, this.users);
// }

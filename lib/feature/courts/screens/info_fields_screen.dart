import 'package:dunkingclub/config/colors.dart';
import 'package:dunkingclub/feature/courts/repositories/court_data.dart';
import 'package:dunkingclub/feature/courts/widgets/create_court_widget.dart';
import 'package:flutter/material.dart';

//lib/feature/info_courts/repositories/court_data.dart/';

class InfoFieldsScreen extends StatelessWidget {
  const InfoFieldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Information header with dynamic court info
        Container(
          color: const Color.fromARGB(0, 2, 153, 177),
          width: 400,
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "     Platzinformation",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: oliveLeaf),
              ),

              // Display information for each court in a Row at the top
              Expanded(
                child: ListView.builder(
                  itemCount: courts.length,
                  itemBuilder: (context, index) {
                    final court = courts[index];
                    return Container(
                      color: getColorForCourt(index),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${court.name}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: deepKelp),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Standort: ${court.locationUrl}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: deepKelp),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Spieler: ${court.playerCount}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: deepKelp),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Horizontal ListView of court cards
        Container(
          color: const Color.fromARGB(0, 250, 250, 250),
          width: 400,
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: courts.length,
            itemBuilder: (BuildContext context, int index) {
              final court = courts[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.7,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(255, 236, 250, 255),
                                Color.fromARGB(255, 97, 96, 105),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ${court.name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Location URL: ${court.locationUrl}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Image.asset(
                                  court.imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                  width: 280,
                  height: 260,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          court.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              court.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        // Button to create a new basketball court
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const CreateCourtWidget();
              },
            );
          },
          child: Text(
            "Neue Basketballplatz erstellen",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: teakwood,
                ),
          ),
        ),
      ],
    );
  }

  Color getColorForCourt(int index) {
    return index % 2 == 0 ? headInTheClouds : silkenTofu;
  }
}

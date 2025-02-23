import 'package:dunkingclub/feature/courts/repositories/court_data.dart';
import 'package:dunkingclub/feature/players/repositories/player_avatar_images.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Секция информации о последней игре с NBA стилем, отцентрированная
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 40, 5, 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 16, 16, 32),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "LAST PLANNED GAME INFORMATION",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),

                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                    children: const [
                      TextSpan(
                        text: "Start time: ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextSpan(
                        text: "10:00 ",
                        style: TextStyle(
                            color:
                                Colors.blue), // Здесь изменён цвет на голубой
                      ),
                      TextSpan(
                        text: "AM",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                    children: const [
                      TextSpan(
                        text: "Number of Players: ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextSpan(
                        text: "3 ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 111, 255, 116),
                            fontSize: 20,
                            fontWeight: FontWeight
                                .bold), // Здесь изменён цвет на голубой
                      ),
                      TextSpan(
                        text: "Maybe: ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextSpan(
                        text: "3 ",
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight
                                .bold), // // Здесь изменён цвет на голубой
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 38),
                // Новый лист с участниками игры, отображается с логотипами и статусами
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6, // Количество игроков
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // CircleAvatar(
                            //   radius: 30,
                            //   backgroundImage: NetworkImage(
                            //     'https://example.com/player${index + 1}.jpg',
                            //   ),
                            // ),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: ExactAssetImage(
                                'assets/images_avatar/djkkaufbeuren/${avatarCategories["djkkaufbeuren"]![index]}',
                              ),
                            ),

                            const SizedBox(height: 8),
                            Text(
                              "Player ${index + 1}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.white70,
                                    ),
                                children: [
                                  const TextSpan(
                                    text: "Status: ",
                                    style: TextStyle(
                                        color: Colors
                                            .white70), // Оставляем "Status" белым
                                  ),
                                  TextSpan(
                                    text: index % 2 == 0
                                        ? "Yes"
                                        : "Maybe", // Вставляем нужный статус
                                    style: TextStyle(
                                      color: index % 2 == 0
                                          ? Colors.green
                                          : Colors
                                              .orangeAccent, // Цвет для Yes и Maybe
                                    ),
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
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Новая секция для отображения площадок, с опусканием вниз
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 1),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 16, 16, 32),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ALL AVAILABLE BASKERBALL COURTS",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                // Площадки с карточками
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: courts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final court = courts[index]; // Получаем детали площадки
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
                                        Color.fromARGB(255, 20, 30, 40),
                                        Color.fromARGB(255, 90, 95, 105),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Court Name: ${court.name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Location URL: ${court.locationUrl}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.white),
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
                          margin: const EdgeInsets.only(right: 20),
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.orange, // Цвет рамки
                              width: 1, // Толщина рамки
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
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
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.6),
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      court.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

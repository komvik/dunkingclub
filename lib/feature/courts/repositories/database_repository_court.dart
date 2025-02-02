import '../models/basketball_court.dart';

abstract class DatabaseRepositoryCourt {
  // BasketballCourt-related methods
  void addCourt(BasketballCourt court);
  BasketballCourt? getCourt(String name);
  void updateCourt(BasketballCourt court);
  void deleteCourt(String name);
}

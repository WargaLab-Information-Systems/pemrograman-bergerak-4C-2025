Set uniqueElement(List<int> myList) {
  // TODO 1
  myList = [1, 2, 3, 4];
  return {myList};

  // End of TODO 1
}

Map<String, String> buildFutsalPlayersMap() {
  // TODO 2
  return {
    'GoalKeeper': 'Andri',
    'Anchor': 'Irfan',
    'Pivot': 'Fikri',
    'Right Flank': 'Aldi',
    'Left Flank': 'Hafid'
  };
  // End of TODO 2
}

Map<String, String> updatePivotPlayer() {
  final futsalPlayers = buildFutsalPlayersMap();
  futsalPlayers['Pivot'] = 'Fajar';

  // TODO 3
  // End of TODO 3

  return futsalPlayers;
}

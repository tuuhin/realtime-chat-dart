extension StreamExtensions<T> on Stream<T> {
  /// Creates a stream that makes the values appear in a list with the previous
  /// values.
  /// This maybe simply understand : A stream streaming 0,1,2,3,4,5,6
  /// The results of `addConsec` would be [0] ,[0,1],[0,1,2] and so on..
  Stream<List<T>> addConsec() async* {
    List<T> li = [];
    try {
      await for (final T value in this) {
        yield li..add(value);
      }
    } catch (e) {
      yield li;
      print(e);
    }
    li.clear();
  }
}

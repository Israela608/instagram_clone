extension RemoveAll on String {
  String removeAll(Iterable<String> values) => values.fold(
        this,
        //Replace the value of result with an empty String
        (result, value) => result.replaceAll(
          value,
          '',
        ),
      );
}

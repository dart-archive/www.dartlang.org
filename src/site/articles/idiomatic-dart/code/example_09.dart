typedef bool Filter(num x);

List<num> filterNumbers(List<num> numbers, Filter filter) {
  return numbers.where(filter).toList();
}
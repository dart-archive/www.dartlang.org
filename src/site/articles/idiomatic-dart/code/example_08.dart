List<num> filterNumbers(List<num> numbers, bool filter(num x)) {
  return numbers.where(filter).toList();
}
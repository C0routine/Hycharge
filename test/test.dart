
void main () {
  List<String> temp = ['a','a','b','c','d'];
  Set<String> list = temp.toSet();
  print(temp);
  print(list);

  list.add('a');
  print(list);

  list.add('e');
  print(list);

  list.remove('a');
  print(list);

  print(list.toList());
}
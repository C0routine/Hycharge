
void main () {
  int start = DateTime.now().millisecondsSinceEpoch;
  print(start);
  print(DateTime.now().millisecondsSinceEpoch - start);
}
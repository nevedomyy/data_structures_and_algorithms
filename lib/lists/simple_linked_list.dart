void main(List<String> arguments) {
  final list = LinkList<Person>();
  print(list);

  list.insertFirst(Person(17, 'Barbara'));
  list.insertFirst(Person(12, 'Samuel'));
  list.insertFirst(Person(45, 'Angela'));
  list.insertFirst(Person(74, 'Halk'));
  list.insertFirst(Person(25, 'Jon'));
  print(list);

  final link1 = list.deleteFirst();
  print(link1);
  print(list);

  final link2 = list.findById(74);
  print(link2);

  final link3 = list.deleteById(74);
  print(link3);
  print(list);

  final link4 = list.findById(74);
  print(link4);

  list.deleteById(12);
  print(list);

  list.insertAfterId(45, Person(88, 'Bob'));
  print(list);

  list.insertAfterId(10, Person(55, 'Hloe'));
  print(list);

  list.clear();
  list.insertAfterId(45, Person(88, 'Bob'));
  print(list);
}

class Person {
  final int id;
  final String name;

  const Person(this.id, this.name);

  @override
  String toString() => '{id=$id,name=$name}';
}

class _Link<Person> {
  final Person person;
  _Link? nextLink; // next link in list

  _Link(this.person, [this.nextLink]);

  @override
  String toString() => person.toString();
}

class LinkList<Person> {
  _Link? _firstLink; // first link on list
  int _length = 0;

  bool get isEmpty => _firstLink == null;

  int get length => _length;

  void insertFirst(Person person) {
    final link = _Link(person, _firstLink);
    _firstLink = link;
    _length++;
  }

  Person? deleteFirst() {
    if (isEmpty) return null;
    final firstLink = _firstLink;
    _firstLink = firstLink?.nextLink;
    _length--;
    return firstLink?.person;
  }

  Person? findById(int id) {
    if (isEmpty) return null;
    _Link? currentLink = _firstLink;
    while (currentLink != null) {
      if (currentLink.person.id == id) return currentLink.person;
      currentLink = currentLink.nextLink;
    }
    return null;
  }

  void insertAfterId(int afterId, Person person) {
    if (isEmpty) {
      insertFirst(person);
      return;
    }
    _Link? prevLink = _firstLink;
    _Link? currentLink = _firstLink;
    while (currentLink != null) {
      if (currentLink.person.id == afterId) {
        final link = _Link(person, currentLink.nextLink);
        currentLink.nextLink = link;
        _length++;
        return;
      }
      prevLink = currentLink;
      currentLink = currentLink.nextLink;
    }
    // add at the end if is no matches
    prevLink?.nextLink = _Link(person);
    _length++;
  }

  Person? deleteById(int id) {
    if (isEmpty) return null;
    if (_firstLink?.person.id == id) return deleteFirst();
    _Link? prevLink = _firstLink;
    _Link? currentLink = _firstLink?.nextLink;
    while (currentLink != null) {
      if (currentLink.person.id == id) {
        prevLink?.nextLink = currentLink.nextLink;
        _length--;
        return currentLink.person;
      }
      prevLink = currentLink;
      currentLink = currentLink.nextLink;
    }
    return null;
  }

  void clear() {
    _firstLink = null;
    _length = 0;
  }

  @override
  String toString() {
    if (isEmpty) return 'LinkList is empty';
    final buffer = StringBuffer();
    _Link? currentLink = _firstLink; // start at beginning of list
    while (currentLink != null) {
      buffer.write(currentLink);
      currentLink = currentLink.nextLink; // move to next link
    }
    return buffer.toString();
  }
}

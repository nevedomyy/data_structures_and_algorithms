void main(List<String> arguments) {
  final list = LinkList();
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

  final link2 = list.find(74);
  print(link2);

  final link3 = list.delete(74);
  print(link3);
  print(list);

  final link4 = list.find(74);
  print(link4);

  list.delete(12);
  print(list);

  list.insertAfter(45, Person(88, 'Bob'));
  print(list);

  list.insertAfter(10, Person(55, 'Hloe'));
  print(list);

  list.clear();
  list.insertAfter(45, Person(88, 'Bob'));
  print(list);
}

class Person {
  final int id;
  final String name;

  const Person(this.id, this.name);

  @override
  String toString() => '{id=$id,name=$name}';
}

class _Link<E> {
  final E item;
  _Link<E>? nextLink; // next link in list

  _Link(this.item, [this.nextLink]);

  @override
  String toString() => item.toString();
}

class LinkList<E> {
  _Link? _firstLink; // first link on list

  bool get isEmpty => _firstLink == null;

  void insertFirst(E item) {
    final link = _Link(item, _firstLink);
    _firstLink = link;
  }

  E? deleteFirst() {
    if (isEmpty) return null;
    final firstLink = _firstLink;
    _firstLink = firstLink?.nextLink;
    return firstLink?.item;
  }

  E? find(int id) {
    if (isEmpty) return null;
    _Link? currentLink = _firstLink;
    while (currentLink != null) {
      if (currentLink.item.id == id) return currentLink.item;
      currentLink = currentLink.nextLink;
    }
    return null;
  }

  void insertAfter(int afterId, E item) {
    if (isEmpty) {
      insertFirst(item);
      return;
    }
    _Link? prevLink = _firstLink;
    _Link? currentLink = _firstLink;
    while (currentLink != null) {
      if (currentLink.item.id == afterId) {
        final link = _Link(item, currentLink.nextLink);
        currentLink.nextLink = link;
        return;
      }
      prevLink = currentLink;
      currentLink = currentLink.nextLink;
    }
    // add at the end if is no matches
    prevLink?.nextLink = _Link(item);
  }

  E? delete(int id) {
    if (isEmpty) return null;
    if (_firstLink?.item.id == id) return deleteFirst();
    _Link? prevLink = _firstLink;
    _Link? currentLink = _firstLink?.nextLink;
    while (currentLink != null) {
      if (currentLink.item.id == id) {
        prevLink?.nextLink = currentLink.nextLink;
        return currentLink.item;
      }
      prevLink = currentLink;
      currentLink = currentLink.nextLink;
    }
    return null;
  }

  void clear() => _firstLink = null;

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

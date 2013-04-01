import 'dart:async';

class Connection {
  Future query(String sql, [List args]) {
    return null;
  }
}
class DatabaseConnection extends Connection { }

typedef Connection ConnectionFactory();

Connection _newDBConnection() => new DatabaseConnection();

class Person {
  String id;
  String name;
  ConnectionFactory connectionFactory;

  Person({this.connectionFactory: _newDBConnection});

  Future save() {
    var conn = connectionFactory();
    return conn.query('UPDATE PERSONS SET name = ? WHERE id = ?', [name, id]);
  }
}
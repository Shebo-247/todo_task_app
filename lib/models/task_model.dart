class Task {
  int tid, _isCompleted;
  String _title, _date;

  Task(this._title, this._date, this._isCompleted, {this.tid});

  // Named Constructors
  Task.map(dynamic map) {
    this.tid = map['id'];
    this._title = map['title'];
    this._date = map['date'];
    this._isCompleted = map['isCompleted'];
  }

  Task.fromMap(Map<String, dynamic> map) {
    this.tid = map['id'];
    this._title = map['title'];
    this._date = map['date'];
    this._isCompleted = map['isCompleted'];
  }

  // Getters
  int get id => this.tid;

  String get title => this._title;

  String get date => this._date;

  int get isCompleted => this._isCompleted;

  // Setters
  void setTitle(String title) {
    if (title.length <= 255) this._title = title;
  }

  void setDate(String date){
    this._date = date;
  }

  void setComplete(int isCompleted) {
    this._isCompleted = isCompleted;
  }

  // Manipulations
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this.tid != null) {
      map['id'] = this.tid;
    }
    map['title'] = this._title;
    map['date'] = this._date;
    map['isCompleted'] = this._isCompleted;

    return map;
  }
}

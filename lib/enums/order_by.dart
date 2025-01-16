enum OrderOptions{
  dateCreated,dateModified;
  String get name{
    return switch(this){
      OrderOptions.dateModified=>'Modified Date',
      OrderOptions.dateCreated=>'Created Date'


    };
  }
}
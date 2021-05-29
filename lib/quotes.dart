class Quotes {
  String text, author,url;

  // Quotes(text,autor){
  //   this.text=text;
  //   this.author=author;
  // }
  Quotes(this.text, this.author,this.url);

  Quotes.fromJson(Map<String, dynamic> json)
      {
        var quote=json['tweet'].toString();
        var indexOfhttp=quote.lastIndexOf("http");
        if(indexOfhttp!=-1) {
          quote = quote.substring(0, indexOfhttp);
        }
        text = quote;
        author = json.containsKey("author")?json['author']:"";
        url=json['url'];
}
  Map<String, dynamic> toJson() =>
      {
        'text': text,
        'author': author,
      };
}
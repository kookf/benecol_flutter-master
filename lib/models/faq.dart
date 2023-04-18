class FAQ {  
  late String title;    
  late String content; 

  FAQ.fromJSON(Map<String, dynamic> json) {    
    this.title = json['title'] ?? '';    
    this.content = json['content'] ?? '';    
  }
}
class SingleBanner {  
  late String imagePath;    
  late String subTitle;    
  late String title;    

  SingleBanner.fromJSON(Map<String, dynamic> json) {    
    this.imagePath = json['imagePath'] ?? '';    
    this.subTitle = json['subTitle'] ?? '';    
    this.title = json['title'] ?? '';    
  }
}
class SliderData {
    int? id;
    String? link;
    int? linkId;
    String? name;
    int? status;
    String? type;
    String? sliderImage;

    SliderData({this.id, this.link, this.linkId, this.name, this.status, this.type,this.sliderImage});

    factory SliderData.fromJson(Map<String, dynamic> json) {
        return SliderData(
            id: json['id'], 
            link: json['link'], 
            linkId: json['link_id'], 
            name: json['name'], 
            status: json['status'], 
            type: json['type'],
            sliderImage: json['slider_image'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['link'] = this.link;
        data['link_id'] = this.linkId;
        data['name'] = this.name;
        data['status'] = this.status;
        data['type'] = this.type;
        data['slider_image'] = this.sliderImage;
        return data;
    }
}
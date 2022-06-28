class SendResponse {
  String? link;
  String? sid;
  String? createdBy;
  String? createdDatetime;
  String? modifiedBy;


  SendResponse(
      {this.link,
        this.sid,
        this.createdBy,
        this.createdDatetime,
        this.modifiedBy,
        });

  SendResponse.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    sid = json['sid'];
    createdBy = json['created_by'];
    createdDatetime = json['created_datetime'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['sid'] = this.sid;
    data['created_by'] = this.createdBy;
    data['created_datetime'] = this.createdDatetime;
    data['modified_by'] = this.modifiedBy;
    return data;
}


}
class UserData {
  String firstName;
  String lastName;
  int studyID;
  String email;
  String phone;
  String gender;
  String age;
  String religion;
  String eth;
  String eLevel;
  String empStatus;
  String rStatus;
  String eHS;
  String sexAge;
  String sWC;
  String testHIV;
  String timesTestedHIV;
  String recentHIVTest;
  String recentHIVTestResult;
  String hIVTestLoc;
  String neverTested;
  String hIVSelfTesting;

  UserData(
      {this.firstName,
      this.lastName,
      this.studyID,
      this.email,
      this.phone,
      this.gender,
      this.age,
      this.religion,
      this.eth,
      this.eLevel,
      this.empStatus,
      this.rStatus,
      this.eHS,
      this.sexAge,
      this.sWC,
      this.testHIV,
      this.timesTestedHIV,
      this.recentHIVTest,
      this.recentHIVTestResult,
      this.hIVTestLoc,
      this.neverTested,
      this.hIVSelfTesting});

  UserData.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    studyID = json['studyID'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    age = json['age'];
    religion = json['religion'];
    eth = json['eth'];
    eLevel = json['eLevel'];
    empStatus = json['empStatus'];
    rStatus = json['rStatus'];
    eHS = json['eHS'];
    sexAge = json['sexAge'];
    sWC = json['sWC'];
    testHIV = json['testHIV'];
    timesTestedHIV = json['timesTestedHIV'];
    recentHIVTest = json['recentHIVTest'];
    recentHIVTestResult = json['recentHIVTestResult'];
    hIVTestLoc = json['hIVTestLoc'];
    neverTested = json['neverTested'];
    hIVSelfTesting = json['hIVSelfTesting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['studyID'] = this.studyID;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['religion'] = this.religion;
    data['eth'] = this.eth;
    data['eLevel'] = this.eLevel;
    data['empStatus'] = this.empStatus;
    data['rStatus'] = this.rStatus;
    data['eHS'] = this.eHS;
    data['sexAge'] = this.sexAge;
    data['sWC'] = this.sWC;
    data['testHIV'] = this.testHIV;
    data['timesTestedHIV'] = this.timesTestedHIV;
    data['recentHIVTest'] = this.recentHIVTest;
    data['recentHIVTestResult'] = this.recentHIVTestResult;
    data['hIVTestLoc'] = this.hIVTestLoc;
    data['neverTested'] = this.neverTested;
    data['hIVSelfTesting'] = this.hIVSelfTesting;
    return data;
  }
}
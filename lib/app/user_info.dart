class UserInfo {
  static int percentage = 0;
  static int repId = 0;
  static int cityId = 0;
  static String cityTitle = "";
  static int? otherPlanId = 0;
  static int activePlanId = 0;
  static int? otherstatus = 0;
  static String? token = "";
  static String? name = "";
  static int isLogging = 0;
  static String lang = "";
  static String? endDate = "";
  static String? startDate = " ";
  static String? otherStartDate = " ";
  static String? otherEndDate = " ";
  static int samplesCount = 2;
  static int flag = 0;
  static int recipesCount = -1;
  static int visits = -1;
  static int visited = -1;
  static int flag1 = 0;
  static int version = 4;
  static String repType = "0";
  static int numOfDoctorVisit = -1;
  static int numOfHospitalVisit = -1;
  static bool isScreenWidth = false;
  static bool isChange = false;
  static int numDoctor = 0;
  static int numHospital = 0;
  static int statusPlan = UserInfo.repType == "5" ? 5 : 1;

  /// 🔹 الدالة الجديدة لتعبئة البيانات من الموديل مباشرة
  static void fillFromModel(dynamic data) {
    name = data.name;
    isLogging = data.isLogin;
    cityId = data.cityId;
    cityTitle = data.cityTitle;
    activePlanId = data.activePlanId ?? -5;
    otherPlanId = data.otherPlanId;
    otherstatus = data.otherStatus;
    percentage = data.percentage;
    recipesCount = data.recipesCount;
    repId = data.repId;
    token = data.token;
    startDate = data.startDate;
    endDate = data.endDate;
    otherStartDate = data.otherStartDate;
    otherEndDate = data.otherEndDate;
    samplesCount = data.samplesCount;
    repType = data.repType;
    flag = data.flag;

    // منطق التحقق من الـ Flag كما كان في ملف المين
    flag1 = otherstatus == -1 ? 0 : (data.flag1 ?? 0);

    // تحديث حالة الخطة بناءً على نوع المندوب
    statusPlan = repType == "5" ? 5 : 1;
  }

  /// دالة اختيارية لتصفير البيانات عند تسجيل الخروج
  static void clear() {
    isLogging = 0;
    name = "";
    token = "";
    activePlanId = -5;
    // ... قم بتصفير باقي الحقول الضرورية هنا
  }
}
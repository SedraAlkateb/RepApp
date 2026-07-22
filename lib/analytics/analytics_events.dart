class AnalyticsEvents {


  // =====================
  // Authentication
  // =====================
  static const String syncStarted =
      "sync_started";

  static const String syncDownloadCompleted =
      "sync_download_completed";

  static const String syncDatabaseInsertStarted =
      "sync_database_insert_started";

  static const String syncDatabaseInsertCompleted =
      "sync_database_insert_completed";

  static const String syncFailed =
      "sync_failed";

  static const String loginSuccess =
      "login_success";


  static const String loginFailed =
      "login_failed";


  static const String logout =
      "logout";



  // =====================
  // Visits
  // =====================

  static const String visitStarted =
      "visit_started";


  static const String visitCompleted =
      "visit_completed";



  // =====================
  // Orders
  // =====================

  static const String orderCreated =
      "order_created";


  static const String orderUpdated =
      "order_updated";



  // =====================
  // Sync
  // =====================

  static const String syncCompleted =
      "sync_completed";
  static const String syncStepCompleted =
      "sync_step_completed";


  static const String syncStepFailed =
      "sync_step_failed";




}
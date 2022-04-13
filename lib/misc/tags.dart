//Authorization
const String SIGN_IN = "Sign In";
const String LOGOUT = "Logout";

//Pages/Routes
const String VIBE = "Vibe";
const String ADD_NEW_ALERT = "Add New Alert";
const String SAVED_ALERTS = "Saved Alerts";
const String SAVED_ALERTS_BY_CATEGORY = "Saved Alerts By Category";
const String SETTINGS = "Settings";
const String ALERT = "Alert Settings";

//Named Routes
const String HOME_ROUTE = "/home";
const String NEW_ALERT_ROUTE = "/newAlert";
const String SAVED_ALERTS_ROUTE = "/savedAlerts";
const String SETTINGS_ROUTE = "/settings";

//Buttons
const String SAVE = "Save";
const String CONFIRM = "Confirm";
const String CANCEL = "Cancel";
const String DELETE = "Delete";
const String PLAY = "Play alert";

//Saved Alerts Model
//Alerts
const String ALERT_ID = "alertId";
const String ALERT_NAME = "alertName";
const String ALERT_CATEGORY = "alertCategory";
const String ALERT_ICON = "alertIcon";
const String ALERT_DURATION = "alertDuration";
const String ALERT_PATH = "alertPath";
const String ALERT_BEHAVIOR = "alertBehavior";
const String IS_SILENT = "isSilent";
//Categories
const String CATEGORY_NAME = "categoryName";
const String CATEGORY_ICON = "categoryIcon";
//Behaviors
const String IS_FULL_PAGE = "isFullPage";
const String IS_SOUND = "isSound";
const String IS_VIBRATE = "isVibrate";
const String IS_FLASH = "isFlash";

//Alert Page UI
const String TYPE_OF_ALERT_UI = "Type of alert";
const String IS_FULL_PAGE_UI = "Will be popup or fullscreen alert";
const String IS_SOUND_UI = "Will this alert play sound?";
const String IS_VIBRATE_UI = "Will this alert vibrate?";
const String IS_FLASH_UI = "Will this alert flash?";
const String SILENCE_THIS_ALERT_UI = "Silence this alert";
const String UPDATE_THIS_ALERT_UI = "Update this alert";
const String CATEGORY_UI = "Category";
const String CATEGORIES_UI = "Categories";
const String RERECORD = "Rerecord";
const String ALERT_ICON_UI = "Alert icon";
const String ALL_UI = "All";

//Types of Alert Functions
const String VIBRATE = "Vibrate";
const String MEDIUM = "Medium";
const String FLASHLIGHT_STROBE = "Flashlight strobe";
const String BANNER = "Banner";

//Settings Page UI
const String SAVE_TO_CLOUD = "Save alerts to cloud";
const String SIGN_UP_SIGN_IN_TEXT = "Sign-up / Sign-in";
const String SEND_TO_CLOUD = "Send alerts to cloud";
const String DEFAULT_ALERT_TYPE = "Set default alert type";
const String SILENCE_FROM_TIME = "Silence from";
const String DO_NOT_DISTURB = "Do not disturb";
const String SYNC_WITH_OTHER_DEVICES = "Sync with other devices";
const String SAVE_ALERT_HISTORY = "Saved alerts history";

//Settings Page Functions
const String ONLY_EMERGENCY_ALERTS = "Only emergency alerts";
const String SYNC_SUBTEXT = "Alerts will appear on other devices";

//Prebuilt Categories
const String HOME_CATEGORY_UI = "Home";
const String EMERGENCY_CATEGORY_UI = "Emergency";

//Popups
const String ALERT_NAME_HINT = "Alert name";
const String SAVE_NEW_ALERT = "Save new alert";
const String UPDATE_ALERT = "Update alert";
const String DELETE_ALERT = "Are you sure you want to delete this alert?";
const String ADD_NEW_CATEGORY = "Add new category";
const String CATEGORY_ICON_UI = "Category icon";
const String UPDATE_CATEGORY = "Update category";
const String NEW_CATEGORY_TEXT_HINT = "Enter new category name here";

//File Management
const String RECORDINGS_FOLDER_NAME = "Vibe Recordings";
const String NEW_RECORDING_NAME = "New Alert";
const String ALERTS_JSON_FILE_NAME = "alertsJson.json";
const String CATEGORY_JSON_FILE_NAME = "categoriesJson.json";

//Misc
const String CATEGORY = "Category";
const String DEFAULT = "Default";
const String ADD_NEW_ALERT_INSTRUCTION_TEXT = """
Lorem ipsum dolor 
sit amet, consectetur 
adipiscing elit.
""";

//Data Tagging Model
//Alert Tagging
const String USER_ID = "userId";
const String AUDIO_CLIP = "audioClip";
const String CLIP_LABEL = "clipLabel";
const String RESPONSE_INDEX = "response";
const String TIME_STAMP = "timeStamp";
//Data Tags
const String DATA_TAG_INDEX = "index";
const String DATA_TAG_NAME = "tagName";

//Ints
const int MAX_ALERTS = 20;
const int MAX_CATEGORIES = 20;

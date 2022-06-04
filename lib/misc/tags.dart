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
const String SPLASH_ROUTE = "/splash";
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

//Settings Model
const String IS_SILENT_FROM = "isSilentFrom";
const String TIME_TO_SILENCE_HOUR = "timeToSilenceHour";
const String TIME_TO_SILENCE_MINUTE = "timeToSilenceMinute";
const String IS_DO_NOT_DISTURB = "isDoNotDisturb";
const String IS_SYNC = "isSync";

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
const String SETTINGS_JSON_FILE_NAME = "settingsJson.json";

//Misc
const String CATEGORY = "Category";
const String DEFAULT = "Default";
const String ADD_NEW_ALERT_INSTRUCTION_TEXT = """
Lorem ipsum dolor 
sit amet, consectetur 
adipiscing elit.
""";
const String CORRECT_DETECTION = "Was this detection correct?";

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
const int INITIAL_DEFAULT_ALERTS = 8;

//Predefined Sounds Strings
const String RED_ALERT = "אזעקת צבע אדום";
const String SHOOTING = "ירי";
const String SIREN = "סירנה";
const String DOORBELL = "פעמון דלת";
const String LOUD_SOUND = "סאונד חזק";
const String MICROWAVE = "מיקרו";
const String WASHING_MACHINE = "מכונת כביסה";
const String DOOR_KNOCK = "דפיקה בדלת";
const String GLASS_BREAKING = "זכוכית נשברת";
const String ITEM_FALL = "משהו נפל";
const String DOOR_SLAMMING = "דלת נטרקת";
const String DRYER = "מייבש";
const String DOG_BARKING = "כלב נובח";
const String BABY_CRYING = "תינוק בוכה";
const String WATER_RUNNING = "מים זורמים";
const String CRYING = "בכי";
const String SHOUTING = "צעקות";
const String CALL_BY_NAME = "קריאה בשם";

//Predefined Sounds Strings To Python
const String RED_ALERT_PYTHON = "red_alert";
const String SHOOTING_PYTHON = "shooting";
const String SIREN_PYTHON = "siren";
const String DOORBELL_PYTHON = "doorbell";
const String LOUD_SOUND_PYTHON = "loud_sound";
const String MICROWAVE_PYTHON = "microwave";
const String WASHING_MACHINE_PYTHON = "washing_machine";
const String DOOR_KNOCK_PYTHON = "door_knock";
const String GLASS_BREAKING_PYTHON = "glass_breaking";
const String ITEM_FALL_PYTHON = "item_falling";
const String DOOR_SLAMMING_PYTHON = "door_slamming";
const String DRYER_PYTHON = "dryer";
const String DOG_BARKING_PYTHON = "dog_barking";
const String BABY_CRYING_PYTHON = "baby_crying";
const String WATER_RUNNING_PYTHON = "water_running";
const String CRYING_PYTHON = "crying";
const String SHOUTING_PYTHON = "shouting";
const String CALL_BY_NAME_PYTHON = "name_call";

//Push Notifications
const String CANCEL_ALERT_CHANNEL_KEY = "cancel_channel";
const String CANCEL_ALERT_CHANNEL_NAME = "Cancel alert notifications";

const String DETECT_ALERT_CHANNEL_KEY = "detect_channel";
const String DETECT_ALERT_CHANNEL_NAME = "Detect alert notifications";

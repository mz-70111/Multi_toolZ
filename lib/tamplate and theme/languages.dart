class Lang {
  static List langlist = ['Ar', 'En'];
  static String? selectlanguage;

  static Map lang = {
    'logintitle': ['تسجيل الدخول', 'LogIn'],
    'logineusernamelabel': ['اسم المستخدم', 'username'],
    'loginepasswordlabel': ['كلمة المرور', 'Password'],
    'loginenewpasswordlabel': ['كلمة المرور الجديدة', 'new Password'],
    'loginenewpasswordconfirmlabel': [
      'تأكيد كلمة المرور الجديدة',
      'new Password -Confirm'
    ],
    'loginaction': ['دخول', 'login'],
    'chgpassaction': ['تأكيد', 'Confirm'],
    'loginerrormsg': [
      'لا يمكن ان يكون اسم المستخدم او كلمة المرور فارغا',
      'username or password can\'t be empty'
    ],
    'accountdisable': ['الحساب معطل', 'your account is disabled'],
    'mainloginerrormsg': [
      'لا يمكن الوصول للمخدم',
      'Can\'t reach server right now'
    ],
    'mainloginerrormsgfaillogin': [
      'اسم المستخدم او كلمة المرور غير صحيحة',
      'username or password Wrong!!'
    ],
    'checkemptynewpass': [
      'لا يمكن ان تكون كلمة المرور الجديدة فارغة',
      'new password can\'t be empty!!'
    ],
    'passwordnotmatch': ['كلمة المرور غير متطابقة', 'passwords aren\'t match'],
    'homepageapptitle': ['M ult ools i Z', 'M ult ools i Z'],
    'drawerpersonalinfo': ['معلومات الحساب', 'Account Info'],
    'drawerpesonalchgpass': ['تغيير كلمة المرور', 'change password'],
    'logout': ['تسجيل الخروج', 'LogOut'],
    'choselang': ['اختيار اللغة', 'chose language'],
    'offices': ['المكاتب', 'Offices'],
    'accounts': ['الحسابات', 'Accounts'],
    'tasks': ['المهمات', 'Tasks'],
    'todo': ['الإجرائيات', ' WhattoTodo'],
    'remind': ['التذكير', 'Remind'],
    'ping': ['Ping', 'Ping'],
    'checkemails': ['تفحص أخطاء البريد الالكتروني', 'Check Emails'],
    'pbx': ['المقسم', 'PBX'],
    'hlinks': ['روابط خارجية', 'Links'],
  };
}

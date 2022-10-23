import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "flutter-expense-tracker-sheet",
  "private_key_id": "36ec3326a4874c7c549d8f2e2f67f0b67997a623",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC42obnABpN5uC7\ngfTORhNamqxFDmdrI3As7zeayXYhNXhbG/9GeUvf/hdZCjKI0OBnumuxP2rEvHzm\nP6SAEHrEonOVbakfdEdR1KqDi5u1qN0bEMvn6Sn7r9X7xiz96vvmGVQYoh1aPisR\ndWje5lNMLxNThfi/yVLdKn4e9yOV5sH2dBIu8QtshMK4zDS69bfF+g56mkz1QD52\nOyfcIJKTji5qygGnR10K3cfhyJqWCU6rwmOjLn2FJEPRcuZ5MFPdeBp3g5IB73d+\ndTanZGO/SYJOOynLdN6uEP9Y1S/JKbRo8f0U0hVlN30f7jraRjCZ0JDdCo/BGO4J\nuxD5WVMvAgMBAAECggEAPpidYv7paWTbyBMnQ2x+ZEmJOW85vRGIjGbLNQqwimlR\nYsTVylcLxwODg37NAwB8ZRO/IQvhC1LqlouJmGY8NHbwXfL++KxG9GJoBViSt07B\n5MbozZTqxxRRiUsf9DIM7+u2ywqmlucDbYuNIiHrphow2LE+vS8e9M7NW44DymAA\nFRKutp2EIiKX9TYrPl8OCIjcdrBIKGz66jXcT5Qrhuy2hH+9CuxzylsoXcEnMCqh\nI1wzCBHPX3XTxCe0q8wi2yfqJLUh4M/EXwnUdP56RWWKobdtgyEn8xx+jwEFm0Ow\nEbQd9JOx8Pc6TYt8PBgNG181Zalp3RrslEEMuhbTpQKBgQDz9UGH6io3DP77O1rb\nWJ3D7CbyJTU9wZPKq+oXBU7EUZ63H1JdqvcsDiiZWEfEYnqygURQVnoTOjlVv6xv\nh/n7iuKCobQbShfkZP+wXBfHEJ9Tcbygvb4UiWR3kTVU9GwbCL2w5iWf3RyZzkCB\nY0occzCOGm57tDbgprJGjEVPpQKBgQDB+mfgauYMH0MIwQKUqgzURA49xjJnP9eI\nf/2fvxpZzPC5WZhlGqbHkqVV1t8EtWPy0IGojDQOLduOb2cjSYqRtT5mLHwD9WS5\nzBsfGahE/czLdptfDWr9ScuskPf5ASAkdynVR1WtiMietX3JKGbsXbbwqxpICNYm\nwE7un2afQwKBgQCEd44HwSz/C32A6a/iHvI7qoVTQsTwLaaUjFjl+ynUDAXEpatR\n1T21nFKLQZZmmprJRsvTW8GZoyny18tIHGuvHLD2AdwMXWUvzW/RUZBPtUTuSHoG\nRkFqYVg+XIi7AqWY4FwwLCgN8EBRe98m4sUhQaMB5nRLk4Wg4qM3D3+rSQKBgBaG\nNy2t/AyITMZlcyFEJb04Mdcmfo/Sr/pfslmsXSj0TTeYmcOTtq4R7zTqgHcRgQue\n/o9NyHWlCYuekAFe9sI4o4hFvhjPk+SnOLcBybJJLlCp8xy0eCn1ObtOEh1N7ieN\n1sO3RtGhwnn7ZSHImTr1HtsPYzveGs/hIMlApS/1AoGBAKSXYqtyNeoSYrc3XwMD\nKeuzBSaGpo720lo9qJ+xXE15s/fgz0owLU9/aD1nYa1Wz2QZtqAOx9AKYcMyKtEL\n/2AzL4h8xqsZPBm4+v7TA4xTQ7btySF/1rOSGjUpPyhArEp2N1F7cnAexuaCBFo6\nazHgBW1K1zCd8mMi1WcAUuEJ\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-expense-tracker-sheet@flutter-expense-tracker-sheet.iam.gserviceaccount.com",
  "client_id": "107797920992461187084",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-expense-tracker-sheet%40flutter-expense-tracker-sheet.iam.gserviceaccount.com"
}

''';

//  spreadsheet Id
  static const _spreadsheetId = "1U_fCut3nQoEXyT1I_srENkJjdCDjF3zKJzG-VxVsh_o";

// init Gsheets
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

// some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

// initailize the spreadsheet
  Future init() async {
    // fetch spreadsheet by its Id
    final ss = await _gsheets.spreadsheet(_spreadsheetId);

// get worsksheet by its title
    _worksheet = ss.worksheetByTitle('worksheet1');
    countRows();
  }

// count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }

// now we know how many notes to load, now let's load them!
    loadTransactions();
  }

// load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }

// ignore: avoid_print
    print(currentTransactions);

// this will stop the circular loading indicator
    loading = false;
  }

// insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

// CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

// CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }

  static Future<bool> deleteById(int id) async {
    if (_worksheet == null) return false;

    final index = await _worksheet!.values.rowIndexOf(id);
    if (index == -1) return false;

    return _worksheet!.deleteRow(index);
  }
}

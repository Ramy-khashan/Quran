String convertToArabic(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['۰', '۱', '۲', '۳', '٤', '۵', '٦', '۷', '۸', '۹'];
  String timeInArabic = "";
  for (int i = 0; i < input.toString().length ; i++) {
    

    timeInArabic += arabic[english.indexOf(input[i])];
  }
 
 
   
  
   return timeInArabic;
}

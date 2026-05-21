class Utils {
  static String memonicToDayName(String name) {
    switch (name) {
      case "M":
        return "mon";
      case "T":
        return "tue";
      case "W":
        return "wed";
      case "Th":
        return "thu";
      case "F":
        return "fri";
      case "S":
        return "sat";
      case "Su":
        return "sun";
      default:
        return "mon";
    }
  }
}

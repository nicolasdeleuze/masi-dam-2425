enum Role {
  admin,
  bartender,
  waiter;

  static Role parse(int idx) {
    switch(idx) {
      case 0:
        return Role.admin;
      case 1:
        return Role.bartender;
      case 2:
        return Role.waiter;
      default:
        throw Exception("Unsupported role");
    }
  }
}
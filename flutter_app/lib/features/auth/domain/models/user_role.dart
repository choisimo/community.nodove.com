enum UserRole { roleUser, roleAdmin }

class UserRoleHelper {
  static UserRole fromString(String role) {
    switch (role) {
      case 'ROLE_USER':
        return UserRole.roleUser;
      case 'ROLE_ADMIN':
        return UserRole.roleAdmin;
      default:
        return UserRole.roleUser;
    }
  }

  static String toValue(UserRole role) {
    switch (role) {
      case UserRole.roleUser:
        return 'ROLE_USER';
      case UserRole.roleAdmin:
        return 'ROLE_ADMIN';
    }
  }
}

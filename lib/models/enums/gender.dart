/// 性别
enum Gender {
  /// 女性
  FEMALE,
  /// 男性
  MALE,

}

String getGenderName(Gender gender) {
  return gender.toString().substring(gender.toString().indexOf('.') + 1);
}
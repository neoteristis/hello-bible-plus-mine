import 'package:objectbox/objectbox.dart';

import '../../../domain/entities/user.dart';

@Entity()
class UserBox {
  @Id()
  int? idInt;
  // @Unique(onConflict: ConflictStrategy.replace)
  String? idString;
  String? lastName;
  String? firstName;
  String? email;
  String? country;

  UserBox({
    this.idInt,
    this.idString,
    this.lastName,
    this.firstName,
    this.email,
    this.country,
  });

  User toEntity() => User(
        idInt: idInt,
        idString: idString,
        firstName: firstName,
        lastName: lastName,
        email: email,
        country: country,
      );

  factory UserBox.fromEntity(User user) => UserBox(
        idInt: user.idInt,
        idString: user.idString,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        country: user.country,
      );
}

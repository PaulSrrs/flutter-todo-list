abstract class User {
  final String firstname;
  final String lastname;

  User(this.firstname, this.lastname);

  String getJob();
  String getAge();
}

class TeamMember extends User {
  TeamMember(String firstname, String lastname) : super(firstname, lastname);

  @override
  String getJob() {
    return 'Student at Epitech';
  }

  @override
  String getAge() {
    return '21 years old';
  }
}

class AppUser extends User {
  AppUser(String firstname, String lastname, this.age, this.job)
      : super(firstname, lastname);
  final String job;
  final String age;

  @override
  String getJob() {
    return job;
  }

  @override
  String getAge() {
    return age;
  }
}

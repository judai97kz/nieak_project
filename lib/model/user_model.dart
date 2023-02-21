class User{
  final String username;
  final String password;
  final String name;
  final String phone;
  final String address;
  final String idcart;
  final int role;
  int wallet;

  User({
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.address,
    required this.idcart,
    required this.wallet,
    required this.role
  });
  factory User.fromJson(Map<String,dynamic> json) => User(
    username: json['username'],
    password: json['password'],
    name: json['name'],
    phone: json['phone'],
    address: json['address'],
    idcart: json['idcart'],
    wallet: json['wallet'],
    role: json['role']
  );

  Map<String,dynamic> toJson() => {
    'username':username,
    'password':password,
    'name':name,
    'phone':phone,
    'address':address,
    'idcart':idcart,
    'wallet':wallet,
    'role':role
  };
}
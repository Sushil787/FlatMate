/// The email accounts the development seed makes (the server's
/// dev/seed.dart), for one-tap sign-in in debug builds. Development only:
/// the server has no email sign-in outside it, so these are not secrets.
const devAccounts = [
  (name: 'Priya', role: 'Admin', email: 'admin@flatmates.dev'),
  (name: 'Sam', role: 'Mate', email: 'sam@flatmates.dev'),
];

/// The password of every [devAccounts] account.
const devPassword = 'flatmates123';

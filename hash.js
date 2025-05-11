const bcrypt = require('bcrypt');

bcrypt.hash('12345678', 12).then(hash => {
  console.log('yakukung:', hash);
});
bcrypt.hash('55555555', 12).then(hash => {
  console.log('test1:', hash);
});
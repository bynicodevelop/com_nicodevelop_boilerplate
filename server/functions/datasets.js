const admin = require('firebase-admin');
const {info} = require('firebase-functions/logger');
const {faker} = require('@faker-js/faker');

const userFactory = async (number) => {
  const usersRecords = [];

  for (let i = 0; i < number; i++) {
    const uid = `123456789${i}`;
    const displayName = faker.name.firstName();
    const email = `john${i}@domain.tld`;
    const password = '123456';
    const photoURL = `https://picsum.photos/200/300?random=${Math.random()}`;

    try {
      const userRecord = await admin.auth().createUser({
        uid,
        email,
        displayName,
        password,
        photoURL,
      });

      usersRecords.push(userRecord);

      await admin.firestore().collection('users').doc(uid).set({
        uid,
        displayName,
        photoURL,
      });

      info('Successfully created new user:', userRecord.uid);
    } catch (error) {
      info('Error creating new user:', error);
    }
  }

  return usersRecords;
};

exports.userFactory = userFactory;

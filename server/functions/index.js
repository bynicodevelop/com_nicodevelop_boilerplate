const functions = require('firebase-functions');
const admin = require('firebase-admin');
const {info} = require('firebase-functions/lib/logger');
const {userFactory, createChat} = require('./datasets');

const {UserController} = require('./controllers/user_controller');

admin.initializeApp();

const userController = new UserController();

const isDevelopmentMode = process.env.FUNCTIONS_EMULATOR;

exports.onCreateNewUser = functions
    .auth
    .user()
    .onCreate(async (user) => userController.onCreateNewUser(user));

exports.onNewUserInAffiliate = functions
    .firestore
    .document('users/{userId}')
    .onCreate(async (snapshot, context) =>
      userController.onNewUserInAffiliate(snapshot, context));

if (isDevelopmentMode) {
  exports.createUsers = functions.https.onRequest(async (req, res) => {
    const usersRecords = await userFactory(10);

    const listChatPromise = [];

    for (const element of usersRecords) {
      const user = element;

      for (const element of usersRecords) {
        const user2 = element;

        if (user.uid !== user2.uid) {
          listChatPromise.push(createChat([user, user2]));

          info('Chat created between', user.uid, 'and', user2.uid);
        }
      }
    }

    await Promise.all(listChatPromise);

    res.json(usersRecords);
  });
}

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const {userFactory} = require('./datasets');

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

    res.json(usersRecords);
  });
}

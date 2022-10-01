const functions = require('firebase-functions');
const admin = require('firebase-admin');
const {info, error} = require('firebase-functions/lib/logger');
const {userFactory, createChat} = require('./datasets');
const _ = require('lodash');

admin.initializeApp();

const isDevelopmentMode = process.env.FUNCTIONS_EMULATOR;

const getAffiliateSettings = async () => admin.firestore()
    .collection('settings')
    .doc('affiliates')
    .get();

const updateNumberUsers = async () => {
  const settingsAffiliatesSnapshot = await getAffiliateSettings();

  if (!settingsAffiliatesSnapshot.exists) {
    await admin.firestore().collection('settings').doc('affiliates').set({
      total: 1,
    });

    return;
  }

  await admin.firestore().collection('settings').doc('affiliates').update({
    total: admin.firestore.FieldValue.increment(1),
  });
};

const generateAffiliateCode = (total) => total.toString().padStart(4, '0');

const addNewUserInAffiliate = async (userRef, affiateCodeRef) => {
  info('addNewUserInAffiliate', {userRef, affiateCodeRef});

  if (_.isUndefined(affiateCodeRef)) {
    error('affiateCodeRef is undefined', {
      userRef,
    });

    return;
  }

  await affiateCodeRef.update({
    total: admin.firestore.FieldValue.increment(1),
    users: admin.firestore.FieldValue.arrayUnion(userRef),
  });
};

exports.onNewUser = functions
    .auth
    .user()
    .onCreate(async (user) => {
      const {uid: userId} = user;

      await updateNumberUsers();

      const settingsAffiliatesSnapshotResult = await getAffiliateSettings();

      const settingsAffiliates = settingsAffiliatesSnapshotResult.data();

      const {total} = settingsAffiliates;

      const affiliateCode = generateAffiliateCode(total);

      await admin.firestore().collection('affiliates').doc(affiliateCode).set({
        userId,
      });
    });

exports.onNewUserInAffiliate = functions
    .firestore
    .document('users/{userId}')
    .onCreate(async (snapshot, context) => {
      const {userId} = context.params;
      const {affiliateCodeRef} = snapshot.data();

      info('onNewUserInAffiliate', {userId, affiliateCodeRef});

      await addNewUserInAffiliate(
          admin.firestore().collection('users').doc(userId),
          affiliateCodeRef,
      );
    });

if (isDevelopmentMode) {
  exports.createUsers = functions.https.onRequest(async (req, res) => {
    const usersRecords = await userFactory(10);

    const listChatPromise = [];

    // Generate chat between 2 users
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

const admin = require('firebase-admin');

exports.setAffiliateCodeForUserId = async (affiliateCode, userId) => admin
    .firestore()
    .collection('affiliates')
    .doc(affiliateCode)
    .set({
      userId,
    });

const _ = require('lodash');
const admin = require('firebase-admin');
const {info, error} = require('firebase-functions/logger');
const {formatAffiliateCode} = require('../utils/affiliate');

/**
 * UserController
 */
class UserController {
  /**
   *
   */
  async _getAffiliateSettings() {
    return await admin.firestore()
        .collection('settings')
        .doc('affiliates')
        .get();
  }

  /**
   *
   */
  async _updateNumberUsers() {
    const settingsAffiliatesSnapshot = await this._getAffiliateSettings();

    if (!settingsAffiliatesSnapshot.exists) {
      await admin.firestore().collection('settings').doc('affiliates').set({
        total: 1,
      });

      return;
    }

    await admin.firestore().collection('settings').doc('affiliates').update({
      total: admin.firestore.FieldValue.increment(1),
    });
  }

  /**
   * @param {Object} userRef
   * @param {Object} affiateCodeRef
   */
  async _addNewUserInAffiliate(userRef, affiateCodeRef) {
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
  }
  /**
   * @param {Object} user
   */
  async onCreateNewUser(user) {
    const {uid: userId} = user;

    await this._updateNumberUsers();

    const settingsAffiliatesSnapshotResult = await this._getAffiliateSettings();

    const settingsAffiliates = settingsAffiliatesSnapshotResult.data();

    const {total} = settingsAffiliates;

    const affiliateCode = formatAffiliateCode(total);

    await setAffiliateCodeForUserId(affiliateCode, userId);
  }

  /**
   * @param {Object} snapshot
   * @param {Object} context
   */
  async onNewUserInAffiliate(snapshot, context) {
    const {userId} = context.params;
    const {affiliateCodeRef} = snapshot.data();

    if (_.isUndefined(affiliateCodeRef)) return;

    info('onNewUserInAffiliate', {userId, affiliateCodeRef});

    await this._addNewUserInAffiliate(
        admin.firestore().collection('users').doc(userId),
        affiliateCodeRef,
    );
  }
}

exports.UserController = UserController;

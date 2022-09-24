const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { error, info } = require("firebase-functions/lib/logger");

admin.initializeApp();

const getAffiliateSettings = async () => admin.firestore().collection("settings").doc("affiliates").get();

const updateNumberUsers = async () => {
    const settingsAffiliatesSnapshot = await getAffiliateSettings();

    if(!settingsAffiliatesSnapshot.exists) {
        await admin.firestore().collection("settings").doc("affiliates").set({
            total: 1
        });

        return;
    }

    await admin.firestore().collection("settings").doc("affiliates").update({
        total: admin.firestore.FieldValue.increment(1)
    });
}

const generateAffiliateCode = (total) => total.toString().padStart(4, "0");

const addNewUserInAffiliate = async (userRef, affiateCodeRef) => {
    info("addNewUserInAffiliate", { userRef, affiateCodeRef });

    await affiateCodeRef.update({
        total: admin.firestore.FieldValue.increment(1),
        users: admin.firestore.FieldValue.arrayUnion(userRef)
    });
}

exports.onNewUser = functions
    .auth
    .user()
    .onCreate(async (user) => {
        const { uid: userId } = user;

        await updateNumberUsers();

        const settingsAffiliatesSnapshotResult = await getAffiliateSettings();

        const settingsAffiliates = settingsAffiliatesSnapshotResult.data();

        const { total } = settingsAffiliates;

        const affiliateCode = generateAffiliateCode(total);

        await admin.firestore().collection("affiliates").doc(affiliateCode).set({
            userId,
        });
    });

exports.onNewUserInAffiliate = functions
    .firestore
    .document("users/{userId}")
    .onCreate(async (snapshot, context) => {
        const { userId } = context.params;
        const { affiliateCodeRef } = snapshot.data();

        info("onNewUserInAffiliate", { userId, affiliateCodeRef });

        await addNewUserInAffiliate(
            admin.firestore().collection("users").doc(userId),
            affiliateCodeRef
        );
    });
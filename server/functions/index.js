const functions = require("firebase-functions");
const admin = require("firebase-admin");

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


exports.onNewUser = functions.auth.user().onCreate(async (user) => {
    const { uid: userId } = user;

    await updateNumberUsers();

    const settingsAffiliatesSnapshotResult = await getAffiliateSettings();

    const settingsAffiliates = settingsAffiliatesSnapshotResult.data();

    const { total } = settingsAffiliates;

    const affiliateCode = generateAffiliateCode(total);

    await admin.firestore().collection("affiliates").doc(affiliateCode).set({
        userId,
    })
});
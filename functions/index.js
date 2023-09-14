const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.notifyUsersChatifyPosted = functions.firestore.document("/posts/{id}")
    .onCreate((snap, context) => {
      const data = snap.data();
      const postUserInfo = data["postUserInfo"];
      const userId = postUserInfo["userId"];

      if (userId === "J9T7jrNk4oSt9cqLrkavWOR2vfm1") {
        return admin.messaging().sendToTopic("Features", {
          notification: {
            title: "Chatify just posted",
            body: data["text"],
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        });
      }
    });

exports.sendPersonalizedNotification = functions.https
    .onCall(async (data, context) => {
      const { token, username, message } = data;
  
      if (!token || !message) {
        throw new functions.https.HttpsError('invalid-argument', 'Invalid data provided.');
      }

      try {
        const payload = {
          notification: {
            title: username,
            body: message,
          },
        };

        const response = await admin.messaging().send(token, payload);

        const result = response.results[0];

        if (result.error) {
          console.error(`Failed to send notification to ${token}: ${result.error}`);
          return {
            success: false,
            message: `Failed to send notification: ${result.error}`,
          };
        } else {
          console.log(`Notification sent to ${token}`);
          return {
            success: true,
            message: 'Notification sent successfully',
          };
        }
      } catch (error) {
        console.error(`Error sending notification: ${error}`);
        throw new functions.https.HttpsError('internal', 'Error sending notification');
      }
    });

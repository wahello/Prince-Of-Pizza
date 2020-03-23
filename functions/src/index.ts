import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const fcm = admin.messaging();

export const sendOrderNotificationToAdmin = functions.firestore
    .document('Orders/{orderId}')
    .onCreate(async snapshot => {
        const data = snapshot.data();
        const payload: admin.messaging.MessagingPayload = {
            notification: {
                title: 'New Order!',
                body: 'click it and Accept the order ',
                icon: 'your-icon-url',
                click_action: 'FLUTTER_NOTIFICATION_CLICK'
            }
        };
        console.log("Payload: ",payload);
        console.log("Data:    ",data);
        return fcm.sendToTopic("adminMyPermission", payload);
    });
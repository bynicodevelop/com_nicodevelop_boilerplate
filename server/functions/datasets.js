const admin = require('firebase-admin');
const {info, error} = require('firebase-functions/logger');
const {faker} = require('@faker-js/faker');
const dayjs = require('dayjs');

const userFactory = async (number) => {
  const usersRecords = [];

  for (let i = 0; i < 10; i++) {
    const uid = `123456789${i}`;
    const email = `john${i}@domain.tld`;
    const password = '123456';
    const photoURL = `https://picsum.photos/200/300?random=${Math.random()}`;

    try {
      const userRecord = await admin.auth().createUser({
        uid,
        email,
        password,
        photoURL,
      });

      usersRecords.push(userRecord);

      // Create user collection to firebase
      await admin.firestore().collection('users').doc(uid).set({
        uid,
      });

      info('Successfully created new user:', userRecord.uid);
    } catch (error) {
      info('Error creating new user:', error);
    }
  }

  return usersRecords;
};

const createMessages = async (chat, users, max) => {
  info('createMessages', {chat, users, max});
  const messages = [];

  const messagesNumber = Math.floor(Math.random() * max) + 1;

  for (let i = 0; i < messagesNumber; i++) {
    const from = admin
        .firestore()
        .collection('users')
        .doc(users[Math.floor(Math.random() * users.length)].uid);

    const message = faker.lorem.sentences(Math.floor(Math.random() * 3) + 1);

    const date = dayjs()
        .subtract(Math.floor(Math.random() * 30) + 1, 'day')
        .toDate();

    const createdAt = date;
    const updatedAt = date;

    const messageRecord = {
      from,
      message,
      createdAt,
      updatedAt,
    };

    messages.push(messageRecord);

    try {
      await admin
          .firestore()
          .collection('chats')
          .doc(chat.uid)
          .collection('messages')
          .add(messageRecord);
    } catch (err) {
      error('Error creating message: ', err);
    }
  }

  return messages;
};

const createChat = async (users) => {
  const chat = {
    uid: users.map((user) => user.uid).sort().join('_'),
    users: users.map((user) => user.uid),
    lastMessage: '',
    lastMessageDate: new Date(),
  };

  try {
    await admin.firestore().collection('chats').doc(chat.uid).set(chat);

    const message = await createMessages(chat, users, 100);

    // Get last message from createdAt date
    const lastMessage = message.sort((a, b) => b.createdAt - a.createdAt)[0];

    // Update last message and last message date
    await admin.firestore().collection('chats').doc(chat.uid).update({
      lastMessage: lastMessage.message,
      lastMessageDate: lastMessage.createdAt,
    });

    info('Successfully created new chat:', chat.uid);
  } catch (err) {
    error('Error creating new chat:', err);
  }

  return chat;
};

exports.createChat = createChat;
exports.userFactory = userFactory;

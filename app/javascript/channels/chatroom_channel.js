import consumer from './consumer';

const scrollToBottom = (element) => {
  element.scrollTop = element.scrollHeight;
}

const htmlToElem = (html) => {
  const temp = document.createElement('template');
  html = html.trim();
  temp.innerHTML = html;
  return temp.content.firstChild;
}

const messagesContainer = document.querySelector('.messages--content');
if (messagesContainer) {
  scrollToBottom(messagesContainer);
  const currentUserId = document.querySelector('meta[name="current"]').content;

  consumer.subscriptions.create({ channel: "ChatChannel" }, {
    received(data) {
      const message = htmlToElem(data);
      const senderId = message.dataset.senderId;

      if (currentUserId === senderId) {
        message.classList.add('align-self-end')
      } else {
        message.classList.remove('align-self-end')
      }

      messagesContainer.appendChild(message)
      scrollToBottom(messagesContainer);
    },
  });
}
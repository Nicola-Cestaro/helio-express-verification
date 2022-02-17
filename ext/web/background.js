
chrome.runtime.onMessage.addListener(
  function (request, sender, sendResponse) {
    if (request.message === 'product') {
      let data = request.body;
      chrome.storage.local.set({ data });
      const channel = new BroadcastChannel('count-channel');
      channel.postMessage(data);
    }
    if (request.message === 'openURL') {
      let url = request.body;
      chrome.tabs.create({
        url: url
      });
    }
    sendResponse({ status: 'ok' });
    return true;
  });


const openURL = new BroadcastChannel('openURL');

openURL.onmessage = (event) => {
  chrome.tabs.create({
    url: event.data
  });
};
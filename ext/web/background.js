chrome.runtime.onMessage.addListener(
  function (request, sender, sendResponse) {
    if (request.message === 'product') {
      let data = request.body;
      chrome.storage.local.set({ data });
      const channel = new BroadcastChannel('count-channel');
      channel.postMessage(data);
    }
    sendResponse({ status: 'ok' });
    return true;
  });

//console.log("registrato");
chrome.runtime.onMessage.addListener(
  function (request, sender, sendResponse) {


    //console.log(request.message);
    if (request.message === 'buttonClicked') {
      chrome.tabs.create({
        active: true,
        url: 'index.html'
      }, null);
    }
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

    // Note: Returning true is required here!
    //  ref: http://stackoverflow.com/questions/20077487/chrome-extension-message-passing-response-not-sent
    return true;
  });

const broadcast = new BroadcastChannel('counter');
broadcast.onmessage = (event) => {
  //console.log('Received', event.data);
  //console.log('Sent', event.data);
  chrome.tabs.query({ active: true }, function (tabs) {
    //console.log('Tabs', tabs);
    chrome.tabs.sendMessage(tabs[0].id, { action: event.data }, function (response) { });
  });
};
//console.log("Broad Cast OPEN URL");
const openURL = new BroadcastChannel('openURL');
openURL.onmessage = (event) => {
  //console.log("data arrivata" + event.data);
  chrome.tabs.create({
    url: event.data
  });
};
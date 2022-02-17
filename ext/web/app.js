


// app.js
// Set up channel
const broadcast = new BroadcastChannel('count-channel');

// Listen to the response
broadcast.onmessage = (event) => {
    //console.log('Received', event.data);
    window.localStorage.setItem("id", JSON.stringify(event.data));
};

// Send first request
broadcast.postMessage({
  type: 'INCREASE_COUNT',
});

chrome.storage.local.get(["data"], ({ data }) => {
    //console.log('Received', data);
        window.localStorage.setItem("items", JSON.stringify(data));
        chrome.storage.local.clear(function() {
            var error = chrome.runtime.lastError;
            if (error) {
                console.error(error);
            }
            // do something more
        });

  });
//console.log('init');

function updateCounter(counter){
    const broadcast = new BroadcastChannel('counter');
    //console.log(counter);
    broadcast.postMessage(counter);
}

function openURL(url){
    chrome.runtime.sendMessage({message: "openURL",body: url},
    function(response) {
        if (!response.success){
            //console.log(response);
        }
    });
}

function consolelog(log){
    //console.log(log);
}
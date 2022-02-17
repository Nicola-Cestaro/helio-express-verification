


// app.js
// Set up channel

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

function openURL(url){
    chrome.runtime.sendMessage({message: "openURL",body: url},
    function(response) {
        if (!response.success){
            //console.log(response);
        }
    });
}
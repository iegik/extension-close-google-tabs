// toolbar button event listener
chrome.action.onClicked.addListener((thisTab) => {
  chrome.tabs.query({}, (tabs) => {
    for (let tab of tabs) {
      if (/^https?:\/\/(www.)?google.com/.test(tab.url))
        chrome.tabs.remove(tab.id);
      if (/-%20Google%20Search/.test(tab.url))
        chrome.tabs.remove(tab.id);
    }
  });
});

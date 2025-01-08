(function() {
  const originalHide = window.monaco.editor.suggestWidget.hide;

  window.monaco.editor.suggestWidget.hide = function(...args) {
    // Override the hide function to prevent hiding on blur
    // You can add conditions here if you want to selectively prevent hiding
    // For example, only prevent hiding when specific keys are pressed
    // For simplicity, we'll prevent it from hiding entirely

    // Do not call the original hide function
    console.log('Prevented suggestion widget from hiding on blur.');
  };

  console.log('Custom behavior for suggestion widget loaded.');
})();
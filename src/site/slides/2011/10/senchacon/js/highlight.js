    var blockNum = 0;
    function highlight(styleName) {
     if (blockNum > 0) {
      toggleHighlight(styleName + blockNum);
     }
     toggleHighlight(styleName + ++blockNum);
    }
    function toggleHighlight(className) {
     elements = document.getElementsByClassName(className);
     for (var i = 0; i < elements.length; ++i) {
       elements[i].classList.toggle("highlight");
     }
     if (elements.length == 0) {
      blockNum = 0; // start over
     }
    }

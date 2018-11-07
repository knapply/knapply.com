<script src="/js/jquery.min.js"></script>
<script src="/js/clipboard.min.js"></script>

<script>

// Clipboard

new ClipboardJS('.main');

var copyCode = new ClipboardJS('.main', {
target: function(trigger) {
return trigger.previousElementSibling;
}
});

copyCode.on('success', function(event) {
    event.clearSelection();
    event.trigger.textContent = 'COPIED!';
    window.setTimeout(function() {
        event.trigger.textContent = 'COPY';
    }, 1000);
});

copyCode.on('error', function(event) { 
    event.trigger.textContent = 'Press "Ctrl + C" to copy';
    window.setTimeout(function() {
        event.trigger.textContent = 'COPY';
    }, 1000);
});

</script>
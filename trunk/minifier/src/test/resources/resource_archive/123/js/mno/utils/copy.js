/*
$(document).ready(function () {
    $('body').bind('copy', function (e) {
        var range,
            dato = new Date(),
            copy = 'Kopiert fra &copy;' +  mno.publication.name + ' ' + dato.getDate() + '.' + dato.getMonth() + '.' + dato.getFullYear() + ' - ' + window.location.href;
        if  (window.getSelection) {
            var el = document.createElement('p'),
                    selection = window.getSelection();

            range = selection.getRangeAt(0);

            el.innerHTML = copy;
            el.setAttribute('style', 'font-size:1px; line-height:1px;text-indent:-10000px;color:#fff;');

            range.insertNode(el);
            range.setStart(el, 0);

            selection.removeAllRanges();
            selection.addRange(range);

            setTimeout(function () {
                $(el).remove();
            },100);
        }
    });
});
*/
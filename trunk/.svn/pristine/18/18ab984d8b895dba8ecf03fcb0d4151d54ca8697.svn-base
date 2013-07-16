mno.namespace("mno.utils");

mno.utils.bookmarksite = function(title,url){
    if (window.sidebar) // firefox
        window.sidebar.addPanel(title, url, "");
    else if(window.opera && window.print){ // opera
        var elem = document.createElement('a');
        elem.setAttribute('href',url);
        elem.setAttribute('title',title);
        elem.setAttribute('rel','sidebar');
        elem.click();
    }
    else if(document.all){
        // ie

        window.external.AddFavorite(url, title);
    }
    else if(window.opera && window.print){
        alert('Press ctrl+D to bookmark (Command+D for macs) after you click Ok');
    } else if(window.chrome){
        alert('Press ctrl+D to bookmark (Command+D for macs) after you click Ok');
    }
};


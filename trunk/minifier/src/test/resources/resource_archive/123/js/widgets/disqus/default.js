var disqus_shortname = ''; // required: replace example with your forum shortname  this is set in the model.jsp because it takes time for it to load

// The following are highly recommended additional parameters. Remove the slashes in front to use.
var disqus_identifier, disqus_url, disqus_developer = 1, disqus_title; // developer mode is on
/* * * DON'T EDIT BELOW THIS LINE * * */
mno.core.register({
    id: 'widget.disqus.default',
    creator: function (sandbox) {
        var $ = sandbox.$;
        return {
            init: function(){
                if(typeof sandbox.container !== "undefined" && sandbox.container !== null && sandbox.container.length > 0){
                    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
                    // The following are highly recommended additional parameters. Remove the slashes in front to use.
                    if((mno.model.article.source == 'escenic-migration') && (mno.publication.name == 'sa' || mno.publication.name == 'ap')){
                        disqus_identifier = mno.model.article.sourceId;
                    }else{
                        disqus_identifier = mno.model.article.id;
                    }
                    disqus_title = mno.model.article.TITLE;
                    disqus_url = window.location.href; /*document.getElementsByTagName('title')[0].innerHTML;*/ /*'http://http://bttest2.medianorge.no/bt/';*/
                    disqus_shortname =  (function(){
                        try{
                            return (typeof mno.publication.disqus.shortname !== "undefined" ? mno.publication.disqus.shortname : "");
                        }catch(e){

                            return "";
                        }
                    }());
                    disqus_developer = (function(){
                        try{
                            return parseInt(typeof mno.publication.disqus.developer !== "undefined" ? mno.publication.disqus.developer : 1)
                        }catch(e){
                            mno.core.log(2,"could not parse DISQUSDEVELOPER return 1 as default");
                            return 1;
                        }
                    }());

                    if(disqus_shortname !== ''){
                        sandbox.getScript({
                            url: 'http://' + disqus_shortname + '.disqus.com/embed.js',
                            callback: function(){
                                /*if(window.jQuery('body').width() <= 320){
                                 sandbox.container.find('#dsq-post-as').css('width',(window.jQuery('body').width() - 5) + 'px');
                                 } */
                            }

                        });
                    }else{
                        mno.core.log(2,"disqus short name not set");
                    }
                }



            },
            destroy: function(){


            }
        };
    }
});



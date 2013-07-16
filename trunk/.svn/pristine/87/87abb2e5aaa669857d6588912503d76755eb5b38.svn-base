mno.core.register({
    id:'widget.mobileStoryContent.article',
    creator:function (sandbox) {

        //TODO Better way to initiate uiresources
        function init() {
            var model = sandbox.model;
            sandbox.container.each(function(i) {
                if (model[i].hasOwnProperty('javascript') === true) {
                    model[i]['javascript'](sandbox);
                }
            });

            /* replace Smiley code with icons */
            var storyContentBodyText = sandbox.container.find('.mobileStoryContent.bodyText'),
                storyContentBodyTextHtml = storyContentBodyText.html();
            if (storyContentBodyTextHtml.indexOf('{smile}') > 0 ||
                storyContentBodyTextHtml.indexOf('{sad}') > 0 ||
                storyContentBodyTextHtml.indexOf('{numb}') > 0) {
                storyContentBodyText.html( function(index, oldhtml) {
                    return oldhtml.replace(/\{smile\}/g,'<span class="icon smiley smile">)</span>')
                        .replace(/\{sad\}/g,'<span class="icon smiley sad">(</span>')
                        .replace(/\{numb\}/g,'<span class="icon smiley numb">|</span>');
                });
            }
        }
        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});
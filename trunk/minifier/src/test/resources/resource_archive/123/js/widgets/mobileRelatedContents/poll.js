mno.core.register({
    id:'widget.mobileRelatedContents.poll',
    extend:['widget.poll.default'],
    creator:function (sandbox) {

        function init() {
            var runPoll = this.pollHelper;

            if (sandbox.container) {
                sandbox.container.each(function(i, element){
                    var model = sandbox.model[i];
                    if(model.polls !== undefined) {
                        runPoll(element, model);
                    }
                });                                                                                                                                                                 //
            }
        }

        function destroy() {}

        return {
            init:init,
            destroy:destroy
        }
    }
});


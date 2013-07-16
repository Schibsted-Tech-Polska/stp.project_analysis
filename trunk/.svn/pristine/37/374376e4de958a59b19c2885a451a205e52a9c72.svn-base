mno.core.register({
    id:'widget.personalia.searchbox',
    creator:function (sandbox) {

        function init() {
            if(sandbox.container){
                var eSearchMode = sandbox.container.find('input[name=srchMode]'),
                    eDateChoice = sandbox.container.find('div.dateChoice');

                sandbox.container.find('button.dateChoice').on('click', function(e){

                    eSearchMode.val(function(i, v){
                        return v==='smpl' ? 'adv' : 'smpl';
                    });

                    eDateChoice.slideToggle();

                    e.preventDefault();
                    return false;
                });

            }
        }

        function destroy() {
        }

        return {
            init:init,
            destroy:destroy
        }
    }
});
mno.core.register({
    id:'widget.user.actions',
    forceStart:true,
    creator: function (sandbox) {
        function init() {
            if (typeof localStorage !== 'undefined') {
                var sections = localStorage.getItem('mno_sections') || '{}';

                sections = JSON.parse(sections);
                sections[mno.publication.currentSectionId] = sections[mno.publication.currentSectionId] + 1 || 1;

                sandbox.notify({
                    type:'user-sections',
                    data:sections
                });

                localStorage.setItem('mno_sections', JSON.stringify(sections));
            }
        }
        function destroy () {}
        return {
            init:init,
            destroy:destroy
        }
    }
});
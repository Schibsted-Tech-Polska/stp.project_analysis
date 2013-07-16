mno.core.register({
    id:'mno.utils.flash',
    forceStart: true,
    creator: function () {
        return {
            init:function () {},
            showFlash:function (flashModel){
                swfobject.embedSWF(flashModel.url, flashModel.elementId, flashModel.width, flashModel.height, flashModel.version, "expressInstall.swf", flashModel.flashVars, flashModel.params, flashModel.attributes);
                $('#'+flashModel.fallbackElementId).hide();
                $('#'+flashModel.fallbackElementId+'-caption').hide();
            },
            destroy:function () {}
        };
    }
});
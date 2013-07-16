mno.namespace('QUnit');

mno.QUnit = function() {
    $(document).ready(function () {
        $('#QUnitButton').bind('click', function () {
            mno.QUnit.run();
            return false;
        });
    });
    function _recursiveLookup(obj) {
        var key;

        if (obj.hasOwnProperty('id') && typeof obj.id === 'string') {
            module(obj.id);
        }

        if (obj.hasOwnProperty('QUnitTest')) {
            obj.QUnitTest();
        }

        for (key in obj) {
            if (obj.hasOwnProperty(key)) {

                if (typeof obj[key] === 'object') {
                    _recursiveLookup(obj[key])
                }
            }
        }
    }

    if (mno.utils.params.getParameter('runAll')) {
        mno.core.startAll();
    }

    /**
     * Run all QUnit test
     * Loops though every object and widget and run the QUnit method
     */
    function run() {
        _recursiveLookup(mno);
        _recursiveLookup(mno.core.getModuleData());
    }

    return {
        run:run
    }
}();
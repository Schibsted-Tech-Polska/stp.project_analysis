mno.namespace('utils.match');

/**
 * Utility for testing or replacing common regex patterns
 * @param type Type of pattern
 * @param source String to test
 * @param test Set to 'match' if you wish to return the matches
 */
mno.utils.pattern = function (cmd, type, source, replace) {
    // Default is test.
    cmd = cmd || 'test';
    replace = replace || '';
    var pattern = {
        // See http://daringfireball.net/2010/07/improved_regex_for_matching_urls
        url: /\b((?:[a-z][\w-]+:(?:\/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))/gi,
        email: /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/,
        twitterUser: /(^|[\W])@(\w+)/gi,
        twitterHash: / [\#]+([A-Za-z0-9-_]+)/gi
    }                        ;
    if (pattern.hasOwnProperty(type)) {
        if (cmd === 'replace') {
            return source.replace(pattern[type], replace);
        }
        return source[cmd](pattern[type]);
    } else {
        mno.core.log(1, type + ' is not a pattern');
        return false;
    }
};
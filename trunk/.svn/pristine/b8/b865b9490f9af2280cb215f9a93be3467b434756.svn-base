/**
 * Strips strings from HTML tags
 * @return String
 */
String.prototype.strip_tags = function() {
    return this.replace(/<\w+(\s+("[^"]*"|'[^']*'|[^>])+)?>|<\/\w+>/gi, '');
}

/**
 * Strips String from unneccesary white characters.
 * @return String
 */
String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, '');
}

/** Use this string as a format like "{0} something {1}" to output data
 * @param args [Array] replacement data
 * @return formatted data
 * */
String.prototype.format = function(args) {
    return this.replace(/{(\d+)}/g, function (match, number) {
        return typeof args[number] != 'undefined'
            ? args[number]
            : match
            ;
    })
}


/**
 * Removes national characters - converts "zażółć gęślą jaźń" to "zazolc gesla jazn"
 * @param charCase -1 for lowercasization, 0 for none, 1 for uppercase
 * @param codish convert spaces and punctuation to underscores
 */
String.prototype.denationalize = function (charCase, codish) {

    // http://mynthon.net/howto/-/strip-accents-romove-national-characters-replace-diacritic-chars.txt

    var conv_from, conv_to, o, r, i;
    var s = this;

    if (typeof(codish) == 'undefined') {
        codish = false;
    }

    // if character case for output string is not set set it to 0,
    // or -1 (lowercase) for codifying
    if (typeof(charCase) == 'undefined') {
        charCase = codish ? -1 : 0;
    }

    // convertion table.
    conv_from = ['É', 'Ê', 'Ë', 'š', 'Ì', 'Í', 'ƒ', 'œ', 'µ', 'Î', 'Ï', 'ž', 'Ð', 'Ÿ', 'Ñ', 'Ò', 'Ó', 'Ô', 'Š', '£', 'Õ', 'Ö', 'Œ', '¥', 'Ø', 'Ž', '§', 'À', 'Ù', 'Á', 'Ú', 'Â', 'Û', 'Ã', 'Ü', 'Ä', 'Ý', 'Å', 'Æ', 'ß', 'Ç', 'à', 'È', 'á', 'â', 'û', 'Ĕ', 'ĭ', 'ņ', 'ş', 'Ÿ', 'ã', 'ü', 'ĕ', 'Į', 'Ň', 'Š', 'Ź', 'ä', 'ý', 'Ė', 'į', 'ň', 'š', 'ź', 'å', 'þ', 'ė', 'İ', 'ŉ', 'Ţ', 'Ż', 'æ', 'ÿ', 'Ę', 'ı', 'Ŋ', 'ţ', 'ż', 'ç', 'Ā', 'ę', 'Ĳ', 'ŋ', 'Ť', 'Ž', 'è', 'ā', 'Ě', 'ĳ', 'Ō', 'ť', 'ž', 'é', 'Ă', 'ě', 'Ĵ', 'ō', 'Ŧ', 'ſ', 'ê', 'ă', 'Ĝ', 'ĵ', 'Ŏ', 'ŧ', 'ë', 'Ą', 'ĝ', 'Ķ', 'ŏ', 'Ũ', 'ì', 'ą', 'Ğ', 'ķ', 'Ő', 'ũ', 'í', 'Ć', 'ğ', 'ĸ', 'ő', 'Ū', 'î', 'ć', 'Ġ', 'Ĺ', 'Œ', 'ū', 'ï', 'Ĉ', 'ġ', 'ĺ', 'œ', 'Ŭ', 'ð', 'ĉ', 'Ģ', 'Ļ', 'Ŕ', 'ŭ', 'ñ', 'Ċ', 'ģ', 'ļ', 'ŕ', 'Ů', 'ò', 'ċ', 'Ĥ', 'Ľ', 'Ŗ', 'ů', 'ó', 'Č', 'ĥ', 'ľ', 'ŗ', 'Ű', 'ô', 'č', 'Ħ', 'Ŀ', 'Ř', 'ű', 'õ', 'Ď', 'ħ', 'ŀ', 'ř', 'Ų', 'ö', 'ď', 'Ĩ', 'Ł', 'Ś', 'ų', 'Đ', 'ĩ', 'ł', 'ś', 'Ŵ', 'ø', 'đ', 'Ī', 'Ń', 'Ŝ', 'ŵ', 'ù', 'Ē', 'ī', 'ń', 'ŝ', 'Ŷ', 'Ə', 'ú', 'ē', 'Ĭ', 'Ņ', 'Ş', 'ŷ'];
    conv_to   = ['E', 'E', 'E', 's', 'I', 'I', 'f', 'o', 'm', 'I', 'I', 'z', 'D', 'Y', 'N', 'O', 'O', 'O', 'S', 'L', 'O', 'O', 'O', 'Y', 'O', 'Z', 'S', 'A', 'U', 'A', 'U', 'A', 'U', 'A', 'U', 'A', 'Y', 'A', 'A', 'S', 'C', 'a', 'E', 'a', 'a', 'u', 'E', 'i', 'n', 's', 'Y', 'a', 'u', 'e', 'I', 'N', 'S', 'Z', 'a', 'y', 'E', 'i', 'n', 's', 'z', 'a', 'p', 'e', 'I', 'n', 'T', 'Z', 'ae','y', 'E', 'l', 'n', 't', 'z', 'c', 'A', 'e', 'I', 'n', 'T', 'Z', 'e', 'a', 'E', 'i', 'O', 't', 'z', 'e', 'A', 'e', 'J', 'o', 'T', 'i', 'e', 'a', 'G', 'j', 'O', 't', 'e', 'A', 'g', 'K', 'o', 'U', 'i', 'a', 'G', 'k', 'O', 'u', 'i', 'C', 'g', 'k', 'o', 'U', 'i', 'c', 'G', 'L', 'O', 'u', 'i', 'C', 'g', 'l', 'o', 'U', 'o', 'c', 'G', 'L', 'R', 'u', 'n', 'C', 'g', 'l', 'r', 'U', 'o', 'c', 'H', 'L', 'R', 'u', 'o', 'C', 'h', 'l', 'r', 'U', 'o', 'c', 'H', 'L', 'R', 'u', 'o', 'D', 'h', 'l', 'r', 'U', 'o', 'd', 'I', 'L', 'S', 'c', 'D', 'i', 'l', 's', 'W', 'o', 'd', 'I', 'N', 'S', 'w', 'u', 'E', 'i', 'n', 's', 'Y', 'e', 'u', 'e', 'I', 'N', 'S', 'y'];

    if (codish) {
        // add some more
        conv_from.push(' ', ':', ';', '.', ',');
        conv_to.push('_', '_', '_', '_', '_');
    }
    // If charactes wasn't in convertion table and it is not a [a-zA-z0-9_-] convert it to this char
    o = '';

    // iterate over convertion tables and replace every char in string
    for (i = 0; i < conv_from.length; i++) {
        r = new RegExp('[' + conv_from[i] + ']', 'g');
        s = s.replace(r, conv_to[i]);
    }

    if (codish) {
        // remove every character not found in convertion table
        s = s.replace(/[^a-zA-Z0-9_-]/gi, o);
    }

    // some optimization - you can change it if you change conversion tables
    // here I replace multiple underscores into one undercore and strip
    // underscores at begining and ehd of string
    s = s.replace(/[_]+/, '_');
    s = s.replace(/^_*(.*?)_*$/gi, '$1');

    // return converted string
    if (charCase == -1) {
        return s.toLowerCase();
    } else if (charCase == 1) {
        return s.toUpperCase();
    } else {
        return s;
    }
}
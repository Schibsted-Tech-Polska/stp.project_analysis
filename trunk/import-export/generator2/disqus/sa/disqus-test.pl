#!/usr/bin/perl
use XML::Simple;
use LWP::Simple;
use Net::SCP;
$xml = new XML::Simple;
#VARIABLER
my $DAY=24 * 60 * 60;
my $NOW=time();
my $YESTERDAY=$NOW-$DAY;
@URLS=('http://disqus.com/api/3.0/threads/listPopular.jsonp?api_key=deLKaENaysQEOkzVcU90xJ6C8oAfIxwK1H8BNYz5g7FpBKyEHbxyEi5SNWjERDEW&forum=aftenbladet&limit=15&callback=mno.callbacks.disqusMostCommented&since=' . $YESTERDAY,'http://disqus.com/api/3.0/forums/listPosts.jsonp?api_key=deLKaENaysQEOkzVcU90xJ6C8oAfIxwK1H8BNYz5g7FpBKyEHbxyEi5SNWjERDEW&forum=aftenbladet&related=thread&limit=15&callback=mno.callbacks.disqusLatestPosts');
@FILES=('mostcommented.json','latestposts.json');
my $NR=0;
my $SEARCHWORD = 'aftenbladet';
my $ERRORFILE = 'disqus-feilfil.xml';
my $TID = localtime(time);
@SCPHOSTS = ('satest2.medianorge.no');
my $SCPUSER = 'mno';
my $SCPDIR  = '/data/external/disqus';
my $HOSTNR=0;

foreach (@URLS){
    my $FILENAME = $FILES[$NR];
    my(@content) = get($URLS[$NR]);
    my $error = 1;
    foreach my $line (@content) {
        if($line =~ /$SEARCHWORD/) {
            $error = 0;
        }
    }
    if($error == 1) {
        open LOGFILE, ">>/home/mno/disqus/sa/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {
        open FILE, '>/home/mno/disqus/sa/data-test/' . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("/home/mno/disqus/sa/data-test/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}


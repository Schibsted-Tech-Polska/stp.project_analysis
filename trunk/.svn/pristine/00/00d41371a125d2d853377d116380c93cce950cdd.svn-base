#!/usr/bin/perl
use XML::Simple;
use LWP::Simple;
use Net::SCP;
$xml = new XML::Simple;
#VARIABLER
my $DAY=24 * 60 * 60;
my $NOW=time();
my $YESTERDAY=$NOW-$DAY;
@URLS=('http://disqus.com/api/3.0/threads/listPopular.jsonp?api_key=tHdNDUT7OLLd6J8rUjqCJmAAp3MYbBsXn7229VRPFjRUicGNBCGZxa9xUlItiDZV&forum=bergenstidene&limit=15&callback=mno.callbacks.disqusMostCommented&since=' . $YESTERDAY,'http://disqus.com/api/3.0/forums/listPosts.jsonp?api_key=tHdNDUT7OLLd6J8rUjqCJmAAp3MYbBsXn7229VRPFjRUicGNBCGZxa9xUlItiDZV&forum=bergenstidene&related=thread&limit=15&callback=mno.callbacks.disqusLatestPosts');
@FILES=('mostcommented.json','latestposts.json');
my $NR=0;
my $SEARCHWORD = 'bergenstidene';
my $ERRORFILE = 'disqus-feilfil.xml';
my $TID = localtime(time);
@SCPHOSTS = ('btpub2.medianorge.no','btpub3.medianorge.no','btweb3.medianorge.no','btweb4.medianorge.no');
my $SCPUSER = 'mno';
my $SCPDIR  = '/data/external/disqus/';
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
        open LOGFILE, ">>/home/mno/disqus/bt/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {
        open FILE, '>/home/mno/disqus/bt/data/' . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("/home/mno/disqus/bt/data/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}


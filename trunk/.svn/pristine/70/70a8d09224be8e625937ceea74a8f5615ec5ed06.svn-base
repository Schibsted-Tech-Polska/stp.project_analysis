#!/usr/bin/perl
#MODULER
use XML::Simple;
use LWP::Simple;
use Net::SCP;
###################
#Parser ticket-feed
###################
$xml = new XML::Simple;
#VARIABLER
@URLS=('http://blogg.bt.no/doddo/feed/','http://blogg.bt.no/maratonmannen/feed/','http://blogg.bt.no/bolig/feed/','http://blogg.bt.no/globus/feed/','http://blogg.bt.no/faktasjekk/feed/');
@FILES=('doddo.xml','maratonmannen.xml','bolig.xml','globus.xml','faktasjekk.xml');
my $NR=0;
my $SEARCHWORD = '<rss';
my $ERRORFILE = 'blogg-feilfil.xml';
my $TID = localtime(time);
@SCPHOSTS = ('btpub2.medianorge.no','btpub3.medianorge.no','btweb3.medianorge.no','btweb4.medianorge.no','bttest2.medianorge.no');
my $SCPUSER = 'mno';
my $SCPDIR  = '/data/external/blogg/';
my $HOSTNR=0;
###################
#Looper requester
###################
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
        open LOGFILE, ">>/home/mno/blogg/bt/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {
        open FILE, '>/home/mno/blogg/bt/data/' . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("/home/mno/blogg/bt/data/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}


#!/usr/bin/perl
use XML::Simple;
use LWP::Simple;
use Net::SCP;
$xml = new XML::Simple;
#VARIABLER
@URLS=('http://ws.tv.startsiden.no/v2/channels?site=bt&api_key=6e1e7810-3a92-11e0-9ab7-002170ad4e59&with_events=1&entries_per_channel=7&channels=NRK1&channels=TV2NORGE&channels=TV3NORGE&channels=TVNORGE&channels=TVNORGEMAX','http://ws.tv.startsiden.no/v2/miniguide?site=bt&api_key=6e1e7810-3a92-11e0-9ab7-002170ad4e59');
@FILES=('bt-tvguide.xml','bt-miniguide.xml');
my $NR=0;
my $SEARCHWORD = 'result';
my $ERRORFILE = 'tvguide-feilfil.xml';
my $TID = localtime(time);
@SCPHOSTS = ('btpub2.medianorge.no','btpub3.medianorge.no','btweb3.medianorge.no','btweb4.medianorge.no','bttest2.medianorge.no');
my $SCPUSER = 'mno';
my $SCPDIR  = '/data/external/tvguide/';
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
        open LOGFILE, ">>/home/mno/tvguide/bt/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {
        open FILE, '>/home/mno/tvguide/bt/data/' . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("/home/mno/tvguide/bt/data/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}


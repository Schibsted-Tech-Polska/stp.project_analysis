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
@URLS=('http://www.aftenbladet.no/wp/xml-mnd/','http://www.aftenbladet.no/php/xml/blogg.php');
@FILES=('blogger.xml','blogg_all.xml');
my $NR=0;
my $SEARCHWORD = '<items';
my $ERRORFILE = 'blogg-feilfil.xml';
my $TID = localtime(time);
@SCPHOSTS = ('sapub2.medianorge.no','sapub3.medianorge.no','saweb3.medianorge.no','saweb4.medianorge.no','satest2.medianorge.no');
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
        open LOGFILE, ">>/home/mno/blogg/sa/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {
        open FILE, '>/home/mno/blogg/sa/data/' . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("/home/mno/blogg/sa/data/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}


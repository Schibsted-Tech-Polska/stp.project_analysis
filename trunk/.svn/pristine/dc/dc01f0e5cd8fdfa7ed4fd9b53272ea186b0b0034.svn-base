#!/usr/bin/perl
#MODULER
use XML::Simple;
use LWP::Simple;
use Net::SCP;
use utf8;
###################
#Parser ticket-feed
###################
$xml = new XML::Simple;
#VARIABLER
@URLS=('http://www.yr.no/sted/Norge/Rogaland/Stavanger/Stavanger/varsel.xml',
'http://www.yr.no/sted/Norge/Rogaland/Sandnes/Sandnes/varsel.xml',
'http://www.yr.no/sted/Norge/Rogaland/Time/Bryne/varsel.xml',
'http://www.yr.no/sted/Norge/Rogaland/Eigersund/Egersund/varsel.xml',
'http://www.yr.no/sted/Norge/Rogaland/Strand/Jørpeland/varsel.xl',
'http://api.yr.no/weatherapi/textforecast/1.5/?language=nb;forecast=landday1');
@FILES=('stavanger.xml','sandnes.xml','bryne.xml','egersund.xml','jorpeland.xml','forecast.xml');
my $NR=0;
my $SEARCHWORD = '<weather';
my $ERRORFILE = 'blogg-feilfil.xml';
my $TID = localtime(time);
@SCPHOSTS = ('sapub2.medianorge.no','sapub3.medianorge.no','saweb3.medianorge.no','saweb4.medianorge.no','satest2.medianorge.no');
my $SCPUSER = 'mno';
my $SCPDIR  = '/data/external/yr/';
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
        open LOGFILE, ">>/home/mno/yr/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {
        open FILE, '>/home/mno/yr/data/' . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("/home/mno/yr/data/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}


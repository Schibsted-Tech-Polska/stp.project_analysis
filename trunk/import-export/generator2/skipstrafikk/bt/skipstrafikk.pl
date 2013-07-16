#!/usr/bin/perl
use XML::Simple;
use LWP::Simple;
use Net::SCP;
$xml = new XML::Simple;
#VARIABLER
@URLS=('http://btpub3.medianorge.no/template/externalservices/shipTraffic/fileGenerator.jsp');
my $NR=0;
my $SEARCHWORD = 'coffee';
my $ERRORFILE = 'feilfil.xml';
my $TID = localtime(time);
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
        open LOGFILE, ">>/home/mno/skipstrafikk/bt/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    $NR++;
}


#!/usr/bin/perl
use XML::Simple;
use LWP::Simple;
use Net::SCP;
$xml = new XML::Simple;
#VARIABLER
@URLS=('http://dinmat.aftenbladet.no/layout/set/xml_ukemeny/');
@FILES=('dinmat.xml');
my $NR=0;
my $SEARCHWORD = 'menu';
my $TID = localtime(time);
@SCPHOSTS = ('sapub2.medianorge.no','sapub3.medianorge.no','saweb3.medianorge.no','saweb4.medianorge.no','satest2.medianorge.no');
my $SCPUSER = 'mno';
my $SCPDIR  = '/data/external/dinmat/';
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
        open LOGFILE, ">>/home/mno/dinmat/sa/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    }
    if($error == 0) {
        open FILE, '>/home/mno/dinmat/sa/data/' . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("/home/mno/dinmat/sa/data/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}


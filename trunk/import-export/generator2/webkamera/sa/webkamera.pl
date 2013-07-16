#!/usr/bin/perl
#MODULER
use XML::Simple;
use LWP::Simple;
use Net::SCP;
use FindBin;
###################
#Parser ticket-feed
###################
$xml = new XML::Simple;
#VARIABLER
@URLS=('http://kamera.hesbynett.no/cam/sa/kamera12.jpg','http://kamera.hesbynett.no/cam/sa/kamera04.jpg','http://kamera.hesbynett.no/cam/sa/kamera06.jpg','http://kamera.hesbynett.no/cam/sa/kamera17.jpg','http://kamera.hesbynett.no/konserthus/kamera1.php','http://kamera.hesbynett.no/konserthus/kamera2.php');
@FILES=('tau_ferjekai.jpg','vaagen_sandnes.jpg','aarsvaagen_ferjekai.jpg','tjensvoll.jpg','konserthus1.jpg','konserthus2.jpg');
my $NR=0;
my $TID = localtime(time);
@SCPHOSTS = ('sapub2.medianorge.no','sapub3.medianorge.no','saweb3.medianorge.no','saweb4.medianorge.no','satest2.medianorge.no');
my $SCPUSER = 'mno';
my $SCPDIR  = '/data/external/webkamera/';
my $HOSTNR=0;

my $SCRIPTDIR = $FindBin::Bin;

###################
#Looper requester
###################
foreach (@URLS){
    my $FILENAME = $FILES[$NR];
    my(@content) = get($URLS[$NR]);
    unless(defined(@content)) {
        open LOGFILE, ">>$SCRIPTDIR/import.log";
        print LOGFILE "$TID: FEIL - $URLS[$NR] ga feil resultat\n";
        close LOGFILE;
    } else {
        open FILE, ">", "$SCRIPTDIR/data/" . $FILENAME;
        foreach my $line (@content) {
            print FILE $line;
        }
        close FILE;
        $HOSTNR=0;
        foreach (@SCPHOSTS){
            $scp = Net::SCP->new( { "host"=>$SCPHOSTS[$HOSTNR], "user"=>$SCPUSER, timeout => 15 } );
            $scp->cwd($SCPDIR);
            $scp->put("$SCRIPTDIR/data/".$FILENAME) or die $scp->{errstr};
            $HOSTNR++;
        }$scp->quit;
    }
    $NR++;
}


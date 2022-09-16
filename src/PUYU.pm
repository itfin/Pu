package PUYU;

use strict;
use Exporter ();
use Carp;
use vars qw/@ISA @EXPORT @EXPORT_OK @EXPORT_TAGS/;
use WWW::Mechanize::Chrome;
use MozRepl::RemoteObject;
use WWW::Mechanize::Firefox;
use Data::Dmp;
$| = 1;

@ISA = qw/Exporter/;
@EXPORT =qw/puyuhi puyugo puyudn/;
@EXPORT_OK = qw//;
@EXPORT_TAGS = ( all => [@EXPORT_OK]);
my $VERSION = '0.01';

my $m;

1;

sub puyuhi{
    #   $m=WWW::Mechanize::Firefox->new(tab => 'current',repl=>MozRepl::RemoteObject->install_bridge(repl =>'192.168.1.100:4242'));
    
    $m=WWW::Mechanize::Firefox->new(tab => 'current',launch=>'/sdc/firefox/firefox',autodie => 0);
}

sub puyugo{
    my $x=shift;
    print "[GO]x=$x\n";
    $m->get($x);
    print "Please Enter to continue:\n";<>;
}

sub puyudn{
    my $x=shift;
    my $y=shift;

    print "[DN]x=$x,y=$y...";
    $m->save_url($x,$y);
    print "done\n";    

}

=pod
sub puyuhi{
    $m = WWW::Mechanize::Chrome->new(tab => 'current',background_networking => 1,web_resources => 1,json_log_file=>'/sdc/pclog.json');
}

sub puyugo{
    my $x=shift;
    print "[GO]x=$x\n";
    $m->get($x);
    print "Please Enter to continue:\n";<>;
}

sub puyudn{
    my $x=shift;
    my $y=shift;
    $m->get($x);
    my $z=$m->status();
    print "[DN]x=$x,y=$y($z)\n";    
    if(200==$z){$m->saveResources_future(target_file =>$y,target_dir  => '/tmp/',wanted=>sub { $_[0]->{url} =~ m!^https?:!i},)->get();}
}
=cut

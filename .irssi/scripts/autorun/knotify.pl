use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
$VERSION = '0.1.1';
%IRSSI = (
	authors     => 'Hugo Haas',
	contact     => 'hugo@larve.net',
	name        => 'knotify',
	description => 'An KNotification it show\'s who is talking to you, on what IRC Network.',
	url         => 'http://larve.net/people/hugo/2003/scratchpad/IrssiKnotify.html',
	license     => 'BSD',
	changed     => '$Date: 2005-01-28 01:37:13 -0800 (Fri, 28 Jan 2005) $'
);

#--------------------------------------------------------------------
# Based on osd.pl 0.3.3 by Jeroen Coekaerts, Koenraad Heijlen
# http://www.irssi.org/scripts/scripts/osd.pl
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# Private message parsing
#--------------------------------------------------------------------

sub priv_msg {
	my ($server,$msg,$nick,$address,$target) = @_;
	if ((Irssi::active_win()->get_active_name() eq "$nick") ) {
			kde_print($server->{chatnet}.":$nick");
	}
}

#--------------------------------------------------------------------
# Printing hilight's
#--------------------------------------------------------------------

sub hilight {
    my ($dest) = @_;
    if ($dest->{level} & MSGLEVEL_HILIGHT) {
	kde_print($dest->{window}->{active_server}->{chatnet}
		 . ":" . $dest->{target});
    }
}

#--------------------------------------------------------------------
# The actual printing
#--------------------------------------------------------------------

sub kde_print {
	my ($text) = @_;
    system("echo 'naughty.notify({title = \"IRSSI\", text = \"$text\", timeout = 3, position = \"bottom_right\"})' | awesome-client -");
}

#--------------------------------------------------------------------
# Irssi::signal_add_last / Irssi::command_bind
#--------------------------------------------------------------------

Irssi::signal_add_last("message private", "priv_msg");
Irssi::signal_add_last("print text", "hilight");

#- end

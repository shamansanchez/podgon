#
#   Podgon
#   Jason Stone (shamansanchez@gmail.com)
#   06 July 2016
#

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301  USA

use Purple;

%PLUGIN_INFO = (
    perl_api_version => 2,
    name => "Podgon",
    version => "1.0",
    summary => "Podgon",
    description => "Podgon",
    author => "Jason Stone",
    url => "",

    load => "plugin_load",
    unload => "plugin_unload",
    prefs_info => "prefs_info_cb"
);

sub plugin_init {
    return %PLUGIN_INFO;
}

sub plugin_load {
    $plugin = shift;
    Purple::Prefs::add_none("/plugins/core/podgon");
    $convs_handle = Purple::Conversations::get_handle();
    Purple::Signal::connect($convs_handle, "sending-im-msg", $plugin, \&sending_im_msg_cb, "xxx");
    Purple::Signal::connect($convs_handle, "receiving-im-msg", $plugin, \&receiving_im_msg_cb, "yyy");
}

sub plugin_unload {
    my $plugin = shift;
}

sub sending_im_msg_cb {
    my ($account, $who, $msg) = @_;
    $msg =~ s/i/o/g;
    $msg =~ s/I/O/g;
    $_[2] = $msg;
}

sub receiving_im_msg_cb {
    my ($account, $who, $msg, $conv, $flags) = @_;
    $msg =~ s/i/o/g;
    $msg =~ s/I/O/g;
    $_[2] = $msg;
}

sub prefs_info_cb {
    $frame = Purple::PluginPref::Frame->new();
    return $frame;
}

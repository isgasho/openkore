#########################################################################
#  OpenKore - Network subsystem
#  Copyright (c) 2006 OpenKore Team
#
#  This software is open source, licensed under the GNU General Public
#  License, version 2.
#  Basically, this means that you're allowed to modify and distribute
#  this software. However, if you distribute modified versions, you MUST
#  also distribute the source code.
#  See http://www.gnu.org/licenses/gpl.html for the full license.
#########################################################################
# fRO (France)
# 2010-06-17aRagexe
# Servertype overview: http://wiki.openkore.com/index.php/ServerType
package Network::Receive::fRO;

use strict;
use base qw(Network::Receive::ServerType0);

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new(@_);
		my %packets = (
		'0097' => ['private_message', 'v Z24 V Z*', [qw(len privMsgUser flag privMsg)]],
		'082D' => ['received_characters_info', 'v C x2 C2 x20 a*', [qw(len total_slot premium_start_slot premium_end_slot charInfo)]],
	);
	
	$self->{packet_list}{$_} = $packets{$_} for keys %packets;	

	my %handlers = qw(
		actor_exists 0915
		actor_connected 090F
		actor_moved 0914
		npc_talk 00B4
		actor_status_active 043F
		actor_action 08C8
	);	
	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;
	
	return $self;
}

1;

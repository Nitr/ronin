#
#--
# Ronin - A Ruby platform designed for information security and data
# exploration tasks.
#
# Copyright (c) 2006-2009 Hal Brodigan (postmodern.mod3 at gmail.com)
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
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#++
#

require 'ronin/ui/verbose'

module Ronin
  module UI
    module Diagnostics
      protected

      #
      # Prints the given _messages_ as info diagnostics.
      #
      def print_info(*messages)
        STDERR.puts(*(messages.map { |mesg| "[-] #{mesg}" }))
      end

      #
      # Prints the given _messages_ as debugging diagnostics,
      # if Ronin::UI::Verbose was enabled.
      #
      def print_debug(*messages)
        if Verbose.enabled?
          STDERR.puts(*(messages.map { |mesg| "[+] #{mesg}" }))
        end
      end

      #
      # Prints the given _messages_ as warning diagnostics,
      # if Ronin::UI::Verbose was enabled.
      #
      def print_warning(*messages)
        if Verbose.enabled?
          STDERR.puts(*(messages.map { |mesg| "[*] #{mesg}" }))
        end
      end

      #
      # Prints the given _messages_ as error diagnostics.
      #
      def print_error(*messages)
        STDERR.puts(*(messages.map { |mesg| "[!] #{mesg}" }))
      end
    end
  end
end

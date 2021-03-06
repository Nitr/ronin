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

require 'ronin/ui/command_line/command'
require 'ronin/platform/overlay'

module Ronin
  module UI
    module CommandLine
      module Commands
        class Add < Command

          def defaults
            @cache = nil
            @media = nil
            @uri = nil
          end

          def define_options(opts)
            opts.usage = 'PATH [options]'

            opts.options do
              opts.on('-C','--cache DIR','Specify an alternate overlay cache') do |dir|
                @cache = dir
              end

              opts.on('-m','--media MEDIA','Spedify the media-type of the overlay') do |media|
                @media = media.to_sym
              end

              opts.on('-L','--local','Similiar to: -m local') do
                @media = nil
              end

              opts.on('--rsync','Alias for -m rsync') do
                @media = :rsync
              end

              opts.on('--svn','Alias for -m svn') do
                @media = :svn
              end

              opts.on('--hg','Alias for -m hg') do
                @media = :hg
              end

              opts.on('--git','Alias for -m git') do
                @media = :git
              end

              opts.on('-U','--uri URI','Specify the source URI of the overlay') do |uri|
                @uri = uri
              end
            end

            opts.arguments(
              'PATH' => 'Add the overlay located at the specified PATH'
            )

            opts.summary %{
              Add a local overlay located at the specified PATH to the
              Overlay cache
            }
          end

          def arguments(*args)
            unless args.length == 1
              fail('only one overlay path maybe specified')
            end

            Platform.load_overlays(@cache) if @cache

            overlay_options = {:path => args.first}

            overlay_options[:media] = @media if @media
            overlay_options[:uri] = @uri if @uri

            Platform.add(overlay_options) do |overlay|
              puts "Overlay #{overlay.name.dump} added."
            end
          end

        end
      end
    end
  end
end

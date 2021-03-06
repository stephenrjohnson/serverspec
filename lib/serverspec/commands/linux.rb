require 'shellwords'

module Serverspec
  module Commands
    class Linux < Base
      class NotImplementedError < Exception; end

      def check_access_by_user file, user, access
        "su -s /bin/sh -c \"/usr/bin/test -#{access} #{file}\" #{user}"
      end

      def check_iptables_rule rule, table=nil, chain=nil
        cmd = "/sbin/iptables"
        cmd += " -t #{escape(table)}" if table
        cmd += " -S"
        cmd += " #{escape(chain)}" if chain
        cmd += " | grep -- #{escape(rule)}"
        cmd
      end

      def check_selinux mode
        "/usr/sbin/getenforce | grep -i -- #{escape(mode)}"
      end
    end
  end
end

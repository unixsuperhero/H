module H
  class Command
    class << self
      def run(args=ARGV.clone, stdin=$stdin)
        new(args, stdin).tap(&:run)
      end
    end

    attr_accessor :original_args, :args, :stdin
    attr_accessor :subcommand

    def initialize(args=ARGV.clone, stdin=$stdin)
      @original_args = args.clone
      @subcommand = args.shift
      @args = args
      @stdin = stdin
    end

    def run
      case subcommand
      # when /n(otes?)?/i
      #   Note.run(args, stdin)
      when /path/i
        system("h-path", *args)
      else
        if Env.h_command?(subcommand)
          system("h-#{subcommand}", *args)
        else
          puts format('%s command not found...', subcommand)
        end
      end
    end
  end

  def self.run(args=ARGV.clone, stdin=$stdin)
    Command.run(args, stdin)
  end
end

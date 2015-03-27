module H
  class Note < Command
    def run
      case subcommand
      when /list/i
        return 'ran "list" subcommand'
        List.run(args, stdin)
      when /save/i
        Save.run(args, stdin)
      when /p(rojects?)?/i
        H::Project.run(args, stdin)
      else
        puts format('%s command not found...', subcommand)
      end
    end
  end
end

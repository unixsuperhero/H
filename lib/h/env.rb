module H
  module Env
    extend self

    def path
      ENV['PATH']
    end

    def h_command?(bin)
      find_executable "h-#{bin}"
    end
  end

  def self.env
    Env
  end
end

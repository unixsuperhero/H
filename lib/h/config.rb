module H
  class Config
    include Singleton

    attr_accessor :original_path, :path
    attr_accessor :hero_path

    def initialize(options={})
      @original_path = Dir.pwd
      @path = options[:path] || Dir.pwd
      @hero_path = format('%s/hero', ENV['HOME'])
    end
  end

  def self.config
    @config ||= Config.instance
  end
end

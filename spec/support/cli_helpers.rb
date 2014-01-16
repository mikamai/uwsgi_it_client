module CLIHelpers
  def self.included base
    base.before :each do
      ENV['THOR_DEBUG'] = '1'
    end
  end

  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

  def exec command, args = []
    capture :stdout do
      UwsgiItClient::CLI.start [command].concat args
    end
  end
end
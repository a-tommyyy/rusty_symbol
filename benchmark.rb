require "rusty_symbol"
require "benchmark/ips"

class Symbol
  def _start_with?(*argv)
    self.to_s.start_with?(*argv.map(&:to_s))
  end

  def _end_with?(*argv)
    self.to_s.end_with?(*argv.map(&:to_s))
  end
end

Benchmark.ips do |x|
  x.report "Ruby" do
    5_000_000.times do
      :some_symbol._start_with?(:foo, :baz, :bar, :some)
    end
  end

  x.report "Rust" do
    5_000_000.times do
      :some_symbol.start_with?(:foo, :baz, :bar, :symbol)
    end
  end

  x.compare!
end


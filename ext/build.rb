require 'thermite/tasks'

Thermite::Config.prepend(
  Module.new do
    def shared_library
      @shared_library ||= "#{library_name}.#{RbConfig::CONFIG["DLEXT"] || 'so'}"
    end

    def ruby_extension_dir
      @ruby_extension_dir ||= @options.fetch(:ruby_extension_dir, 'lib')
    end

    def ruby_extension_path
      ruby_path(ruby_extension_dir, shared_library)
    end
  end
)

project_dir = File.expand_path('..', __dir__)
Thermite::Tasks.new(
  cargo_project_path: project_dir,
  ruby_project_path: project_dir,
  ruby_extension_dir: "lib/rusty_symbol"
)

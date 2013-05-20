class Nyx
  class Configurator

    attr_reader :tag
    attr_reader :yaml

    def initialize tag
      @tag = tag
      load_yaml
    end

    def load_yaml
      @yaml = YAML.load_file(yml_path)
      @yaml[Nyx.env.env].keys.each do |key|
        define_singleton_method key.to_sym do
          @yaml[Nyx.env.env][key]
        end
      end
    end

    def yml_path
      File.join(Nyx.env.root, "config", tag.to_s + ".yml")
    end

  end
end

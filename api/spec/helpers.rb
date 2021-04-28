module Helpers
  def get_fixture(item)
    examples = YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
  end

  def get_thumb(file_name)
    return File.open(File.join(Dir.pwd, "spec/fixtures/images", file_name), "rb")
    #rb serve para gravar o conteúdo do arquivo, no formato binário, dentro de "thumbnail"
  end

  module_function :get_fixture
  module_function :get_thumb
end

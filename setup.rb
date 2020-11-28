# This file is making SceneManager Template
require 'fileutils'

require_relative "setup/template/main"
require_relative "setup/template/scene"
require_relative "setup/template/loading"


def ask(message, pattern = /^\w$|^\w.*\w$/)
  input = ""
  until input =~ pattern
    print message
    input = gets
  end
  puts("    OK")
  input.chomp
end

# def delete_comment(target)
#   target.gsub(/\n\s*\#.*/, "")
# end


puts "[ Make SceneManager Template ]"
project_name = ask(" 1. your project name here > ")
scenes = ask(" 2. What scenes to add? (example: > title play) > ").split

# more_setting = ask(" 3. Want more settings?(y/N) (Skip with empty) > ", /^(y|n|\n)$/i)
# if more_setting.downcase == "y"
#   comment = ask(" 3. Do you want the program comment?(Y/n) (Skip with empty) > ", /^y|n|\n$/i)
#   write_comment = comment.downcase == "y" || comment == ""
# end

scenes_class = []
scenes_sybol = []
scenes.each do |s|
  scenes_class << s.gsub(/(^|\_)(\w)/) {$2.upcase}
  scenes_sybol << s.to_sym
end


require_scnes = scenes.map {|w| %Q(require_relative "scenes/#{w}")}
require_scnes.unshift %Q(require_relative "scenes/loading")

args = "{\n"
scenes.length.times {|i| args += "  #{scenes[i]}: #{scenes_class[i]},\n"}
args = args.chomp.chop + "\n}"

main_file = $main_template.sub(/REQUIRE_SCENES/, require_scnes.join("\n"))
main_file.sub!(/ARGS/, args)


path = File.dirname(__FILE__)
proj_path = File.join(path, project_name)
scene_path = File.join(proj_path, "scenes")

if File.exist?(proj_path)
  raise NameError.new("Project Name `#{project_name}` is already exist!")
end

# exec
Dir::mkdir(proj_path)
Dir::mkdir(scene_path)
FileUtils.cp("scene-manager.rb", File.join(proj_path, "scene-manager.rb"))
# FileUtils.cp("setup/template/loading.rb", File.join(scene_path, "loading.rb"))

open(File.join(proj_path, "main.rb"), 'w') do |f|
  f.puts main_file
end

scenes.length.times do |i|
  path = File.join(scene_path, "#{scenes[i]}.rb")
  open(path, 'w') do |f|
    f.puts $scene_template.gsub(/SCENE_NAME/, "#{scenes_class[i]}")
  end
end

open(File.join(scene_path, "loading.rb"), 'w') do |f|
  f.puts $loading_template
end

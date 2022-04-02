require "optparse"

def run
  options = ARGV.getopts("", "dry-run")
  target_paths = find_all_target_path
  create_symbolic_links(target_paths, options["dry-run"])
  puts "complete!"
end

def find_all_target_path
  Dir.glob('home/*', File::FNM_DOTMATCH).select { |path| File.file?(path) }
end

def create_symbolic_links(target_paths, dry_run)
  pwd = Dir.pwd
  home_dir = Dir.home
  target_paths.each do |target_path|
    src_path = "#{pwd}/#{target_path}"
    dest_path = "#{home_dir}#{target_path.delete_prefix('home')}"
    if File.exist?(dest_path)
      puts "Using #{dest_path}"
    else
      if dry_run
        puts "ln -s #{src_path} #{dest_path}"
      else
        `ln -s #{src_path} #{dest_path}`
        puts "Link #{dest_path}"
      end
    end
  end
end

run
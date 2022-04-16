require 'optparse'
require 'csv'

def run
  options = ARGV.getopts('', 'dry-run')
  locations = read_locations('locations.tsv')
  target_paths = find_all_target_path(locations)
  create_symbolic_links(target_paths, options['dry-run'])
  puts 'complete!'
end

def read_locations(path)
  CSV.read(path, col_sep: "\t", headers: false)
end

# @return [Array[Hash]]
def find_all_target_path(locations)
  home_paths + all_location_paths(locations)
end

# home以下の場合にはそのままhome以下に移動
def home_paths
  pwd = Dir.pwd
  home_dir = Dir.home
  Dir.glob('home/**/*', File::FNM_DOTMATCH).filter_map do |path|
    if File.file?(path)
      {
        src: "#{pwd}/#{path}",
        dest: "#{home_dir}#{path.delete_prefix('home')}"
      }
    end
  end
end

# locationsに記載されている場合にはhome以下の指定したパスに移動
def all_location_paths(locations)
  locations.flat_map { |row| location_paths(row) }
end

def location_paths(row)
  pwd = Dir.pwd
  home_dir = Dir.home
  Dir.glob("#{row[0]}/**/*", File::FNM_DOTMATCH).filter_map do |path|
    if File.file?(path)
      {
        src: "#{pwd}/#{path}",
        dest: "#{home_dir}/#{path.sub(row[0], row[1])}"
      }
    end
  end
end

def create_symbolic_links(target_paths, dry_run)
  target_paths.each do |target_path|
    result = link(target_path[:src], target_path[:dest], dry_run)
    puts result
  end
end

def link(src_path, dest_path, dry_run)
  return "Using #{dest_path}" if File.exist?(dest_path)
  return "(dry-run) link from: #{src_path} to: #{dest_path}" if dry_run

  succeed = system('ln', '-s', src_path, dest_path) # spaceをescapeさせるために分割
  succeed ? "Link #{dest_path}" : "Link Failed #{dest_path}"
end

run

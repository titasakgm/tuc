#!/usr/bin/ruby

require 'fileutils'
require 'sqlite3'
require 'zip'

def process(zip)
  dst = nil
  project = nil

  puts "Enter processing ZIP"
  puts "ZIP: #{zip}"
  puts "UNZIP to /tmp/UNZIP"
  dst = "/tmp/UNZIP"
  if !File.exists?(dst)
    Dir.mkdir(dst)
  end
  
  Zip::File.open(zip) do |zip_file|
    # Handle entries one by one
    target = nil
    zip_file.each do |entry|
      next if entry.nil?
      # Extract to file/directory/symlink
      if entry.name =~ /\/$/ # This is a new folder to create
        project = "#{dst}/#{entry.name}".chop
        if !File.exists?(project)
          puts "Make new folder: #{project}"
          Dir.mkdir(project)
        end
      else
        puts "Extracting #{entry.name}"
        dest_file = "#{project}/#{File.basename(entry.name)}"
        puts "dest_file: #{dest_file}"
        entry.extract(dest_file)
      end
    end
    puts "Now all zip files were extracted to #{target}"
  end
end

def zip_exists?(fn,tm)
  #puts "Enter zip_exists?"
  con = SQLite3::Database.new("../db/development.sqlite3")
  sql = "SELECT id FROM tuczips "
  sql += "WHERE filename='#{fn}' AND mtime='#{tm}' "
  #puts "sql: #{sql}"
  res = con.execute(sql)
  con.close
  #puts "res.class: #{res.class}"
  if res.length == 0
    return false
  else
    puts "ZIP: #{fn} already processed!!"
    return true
  end
end

def insert_zip(zip,tm)
  fn = File.basename(zip)
  flag = zip_exists?(fn,tm)
  return if flag

  # if this is the first time
  process(zip)

  # then add entry in tuczips table to prevent next processing
  con = SQLite3::Database.new("../db/development.sqlite3")
  sql = "INSERT INTO tuczips (filename,mtime) "
  sql += "VALUES ('#{fn}','#{tm}') "
  puts "insert_zip:sql #{sql}"
  con.execute(sql)
  con.close
end

# use crontab to trigger process-zip.rb
# keep filename + date in database to prevent double-processing
# unzip to ../tmp
# do business logic with those unzip files

def filetime(f)
  File.mtime(f).to_s
end

# 1 get entries to check for zip files
entries = Dir.glob("/opt/tuc/public/uploads/tucdoc/doc/**/*")
entries.sort.each do |f|
  next if f.downcase !~ /zip$/
  tm = filetime(f)
  puts "Processing ZIP: #{f} @ #{tm}"
  insert_zip(f,tm)
end


#!/usr/bin/ruby
if ARGV.length < 1
  puts "usage: #{$0} SVGFILE"
else
  filepath = ARGV[0]
  filename = filepath.sub /\.svg$/, ''
  filenameonly = filepath.match(/(.*\/)?(.+)\.svg$/)[2]
  system "inkscape --without-gui --file=\"#{filepath}\" --export-pdf=\"#{filename}.pdf\" --export-latex"
  content = IO.read(filename + ".pdf_tex")
  content = content.gsub filenameonly + ".pdf", "billeder/" + filename + ".pdf"
  IO.write(filename + ".pdf_tex", content);
end

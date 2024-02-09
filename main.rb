#!/usr/bin/env ruby

require 'erb'

glyphs = {
  # Consonants
  "d": 'c1',
  "t": 'c2',
  "f": 'c3',
  "g": 'c4',
  "h": 'c5',
  "k": 'c6',
  "l": 'c7',
  "m": 'c8',
  "n": 'c9',
  "p": 'c10',
  "r": 'c19',
  "s": 'c12',
  "b": 'c13',
  "v": 'c14',
  "z": 'c15',
  "q": 'c16', # _th_ing
  "Q": 'c17', # _th_em
  "x": 'c18', # _sk_it
  "X": 'c11', # _k_ämpa
  "c": 'c20', # _ch_urch
  "j": 'c21', # _j_oke
  "N": 'c22', # ng

  # Vowels
  "a": 'v1',
  "e": 'v2',
  "ä": 'v3',
  "o": 'v4',
  "u": 'v5',
  "y": 'v6',
  "å": 'v7',
  "i": 'v8',
  "ö": 'v9',

  # Others
  " ": 'space'
}

class TemplateData
  def initialize(glyphs)
    @glyphs = glyphs
  end

  def get_binding
    binding
  end
end

text = File.open('./example_text.txt', 'r').read.strip

glyph_mapping = text.chars.map do |char|
  "./glyphs/#{glyphs[char.to_sym] || 'unknown'}.png"
end

template_data = TemplateData.new(glyph_mapping)

template = File.open('./template.html.erb', 'r').read

renderer = ERB.new(template)

output = renderer.result(template_data.get_binding)

File.open('./output.html', 'w') do |file|
  file.write(output)
end

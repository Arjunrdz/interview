def check_name(name)
  vowels = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
  idx = 0

  while idx < name.length
    curr_char = name[idx]

    vowel_idx = 0
    while vowel_idx < vowels.length
      if curr_char == vowels[vowel_idx]
        raise ArgumentError, "Vowel #{curr_char} found in name"
      end
      vowel_idx += 1
    end

    idx += 1
  end

  puts "Name #{name} is valid"
end

check_name("Sky")
check_name("Ruby")
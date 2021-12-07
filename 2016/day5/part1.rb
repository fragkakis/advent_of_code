require "digest/md5"

module Day5
  class Part1
    def solve(input)
      password = ""
      i = 0
      while password.length < 8
        md5 = Digest::MD5.hexdigest("#{input}#{i}")
        password << md5[5] if md5[0..4] == "00000"
        i += 1
      end
      password
    end
  end
end

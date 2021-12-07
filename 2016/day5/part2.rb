require "digest/md5"

module Day5
  class Part2
    def solve(input)
      password = {}
      i = 0
      valid_keys = (0..7).to_a.map(&:to_s)
      while password.length < 8
        md5 = Digest::MD5.hexdigest("#{input}#{i}")
        password[md5[5]] = md5[6] if md5[0..4] == "00000" && password[md5[5]].nil? && valid_keys.include?(md5[5])
        i += 1
      end
      password.sort.to_h.values.join
    end
  end
end

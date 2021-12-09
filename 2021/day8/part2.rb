module Day8
  class Part2
    def solve(input)
      lines = input.split("\n")

      lines.map do |line|

        inputs = line.split(" | ")[0].split(" ")
        mapping = build_mapping(inputs)

        outputs = line.split(" | ")[1].split(" ")
        inverse_mapping = mapping.invert
        build_output_number(outputs, inverse_mapping)
      end.sum
    end

    def build_mapping(inputs)
      mapping = {}
      signal_1 = inputs.find { |input| input.length == 2 }.chars
      signal_4 = inputs.find { |input| input.length == 4 }.chars
      signal_7 = inputs.find { |input| input.length == 3 }.chars
      signal_8 = inputs.find { |input| input.length == 7 }.chars
      mapping[:a] = (signal_7 - signal_1).first
      c_f = signal_1
      b_d = signal_4 - signal_1
      e_g = signal_8 - signal_4 - [mapping[:a]]

      signal_2 = inputs.find { |input| input.length == 5 && (e_g - input.chars).empty? }.chars
      signal_3 = inputs.find { |input| input.length == 5 && (c_f - input.chars).empty? }.chars
      signal_5 = inputs.find { |input| input.length == 5 && (signal_2 - input.chars).any? && (signal_3 - input.chars).any? }.chars
      mapping[:e] = (signal_2 - signal_3).first
      mapping[:g] = (e_g - [mapping[:e]]).first
      mapping[:f] = (signal_3 - signal_2).first
      mapping[:c] = (c_f - [mapping[:f]]).first
      mapping[:b] = (signal_5 - signal_3).first
      mapping[:d] = (b_d - [mapping[:b]]).first
      mapping
    end

    def build_output_number(outputs, inverse_mapping)
      outputs.map { |output|
        output.chars
             .map { |c| inverse_mapping[c] }.join }
             .map { |signal| convert_to_int(signal).to_s }
             .join
             .to_i
    end

    def convert_to_int(signal)
      case signal.chars.sort
      when %w[a b c e f g]
        0
      when %w[c f]
        1
      when %w[a c d e g]
        2
      when %w[a c d f g]
        3
      when %w[b c d f]
        4
      when %w[a b d f g]
        5
      when %w[a b d e f g]
        6
      when %w[a c f]
        7
      when %w[a b c d e f g]
        8
      when %w[a b c d f g]
        9
      end
    end
  end
end

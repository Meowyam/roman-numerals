#!/usr/bin/env ruby

class RomanNumeral

    #[0] makes it work in ruby 1.9 and 1.8
    @@roman = {
        'I'[0] => 1,
        'V'[0] => 5,
        'X'[0] => 10,
        'L'[0] => 50,
        'C'[0] => 100,
        'D'[0] => 500,
        'M'[0] => 1000,
        }


    def initialize x
        @x = x.upcase
    end

    def to_integer
        idx = 0

        ans = @@roman[@x[idx]]

        #error if not valid roman numeral
        unless @@roman.has_key?(@x[idx])
            raise ArgumentError, 'Not a valid roman numeral.'
        end

        while idx < @x.length-1
            if @@roman[@x[idx]] == @@roman[@x[idx+1]]
                #D, L, V cannot be repeated
                if [500, 50, 5].include? @@roman[@x[idx]]
                    raise ArgumentError, 'D, L and V cannot be repeated.'
                else
                    #stop if >3 identical numerals in a row
                    if  @x.length > 3 and
                        @@roman[@x[idx+1]] == @@roman[@x[idx-2]]
                         raise ArgumentError, 'Stop, >3 identical numerals in a row.'
                    else
                        ans = ans + @@roman[@x[idx+1]]
                    end
                end

                    
            elsif @@roman[@x[idx+1]] > @@roman[@x[idx]]
                #can't subtract: V, L and D
                if [1, 10, 100, 1000].include? @@roman[@x[idx]]
                    #check rules: only subtract I from V & X; X from L & C; C from D & M.
                    if (@@roman[@x[idx]]== 1 and [5, 10].include? @@roman[@x[idx+1]]) or 
                    (@@roman[@x[idx]]== 10 and [50, 100].include? @@roman[@x[idx+1]]) or
                    (@@roman[@x[idx]]== 100 and [500, 1000].include? @@roman[@x[idx+1]])
                        if idx != 0 and @@roman[@x[idx-1]] >= @@roman[@x[idx+1]]
                            ans = ans + @@roman[@x[idx+1]]
                        else
                            ans = @@roman[@x[idx+1]] - ans
                        end
                    else
                        raise ArgumentError, 'Does not follow subtraction rules'
                    end
                else
                   raise ArgumentError, 'Cant subtract V, L and D.'
               end
            elsif @@roman[@x[idx+1]] < @@roman[@x[idx]]
                #check next numeral
                if @@roman[@x[idx+2]] != nil and @@roman[@x[idx+2]] > @@roman[@x[idx+1]]
                    ans = ans - @@roman[@x[idx+1]]
                else
                    ans = ans + @@roman[@x[idx+1]]
                end
            end

            idx += 1
        end
        
        if (ans >= 1 && ans <= 3999)
            puts ans
        else
            raise ArgumentError, 'Number is not between 1 and 3999'
        end
    end

end

#RomanNumeral.new('XVI').to_integer
#RomanNumeral.new('LVII').to_integer
#RomanNumeral.new('MCMXCVIII').to_integer
#RomanNumeral.new('II').to_integer

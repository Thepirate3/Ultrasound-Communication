function encoded_length = encode_msg_len(msg)
    
    bits = de2bi(length(msg));
    encoded_length = zeros(1,8);
    
    zero_bits = 7 - length(bits);
    encoded_length(1) = 19900;
    flag = 1;
    for i = 1:7
        
        %if we need to fill the array with 0 
        if i > 7 - zero_bits
            %if last bit is 0 we keep the same frequency to complete
            if bits(i-1) == 0
                encoded_length(i+1:end) = encoded_length(i);
            else
                %if last bit was logic 1
                if encoded_length(i) - 300 > 19000
                    encoded_length(i+1:end) = encoded_length(i) - 300;
                else
                    encoded_length(i+1:end) = encoded_length(i) + 300;
                end
            end
            break;
        else
            %first bit
            if i == 1
                if bits(i) == 1
                   %step down with 450 Hz meaning logical 1
                   encoded_length(i+1) = encoded_length(i) - 500;
                else
                   %step down with 300 Hz meaning logical 0
                   encoded_length(i+1) = encoded_length(i) - 300;
                end
            else %this is not first bit
                %we have the same bit 
                if bits(i) ==  bits(i-1) && flag == 0
                   %keep the last frequency
                   encoded_length(i+1) = encoded_length(i);
                   flag = 1;
                elseif bits(i) == 1 && encoded_length(i) - 500 < 19000
                   %we cannot get lower than 19 kHz
                   encoded_length(i+1) = encoded_length(i) + 500;
                   flag = 0;
                elseif bits(i) == 1 && encoded_length(i) - 500 >= 19000
                   %we can use a lower frequency
                   encoded_length(i+1) = encoded_length(i) - 500;
                   flag = 0;
                   
                elseif bits(i) == 0 && encoded_length(i) - 300 < 19000
                   %we cannot get lower than 19 kHz
                   encoded_length(i+1) = encoded_length(i) + 300;
                   flag = 0;
                elseif bits(i) == 0 && encoded_length(i) - 300 >= 19000
                   %we can use a lower frequency
                   encoded_length(i+1) = encoded_length(i) - 300;
                   flag = 0;
                end
                    
            end
        end
       
    end
end